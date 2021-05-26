class ListingsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :set_listing, only: [:show, :edit, :update, :destroy]

  def index
    
    @listings = Listing.active.eager_load(:user)
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
    @profile = Profile.eager_load(:user, :location).find(@listing.user.id)
    stripe_session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      client_reference_id: current_user.id,
      customer_email: current_user.email,
      line_items:[{
        amount: (@listing.price * 100).to_i,
        name: (@listing.year + ' ' + @listing.make + ' ' + @listing.model),
        currency: 'aud',
        quantity: 1,
        images: @listing.images.empty? ? nil : [@listing.images.first.service_url]
      }],
      payment_intent_data: {
        metadata: {
          listing_id: @listing.id,
          user_id: current_user.id
        }
      },
      success_url: "#{root_url}/purchases/success?listingId=#{@listing.id}",
      cancel_url: "#{root_url}listings"
    )
    @session_id = stripe_session.id
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
    @listing = Listing.eager_load(:user, :profile).find(params[:id])
  end

end
