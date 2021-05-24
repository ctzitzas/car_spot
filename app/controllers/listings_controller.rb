class ListingsController < ApplicationController
  # load_and_authorize_resource
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :set_listing, only: [:show, :edit, :update, :destroy]

  def index
    @listings = Listing.active
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = current_user.listings.new(listing_params)
    if @listing.save
      redirect_to @listing
    else
      render :new
    end
  end

  def edit
    authorize! :update, @listing
  end

  def update
    if @listing.update(listing_params)
      redirect_to @listing
    else
      render :edit
    end
  end

  def show
    @profile = Profile.find(@listing.user.id)
  end

  def destroy
    authorize! :update, @listing
    @listing.destroy
    flash[:alert] = 'Successfully Deleted'
    redirect_to listings_path
  end

  private

  def listing_params
    params.require(:listing).permit(:ad_type, :year, :make, :model, :price, :odometer, :engine, :transmission, :trim, :body_style, :registration_number, :roadworthy, :condition, :description, :images)
  end

  def set_listing
    @listing = Listing.find(params[:id])
  end

end
