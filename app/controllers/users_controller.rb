class UsersController < ApplicationController

  def index
    @user = User.where("id != #{current_user.id}"
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = "User created successfully"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
