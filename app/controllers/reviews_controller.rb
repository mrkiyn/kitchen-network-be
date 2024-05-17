class ReviewsController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_confirmed_user
	before_action :set_review, only: [:show, :destroy]
    

    def create
		@review = current_user.sent_reviews.build(review_params)
		if @review.save
			render json: {
				status: {code: 200, message: "Review creation successful."},
				data: ReviewSerializer.new(@review).serializable_hash[:data][:attributes]
			}, status: :ok
		else
		  	render json: { error: "Review creation failed."}, status: :unprocessable_entity
		end
	end
  
    def show
		render json: {
		  	status: { code: 200, message: "Review retrieval successful." },
		  	data: ReviewSerializer.new(@review).serializable_hash[:data][:attributes]
		}, status: :ok
	end

	def destroy
		if @review.destroy
		  	render json: { 
				status: { code: 200, message: "Review deleted successfully." },
			}, status: :ok
		else
			render json: { 
				status: { code: 422, message: "Review deletion failed." },
			}, status: :unprocessable_entity
		end
	end
  
    private

    def review_params
        params.require(:review).permit(:receiver_id, :rating, :comment)
    end
  
    def set_review
      	@review = Review.find(params[:id])
    end
  
    def ensure_confirmed_user
		unless current_user.confirmed?
			render json: { error: "User account is not confirmed" }, status: :unauthorized
		end
    end

  end
  
