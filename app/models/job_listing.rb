class JobListing < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
  has_many :applied_jobs, dependent: :destroy
  has_many :talents, through: :applied_jobs, source: :user

  validates :title, :description, :requirements, :salary, presence: true
end
