class WantedController < ApplicationController
  def index
    @listings = Listing.wanted.eager_load(:user)
  end
end
