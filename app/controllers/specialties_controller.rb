class SpecialtiesController < ApplicationController

	# add find user may solve the problem with showing user attributes

	def index
		if params[:query].present?
			@specialties = Specialty.search(params[:query], load: true)
		else
			@specialties = Specialty.all
		end
	end

	def autocomplete
		render json: Specialty.search(params[:query], autocomplete: true, limit: 10).map(&:specialty)
	end

	

	def url_options
	    { profile_name: params[:profile_name] }.merge(super)
    end

    private

  	def find_user
    	@user = User.find_by_profile_name(params[:profile_name])
  	end

end
