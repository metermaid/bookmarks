class BookmarksController < ApplicationController
  load_and_authorize_resource
  before_action :set_bookmark, only: [:show, :edit, :update, :destroy]

  # GET /bookmarks
  def index
    order = params[:order]
    tags = params[:tags] || ''
    find_options = {
       :per_page => params[:per_page] || 7,
       :page => params[:page] || 1,
       :order => order
    }
    @bookmarks = Bookmark.tagged_with_all(params[:tags]).paginate(find_options)
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bookmark
      @bookmark = Bookmark.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def bookmark_params
      params.require(:bookmark).permit(:title, :description, :user, :url, :tags)
    end
end
