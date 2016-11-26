class WelcomeController < ApplicationController
  def index
    @advertisements_sell = Advertisement.published_sell_ordered_by_price
    @advertisements_buy = Advertisement.published_and_buy_ordered_by_price
  end
end
