class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :first_name, :last_name, :phone_number, :email, :created_at

  attribute :created_date do |user|
    user.created_at && user.created_at.strftime('%m/%d/%Y')
  end

  attribute :role_name do |user|
    user.role.role_name
  end
end