class Advertisement < ApplicationRecord
  belongs_to :user

  validates :title, presence: true

  enum status: [:created, :published, :closed]
end
