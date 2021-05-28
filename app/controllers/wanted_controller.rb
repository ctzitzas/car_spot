class WantedController < ApplicationController
  def index
    # Loads all ads with the ad_type wanted for the wanted page
    @listings = Listing.wanted.eager_load(:user)
  end
end
