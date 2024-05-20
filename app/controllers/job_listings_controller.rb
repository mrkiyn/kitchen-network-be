class JobListingsController < ApplicationController
	before_action :authenticate_user!
	before_action :ensure_confirmed_user
	before_action :authorize_user, only: [:create, :update, :destroy, :applicants]

	def index
		@job_listings = JobListing.all
		if @job_listings
			render json: {
			status: { code: 200, message: "Job listing fetching successful." },
			data: JobSerializer.new(@job_listings).serializable_hash[:data].map { |job| job[:attributes] }
		}, status: :ok
		else
			render json: {
			status: { code: 422, message: "No existing job listings." },
		}, status: :unprocessable_entity
		end
	end

	def show
		@job_listing = JobListing.find(params[:id])
		render json: {
			status: {code: 200, message: "Job fetching successful."},
			data: JobSerializer.new(@job_listing).serializable_hash[:data][:attributes]
		}, status: :ok
	end

	def create
		@job_listing = current_user.owned_job_listings.new(job_listing_params)
		if @job_listing.save
			render json: {
				status: {code: 200, message: "Job listing creation successful."},
				data: JobSerializer.new(@job_listing).serializable_hash[:data][:attributes]
			}, status: :ok
		else
			render json: { code: 422, error: "Job creation unsuccesful."}, status: :unprocessable_entity
		end
	end

	def update
		@job_listing = current_user.owned_job_listings.find(params[:id])

		if @job_listing
			if @job_listing.update(job_listing_params)
				render json: {
					status: {code: 200, message: "Job listing update successful."},
					data: JobSerializer.new(@job_listing).serializable_hash[:data][:attributes]
				}, status: :ok
				else
				render json: {
					status: {code: 422, message: "Job listing update unsuccessful."},
					data: JobSerializer.new(@job_listing).serializable_hash[:data][:attributes]
				}, status: :unprocessable_entity
			end
		else
			render json: { 
					status: { code: 422, message: "Job listing does not exist." },
			}, status: :unprocessable_entity
		end
	end

	def destroy
		@job_listing = current_user.owned_job_listings.find(params[:id])
		if @job_listing
			if @job_listing.destroy
				render json: {
					status: {code: 200, message: "Job listing deletion successful."},
				}, status: :ok
			else
				render json: { 
					status: { code: 422, message: "Job listing deletion unsuccessful." },
				}, status: :unprocessable_entity
			end
		else
			render json: { 
					status: { code: 422, message: "Job listing does not exist." },
			}, status: :unprocessable_entity
		end
	end

	def applicants
		@job_listing = current_user.owned_job_listings.find(params[:id])

		if @job_listing
			@applicants = @job_listing.applicants.select("users.*, applied_jobs.created_at AS \"application_time\"")
		
			render json: {
				status: { code: 200, message: "Fetching applicants successful." },
				data: ApplicantSerializer.new(@applicants).serializable_hash[:data].map { |job| job[:attributes] }
			}, status: :ok
		else
			render json: { 
					status: { code: 422, message: "Job listing does not exist." },
			}, status: :unprocessable_entity
		end
	end

  	private

	def job_listing_params
		params.require(:job_listing).permit(:title, :description, :requirements, :salary)
	end

	def authorize_user
		unless current_user.role.role_name == 'user'
		render json: { error: 'Unauthorized' }, status: :unauthorized
		end
	end

	def ensure_confirmed_user
		unless current_user.confirmed?
			render json: { error: "User account is not confirmed" }, status: :unauthorized
		end
	end
end
