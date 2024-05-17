class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  belongs_to :role
  has_many :sent_reviews, class_name: 'Review', foreign_key: 'sender_id'
  has_many :received_reviews, class_name: 'Review', foreign_key: 'receiver_id'
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable, :rememberable
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable, :confirmable,
         :jwt_authenticatable, jwt_revocation_strategy: self
end
