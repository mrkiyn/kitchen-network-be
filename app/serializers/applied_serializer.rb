class AppliedSerializer
    include JSONAPI::Serializer
    attributes :id, :talent_id, :application_date, :application_time, :job

    attribute :application_date do |applied_job|
        applied_job.created_at && applied_job.created_at.strftime('%m-%d-%Y')
    end

    attribute :application_time do |applied_job|
        applied_job.created_at && applied_job.created_at.strftime('%H:%M')
    end

    attribute :job do |applied_job|
        applied_job.job_listing
    end
end
  