class JobListingsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user!, only: [:create, :update, :destroy]

  def index
    @job_listings = JobListing.all
    render json: @job_listings
  end

  def show
    @job_listing = JobListing.find(params[:id])
    render json: @job_listing
  end

  def create
    @job_listing = current_user.job_listings.build(job_listing_params)
    if @job_listing.save
      render json: @job_listing, status: :created
    else
      render json: @job_listing.errors, status: :unprocessable_entity
    end
  end

  def update
    @job_listing = JobListing.find(params[:id])
    if @job_listing.update(job_listing_params)
      render json: @job_listing
    else
      render json: @job_listing.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @job_listing = JobListing.find(params[:id])
    @job_listing.destroy
    head :no_content
  end

  private

  def job_listing_params
    params.require(:job_listing).permit(:title, :description, :requirements, :salary)
  end

  def authorize_user!
    unless current_user.role.role_name == 'user'
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
