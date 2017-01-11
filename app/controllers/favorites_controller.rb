class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @favorites = Favorite.all
  end

  def create

  end

  def destroy

  end
end
