class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  has_many :owned_job_listings, class_name: 'JobListing', foreign_key: 'owner_id', dependent: :destroy
  has_many :applied_jobs, foreign_key: 'talent_id', dependent: :destroy
  belongs_to :role

  validates :first_name, :last_name, :email, :role_id, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable, :rememberable
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable, :confirmable,
         :jwt_authenticatable, jwt_revocation_strategy: self
end
