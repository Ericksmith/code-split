class User < ApplicationRecord
  has_many :rooms, dependent: :destroy 
  has_many :members
  has_many :chat_rooms, through: :memebers, source: :room

  def name
    email.split('@')[0]
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
