class User < ApplicationRecord
  has_many :advertisements

  validates :full_name, presence: true
  validates :username, presence: true
  validates :mobile_number, presence: true
  validates :verified, presence: true
  validates :status, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
