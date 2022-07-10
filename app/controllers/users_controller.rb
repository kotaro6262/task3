class UsersController < ApplicationController
  def index

     @users = User.all
    @book = Book.new
    @user = current_user
  end

  def show
    @book = Book.new
    @user = User.find(params[:id])
  end


  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user.id)
    end
  end
  
   def update
    @user = User.find(params[:id])
    if @user.update(user_params)
        redirect_to user_path(@user.id)
        flash[:notice] = "You have updated user successfully."
    else
      render :edit
    end
   end



   private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
