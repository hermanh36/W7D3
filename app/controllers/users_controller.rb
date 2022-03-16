class UsersController < ApplicationController

  def index
    @users = User.all
    render :index
  end

  def show
    @user = User.find(params[:id])
    redirect_to user_url(@user)
  end

  def new
    @user = User.new
    render :new
  end

  def create 
    @user = User.new(user_params)
    if @user.save
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new, status: 422
    end
  end

  def user_params
    params.require(:user).permit(:username, :password)
  end
end