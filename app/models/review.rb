class Review < ApplicationRecord
  belongs_to :reviewer, foreign_key: :reviewer_id, class_name: User.name
  belongs_to :reviewee, foreign_key: :reviewee_id, class_name: User.name

  validates :feedback, presence: true

  enum rating: [:positive, :negative]

  scope :user_reviews, ->(user) {
    joins(:reviewee).where(reviewee: user)
  }

  scope :users_reviews, ->(reviewee, reviewer) {
    where(reviewee: reviewee, reviewer: reviewer)
  }

end
