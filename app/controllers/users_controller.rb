
class UsersController < ApplicationController
  before_action :authenticate_user!, only: [ :edit, :update, :destroy ]
  before_action :owners_only, only: [ :edit, :update, :destroy ]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_user

  def show
    @user = User.find(params[:id])
    if @user == current_user
      @sell_ads = Advertisement.user_all_sell(@user)
      @buy_ads = Advertisement.user_all_buy(@user)
    else
      @sell_ads = Advertisement.user_published_sell(@user)
      @buy_ads = Advertisement.user_published_buy(@user)
    end
  end

  def new
    redirect_to new_user_session_path
  end

  def activate
    @user = User.find(params[:id])
    if @user.update(status: params[:status])
      redirect_to user_path(@user), notice: 'Profile has been activated'
    else
      redirect_to user_path(@user), alert: 'There was a problem trying to activate profile'
    end
  end

  def messages
    @messages = Message.user_messages(current_user)
    render 'messages/index'
  end

  def destroy
    @user = User.find(params[:id])
    if @user.update(status: :inactive)
      redirect_to user_path(@user), notice: 'Profile is now inactive'
    else
      redirect_to user_path(@user), alert: 'There was a problem trying to inactive profile'
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  private

  def owners_only
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to user_path
    end
  end

  def invalid_user
    redirect_to new_user_session_path, alert: "User doesn't exist, please sign up"
  end

end
