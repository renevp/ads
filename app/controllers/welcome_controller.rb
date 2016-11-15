class WelcomeController < ApplicationController
  def index
    @advertisements_sell = Advertisement.sell
    @advertisements_buy = Advertisement.buy
  end
end
