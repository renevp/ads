
class UsersController < ApplicationController
  before_action :authenticate_user!, only: [ :edit, :update, :destroy ]
  # before_action :active_users_only, only: [ :show ]
  before_action :owners_only, only: [ :edit, :update, :destroy ]

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user), notice: 'Profile has been created'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to user_path(@user), notice: 'Profile has been updated'
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.update_attributes(status: :inactive)
      redirect_to user_path(@user), notice: 'Profile is now inactive'
    else
      redirect_to user_path(@user), notice: 'There was a problem trying to inactive profile'
    end
  end

  private

  def active_users_only
    @user = User.find(params[:id])
    unless @user.status == 'active'
      redirect_to advertisements_path
    end
  end

  def user_params
    params.require(:user).permit(:email, :password, :full_name, :username, :status, :verified, :mobile_number)
  end

  def owners_only
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to user_path
    end
  end

end
