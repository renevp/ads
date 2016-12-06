class User < ApplicationRecord
  has_many :advertisements
  has_many :sent_messages, :class_name => 'Message', :foreign_key => 'sender_id'
  has_many :received_messages, :class_name => 'Message', :foreign_key => 'recipient_id'

  validates :full_name, presence: true
  validates :username, presence: true
  validates :mobile_number, presence: true

  enum status: [:active, :inactive]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

end
