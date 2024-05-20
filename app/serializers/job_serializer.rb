class JobSerializer
    include JSONAPI::Serializer
    attributes :id, :title, :description, :requirements, :salary, :owner_id
  
    attribute :owner_name do |job_listing|
      "#{job_listing.owner.first_name} #{job_listing.owner.last_name}" if job_listing.owner
    end
  
    attribute :created_date do |job_listing|
      job_listing.created_at && job_listing.created_at.strftime('%m/%d/%Y')
    end
  end
  