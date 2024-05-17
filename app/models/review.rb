class Review < ApplicationRecord
    belongs_to :sender, class_name: 'User'
    belongs_to :receiver, class_name: 'User'

    validates :rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
    validates :comment, presence: true
    validate :sender_and_receiver_must_be_different

    private

    def sender_and_receiver_must_be_different
        errors.add("Review sender and receiver can't be the same as sender.") if sender_id == receiver_id
    end
end