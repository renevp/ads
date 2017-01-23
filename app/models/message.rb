class Message < ApplicationRecord
  belongs_to :sender, foreign_key: :sender_id, class_name: User.name
  belongs_to :recipient, foreign_key: :recipient_id, class_name: User.name
  belongs_to :advertisement
  has_ancestry

  validates :body, presence: true

  enum status: [:inbox, :sent]

  scope :user_messages, ->(user) {
    joins(:sender).where(sender: user).or(joins(:sender).where(recipient: user))
  }
  
  scope :advertisement_messages, ->(advertisement) {
    joins(:advertisement).where(advertisement: advertisement)
  }
end
