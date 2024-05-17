class ReviewSerializer
    include JSONAPI::Serializer
    attributes :id, :sender_id, :receiver_id, :rating, :comment, :created_at
  
    attribute :created_date do |review|
      review.created_at && review.created_at.strftime('%m/%d/%Y')
    end
  
    attribute :sender_full_name do |review|
        "#{review.sender.first_name} #{review.sender.last_name}"
    end

    attribute :receiver_full_name do |review|
        "#{review.receiver.first_name} #{review.receiver.last_name}"
    end
end
  