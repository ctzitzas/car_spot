class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show]

  def index
    @profiles = Profile.all
  end

  def edit
  end

  def show
  end
  
  private

  def set_profile
    @profile = Profile.eager_load(:user, :listing, :location).find(params[:id])
  end
end
