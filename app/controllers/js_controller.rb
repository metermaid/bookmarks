class UsersController < ApplicationController
  # GET /users/1
  def show
    @user = User.find(params[:id])
    @items = (@user.bookmarks + @user.comments).sort{|x,y| y.created_at <=> x.created_at}
    @items = Kaminari.paginate_array(@items).page(params[:page]).per(7)
    @menu_item = "profile"
  end
end
