class AppliedJobsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_talent!, only: [:create, :destroy]

  def index
    @applied_jobs = current_user.applied_jobs
    render json: @applied_jobs
  end

  def create
    @applied_job = current_user.applied_jobs.build(applied_job_params)
    if @applied_job.save
      render json: @applied_job, status: :created
    else
      render json: @applied_job.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @applied_job = current_user.applied_jobs.find(params[:id])
    @applied_job.destroy
    head :no_content
  end

  private

  def applied_job_params
    params.require(:applied_job).permit(:job_listing_id)
  end

  def authorize_talent!
    unless current_user.role.role_name == 'talent'
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
