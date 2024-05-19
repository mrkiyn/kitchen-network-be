# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear existing data to avoid duplication and foreign key issues
AppliedJob.destroy_all
JobListing.destroy_all
User.destroy_all
Role.destroy_all

# Create roles
roles = [
  { role_name: 'admin' },
  { role_name: 'moderator' },
  { role_name: 'user' },
  { role_name: 'talent' }
]

roles.each do |role_attributes|
  Role.find_or_create_by!(role_attributes)
end

# Find roles by name
admin_role = Role.find_by(role_name: 'admin')
moderator_role = Role.find_by(role_name: 'moderator')
user_role = Role.find_by(role_name: 'user')
talent_role = Role.find_by(role_name: 'talent')

# Create an admin user and skip confirmation
admin_user = User.new(
  first_name: 'Mark Ian',
  last_name: 'Amado',
  phone_number: '09479601913',
  email: 'amado.markian@gmail.com',
  password: '12345678',
  role: admin_role
)

admin_user.skip_confirmation!
admin_user.save!

# Create additional users
regular_user = User.new(
  first_name: 'Regular',
  last_name: 'User',
  phone_number: '9876543210',
  email: 'user@example.com',
  password: 'password',
  role: user_role
)

regular_user.skip_confirmation!
regular_user.save!

talent_user = User.new(
  first_name: 'Talent',
  last_name: 'User',
  phone_number: '5555555555',
  email: 'talent@example.com',
  password: 'password',
  role: talent_role
)

talent_user.skip_confirmation!
talent_user.save!

# Create job listings
job_listing1 = JobListing.create!(
  title: 'Head Chef',
  description: 'Responsible for kitchen operations',
  requirements: '5+ years experience',
  salary: 60000.00,
  owner_id: regular_user.id
)

job_listing2 = JobListing.create!(
  title: 'Sous Chef',
  description: 'Assist the head chef',
  requirements: '3+ years experience',
  salary: 40000.00,
  owner_id: regular_user.id
)

# Create applied jobs
AppliedJob.create!(
  job_listing_id: job_listing1.id,
  talent_id: talent_user.id
)

AppliedJob.create!(
  job_listing_id: job_listing2.id,
  talent_id: talent_user.id
)

puts "Seeding completed successfully!"
