class Message < ApplicationRecord
  belongs_to :sender, foreign_key: :sender_id, class_name: User.name
  belongs_to :recipient, foreign_key: :recipient_id, class_name: User.name
  belongs_to :advertisement

  enum status: [:created, :sent, :read]
end
