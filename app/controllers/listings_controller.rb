class ListingsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]

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
  end

  def show
    @listing = Listing.find(params[:id])
    @profile = Profile.find(@listing.user.id)
  end

  private

  def listing_params
    params.require(:listing).permit(:ad_type, :year, :make, :model, :price, :odometer, :engine, :transmission, :trim, :body_style, :registration_number, :roadworthy, :condition, :description)
  end

end
