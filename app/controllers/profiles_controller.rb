class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show]

  def index
    # Loads all listings for viewing on the profile list page (Not complete)
    @profiles = Profile.all
  end

  def show
  end
  
  private

  def set_profile
    # Eager loads profile, listing, user and location for the profile show page
    @profile = Profile.eager_load(:user, :listing, :location).find(params[:id])
  end
end
