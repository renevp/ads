class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :advertisement

  validates_uniqueness_of :user, scope: :advertisement

  scope :user_favorites, ->(user) { joins(:user).where(user: user) }
end
