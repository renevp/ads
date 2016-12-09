class Message < ApplicationRecord
  belongs_to :sender, foreign_key: :sender_id, class_name: User.name
  belongs_to :recipient, foreign_key: :recipient_id, class_name: User.name
  belongs_to :advertisement

  validates :title, presence: true
  validates :body, presence: true

  enum status: [:created, :sent, :read]
end
