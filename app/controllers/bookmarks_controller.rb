class BookmarksController < ApplicationController
  load_and_authorize_resource
  skip_load_and_authorize_resource only: :ajax_create
  before_action :set_bookmark, only: [:show, :edit, :update, :destroy]
  before_action :set_menuitem, only: [:index, :new]
  respond_to :js, :html

  # GET /bookmarks
  def index
    @menu_item = "favourites" if params[:favourites]
    query = Bookmark.scoped
    query = query.tagged_with_all(params[:tags]) if params[:tags]
    query = query.by_date(params[:date]) if params[:date]
    query = query.favourites if params[:favourites]
    @bookmarks = query.desc(:created_at).page(params[:page])
    @days = @bookmarks.group_by { |t| t.created_at.beginning_of_day }
  end

  # GET /bookmarks/feed
  def feed
    bookmarks = Bookmark.desc(:created_at)
    @title = "Bookmarks"
    @days = bookmarks.group_by { |t| t.created_at.beginning_of_day } 
    @updated = bookmarks.first.updated_at unless bookmarks.empty?

    respond_to do |format|
      format.atom { render :layout => false }
      format.rss { redirect_to feed_path(:format => :atom), :status => :moved_permanently }
    end

  end

  # GET /bookmarks/search
  def search
    @bookmarks = Bookmark.search params[:query], page: params[:page]
  end

  # GET /bookmarks/1
  def show
  end

  # GET /bookmarks/new
  def new
    @bookmark = Bookmark.new
  end

  # GET /bookmarks/1/edit
  def edit
  end

  # GET /bookmarks/ajax_create
  def ajax_create
    if session[:user_id]
      begin
        current_user ||= User.find(session[:user_id])
      rescue Mongoid::Errors::DocumentNotFound
        render :json => { "logged_in" => false }.to_json, :callback => params[:callback]
      end

      @bookmark = Bookmark.new(url: params[:url])
      @bookmark.user = current_user

      @bookmark.save
      render :json => @bookmark, :callback => params[:callback]
    else
      render :json => { "logged_in" => false }.to_json, :callback => params[:callback]
    end

  end

  # POST /bookmarks
  def create
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.user = current_user

    if @bookmark.save
      redirect_to @bookmark, notice: 'Bookmark was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /bookmarks/1
  def update
    if @bookmark.update(bookmark_params)
      redirect_to @bookmark, notice: 'Bookmark was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /bookmarks/1
  def destroy
    @bookmark.destroy
    redirect_to bookmarks_url, notice: 'Bookmark was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bookmark
      @bookmark = Bookmark.find(params[:id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_menuitem
      @menu_item = params[:action]
    end

    # Only allow a trusted parameter "white list" through.
    def bookmark_params
      params.require(:bookmark).permit(:title, :description, :user, :url, :tags, :favourite)
    end
end
