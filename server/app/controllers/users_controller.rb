include UsersHelper

class UsersController < ApplicationController
	# DOCU: Process adding of company and role, and adding/updating company_cand_preferences record
	# Triggered by (POST) /user/create_user
	# Requires: params - first_name, last_name, email, password, confirm_password
	# Returns: { status: true/false, result: { user_details }, error }
	# Last udpated at: July 11, 2022
	# Owner: Adrian
	def create_user
		response_data = { :status => false, :result => {}, :error => nil }

		begin
			create_new_user = User.create_user(params)

			# Set the new user session if the creation of new user is successful
			set_user_session(create_new_user[:result].symbolize_keys) if create_new_user[:status]

			response_data.merge!(create_new_user)
		rescue Exception => ex
			response_data[:error] = ex.message
		end

		render :json => response_data
	end

	def update_user
	end
end
