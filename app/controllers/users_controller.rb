class UsersController < ApplicationController
before_action :set_user, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to new_session_path
    else
      render :new
    end
  end
  def show
    @user = User.find(params[:id])
  end
  def edit
    @user = User.find(params[:id])
  end
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'Profile successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :photo, :photo_cache)
  end
  def set_user
    @user = User.find(params[:id])
  end
end
