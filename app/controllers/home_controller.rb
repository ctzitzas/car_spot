class HomeController < ApplicationController

  #  Loads the latest listing added to the database
  def index
    @listing = Listing.eager_load(:user, :profile).last
  end
end
