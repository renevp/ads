class Advertisement < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true
  validates :user, presence: true
  validates :status, presence: true
  validates :ad_type, presence: true
  validates :price_cents, presence: true

  enum status: [:created, :published, :closed]
  enum ad_type: [:buy, :sell]

  monetize :price_cents

end
