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

			if create_new_user[:status]
				puts create_new_user
			end
		rescue Exception => ex
			response_data[:error] = ex.message
		end

		return response_data
	end

	def update_user
	end
end
