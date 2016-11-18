class WelcomeController < ApplicationController
  def index
    @advertisements_sell = Advertisement.published_and_sell
    @advertisements_buy = Advertisement.published_and_buy
  end
end
