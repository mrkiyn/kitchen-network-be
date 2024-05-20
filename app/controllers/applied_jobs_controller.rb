class AppliedJobsController < ApplicationController
	before_action :authenticate_user!
	before_action :authorize_talent

	def index
		@applied_jobs = current_user.applied_jobs
		if @applied_jobs
			render json:{
				status: { code: 200, message: "Fetching applied jobs successful." },
				data: AppliedSerializer.new(@applied_jobs).serializable_hash[:data].map { |job| job[:attributes] }
			}, status: :ok
		else
			render json: { status: { code: 422, message: "No existing applications." } }
		end
	end

	def create
		existing_application = current_user.applied_jobs.find_by(job_listing_id: applied_job_params[:job_listing_id])
	
		if existing_application
			render json: {status: { code: 422, message: "You have already applied for this job listing." } }, status: :unprocessable_entity
		else
			@applied_job = current_user.applied_jobs.build(applied_job_params)

			if @applied_job.save
				render json: {
				status: { code: 200, message: "Creating application successful." },
				data: AppliedSerializer.new(@applied_job).serializable_hash[:data][:attributes]
				}, status: :ok
			else
				render json: { 
				status: { code: 422, message: "Creating application unsuccessful." },
				}, status: :unprocessable_entity
			end
		end
	end


	def destroy
		@applied_job = current_user.applied_jobs.find(params[:id])
		if @applied_job 
			if @applied_job.destroy
				render json: {
					status: {code: 200, message: "Application deletion successful."},
				}, status: :ok
			else
				render json: { 
					status: { code: 422, message: "Application deletion unsuccessful." },
				}, status: :unprocessable_entity
			end
		else
			render json: { 
					status: { code: 422, message: "Application does not exist." },
			}, status: :unprocessable_entity
		end
	end

	private

	def applied_job_params
		params.require(:applied_job).permit(:job_listing_id)
	end

	def authorize_talent
		unless current_user.role.role_name == 'talent'
		render json: { error: 'Unauthorized' }, status: :unauthorized
		end
	end
end
