include UsersHelper

class UsersController < ApplicationController
	# DOCU: Process adding of company and role, and adding/updating company_cand_preferences record
	# Triggered by: (POST) /user/create_user
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

	# DOCU: Process user login
	# Triggered by: (POST) /user/login
	# Requires: params - first_name, last_name, email, password, confirm_password
	# Returns: { status: true/false, result: { user_details }, error }
	# Last udpated at: July 11, 2022
	# Owner: Adrian
	def login
		response_data = { :status => false, :result => {}, :error => nil }

		begin
			process_user_signin = User.login_user(params)

			# Update the user session
			set_user_session(process_user_signin[:result].symbolize_keys) if process_user_signin[:status]

			response_data.merge!(process_user_signin)
		rescue Exception => ex
			response_data[:error] = ex.message
		end

		render :json => response_data
	end

	def update_user
	end

	# DOCU: Reset session and redirect to landing page
	# Triggered by: (GET) /logout
	# Last udpated at: July 17, 2022
	# Owner: Adrian
	def logout
		reset_session

		redirect_to "/"
	end
end
