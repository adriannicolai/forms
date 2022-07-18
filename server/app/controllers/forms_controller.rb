class FormsController < ApplicationController
	before_action :check_user_session, except: [:landing_page]

	def landing_page
	end

    # DOCU: home page for forms
    # Triggered by: (GET) /forms
    # Last updated at: July 18, 2022
    # Owner: Adrian
	def home_page

	end

	# DOCU: home page for forms
    # Triggered by: (POST) /forms/get_forms
    # Returns: { status: true/false, result: { forms_data }, error }
    # Last updated at: July 18, 2022
    # Owner: Adrian
	def get_forms

	end

	private
		# DOCU: Redirects the user to the landing page if there is no session
		# Triggered by before_action
		# Session: session - user_id
		# Last udpated at: July 16, 2022
		# Owner:  Adrian
		def check_user_session
			redirect_to "/" if !session[:user_id].present?
		end
end
