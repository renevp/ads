
class UsersController < ApplicationController
  before_action :authenticate_user!, only: [ :edit, :update, :destroy ]
  before_action :set_user, only: [:edit, :update, :destroy, :username, :show, :activate]
  before_action :owners_only, only: [ :edit, :update, :destroy, :username ]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_user

  def show
    if @user == current_user
      @sell_ads = Advertisement.user_all_sell(@user)
      @buy_ads = Advertisement.user_all_buy(@user)
    else
      @sell_ads = Advertisement.user_published_sell(@user)
      @buy_ads = Advertisement.user_published_buy(@user)
    end

    @reviews = Review.user_reviews(@user)
  end

  def new
    redirect_to new_user_session_path
  end

  # TODO - Check if this function is required
  def username
    @user.username = ""
  end

  def activate
    if @user.update(status: params[:status])
      redirect_to user_path(@user), notice: 'Profile has been activated'
    else
      redirect_to user_path(@user), alert: 'There was a problem trying to activate profile'
    end
  end

  def destroy
    if @user.update(status: :inactive)
      redirect_to user_path(@user), notice: 'Profile is now inactive'
    else
      redirect_to user_path(@user), alert: 'There was a problem trying to inactive profile'
    end
  end

  def update
    if @user.update(user_params)
      redirect_to root_path, notice: 'Username was successfully created.'
    else
      render :username
    end
  end

  def user_params
    params.require(:user).permit(:username)
  end

  private

  def owners_only
    if current_user != @user
      redirect_to user_path
    end
  end

  def invalid_user
    redirect_to new_user_session_path, alert: "User doesn't exist, please sign up"
  end

  def set_user
    @user = User.find(params[:id])
  end

end
