class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  def create
    @bookmark = Bookmark.find(params[:bookmark_id])

    @comment = @bookmark.comments.create(params[:comment].permit(:body))
    @comment.user = current_user

    if @comment.save
      redirect_to @bookmark, notice: 'Comment was successfully posted.'
    else
      redirect_to @bookmark
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      redirect_to @bookmark, notice: 'Comment was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /comments/1
  def destroy
    @bookmark = Bookmark.find(params[:bookmark_id])
    @comment = @bookmark.comments.find(params[:id])
    @comment.destroy
    redirect_to @bookmark
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
    @bookmark = Bookmark.find(params[:bookmark_id])
    @comment = @bookmark.comments.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.require(:comment).permit(:body, :bookmark_id, :user_id)
    end
end
