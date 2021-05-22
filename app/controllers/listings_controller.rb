class ListingsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]

  def index
    @listings = Listing.active
  end

  def new
    @listing = Listing.new
  end

  def edit
  end

  def show
    @listing = Listing.find(params[:id])
    @profile = Profile.find(@listing.user.id)
  end

end
