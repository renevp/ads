class WelcomeController < ApplicationController
  def index
    @advertisements_sell = Advertisement.published_sell
    @advertisements_buy = Advertisement.published_buy
  end
end
