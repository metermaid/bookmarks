class BookmarksController < ApplicationController
  load_and_authorize_resource
  before_action :set_bookmark, only: [:show, :edit, :update, :destroy]
  before_action :set_menuitem, only: [:index, :new]

  # GET /bookmarks
  def index
    @menu_item = "favourites" if params[:favourites]
    query = Bookmark.scoped
    query = query.tagged_with_all(params[:tags]) if params[:tags]
    query = query.favourites if params[:favourites]
    @bookmarks = query.desc(:created_at).page(params[:page])
    @days = @bookmarks.group_by { |t| t.created_at.beginning_of_day }
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

  # GET
  def autocomplete
    render json: Bookmark.search(params[:query], autocomplete: true, limit: 10).map(&:name)
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
