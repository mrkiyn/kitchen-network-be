class ApplicantSerializer
  include JSONAPI::Serializer
  attributes :id, :talent_name, :email, :phone_number, :application_date, :application_time

  attribute :application_date do |applicant|
    applicant.created_at.strftime("%m-%d-%Y")
  end

  attribute :application_time do |applicant|
    applicant.created_at.strftime("%H:%M")
  end

  attribute :talent_name do |applicant|
    "#{applicant.first_name} #{applicant.last_name}"
  end
end
