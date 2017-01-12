class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :owners_only, only: [ :destroy ]

  def index
    @favorites = Favorite.user_favorites(current_user)
  end

  def create
    @favorite = Favorite.new(favorite_params)
    @favorite.user = current_user
    @advertisement = Advertisement.find(@favorite.advertisement.id)
    if @favorite.save
      redirect_to advertisement_path(@advertisement), notice: 'Favorite has been saved'
    else
      redirect_to advertisement_path(@advertisement), alert: 'Ad is already in favorites'
    end
  end

  def destroy
    @favorite.destroy
    redirect_to favorites_path,  notice: 'Favorite has been removed'
  end

  private

  def favorite_params
    params.permit(:user_id, :advertisement_id)
  end

  def owners_only
    @favorite = Favorite.find(params[:id])
    if current_user != @favorite.user
      redirect_to root_path, alert: "You aren't the owner of this favorite!"
    end
  end
end
