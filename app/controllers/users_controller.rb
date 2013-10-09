class UsersController < ApplicationController
  # GET /users/1
  def show
    @user = User.find(params[:id])
    @items = Kaminari.paginate_array((@user.bookmarks + @user.comments).sort{|x,y| y.created_at <=> x.created_at}).page(params[:page])
    @menu_item = "profile"
  end
end
