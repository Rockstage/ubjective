class ProfileController < ApplicationController
  before_filter :authenticate_user!
	before_filter :find_user


  def show
  	if @user
  		@specialties = @user.specialties.all
  		@user_educations = @user.user_educations.all
  		@user_languages = @user.user_languages.all
  		render action: :show
  	else
  		render file: 'public/404', status: 404, formats: [:html]
  	end
  end

  private

  def find_user
    @user = User.find_by_profile_name(params[:id])
  end
end
