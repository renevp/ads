class Advertisement < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true
  validates :user, presence: true
  validates :status, presence: true
  validates :ad_type, presence: true
  validates :price_cents, presence: true
  validates :amount, presence: true

  enum status: [:created, :published, :closed]
  enum ad_type: [:buy, :sell]

  monetize :price_cents

  scope :published_and_sell, -> { where(status: 'published', ad_type: 'sell')  }
  scope :published_and_buy, -> { where(status: 'published', ad_type: 'buy')  }
  scope :ordered_by_price, -> { order(price_cents: :desc) }
  scope :active_user, -> { joins(:user).where("users.status = 0") }

  scope :user_sell_ads, ->(user) { joins(:user).where(user: user, ad_type: 'sell') }
  scope :user_buy_ads, ->(user) { joins(:user).where(user: user, ad_type: 'buy') }
  scope :user_published_sell_ads, ->(user) { joins(:user).where(user: user, ad_type: 'sell', status: 'published') }
  scope :user_published_buy_ads, ->(user) { joins(:user).where(user: user, ad_type: 'buy', status: 'published') }

  class << self
    def published_sell
      published_and_sell.active_user.ordered_by_price
    end

    def published_buy
      published_and_buy.active_user.ordered_by_price
    end
  end

end
