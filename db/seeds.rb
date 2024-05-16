# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


Role.create([{ role_name: 'admin' }, { role_name: 'moderator' }, { role_name: 'user' }])

# roles = [
#   { role_name: 'admin' },
#   { role_name: 'moderator' },
#   { role_name: 'user' }
# ]

# roles.each do |role_attributes|
#   Role.find_or_create_by!(role_attributes)
# end

# Create an admin user and skip confirmation
admin_role = Role.find_by(role_name: 'admin')

admin_user = User.new(
  first_name: 'Mark Ian',
  last_name: 'Amado',
  phone_number: '09479601913',
  email: 'amado.markian@gmail.com',
  password: ENV['ACCOUNT_PASSWORD'],
  role: admin_role
)

admin_user.skip_confirmation!
admin_user.save!