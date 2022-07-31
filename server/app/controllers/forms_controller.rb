include ApplicationHelper

class FormsController < ApplicationController
	before_action :check_user_session, except: [:landing_page]

	def landing_page
	end

    # DOCU: home page for forms
    # Triggered by: (GET) /forms
	# Session - user_id
    # Last updated at: July 24, 2022
    # Owner: Adrian
	def home_page
		begin
			@forms = Form.get_form_records({ :fields_to_filter => { :user_id => session[:user_id] }, :fields_to_select => "id, title, cache_response_count AS number_of_responses, updated_at AS last_modified_date" })

			raise @forms[:error] if (@forms[:error].present? && @forms[:error] != "Form not found")
		rescue Exception => ex
			redirect_to_404
		end
	end

	# DOCU: Method for the view form page
    # Triggered by: (GET) /forms
	# Session - user_id
    # Last updated at: July 21, 2022
    # Owner: Adrian
	def view_form
		begin
			@form = Form.get_form_record({ :fields_to_filter => { :id => decrypt(params[:id]) }})

			raise @form[:error] if !@form[:status]
		rescue Exception => ex
			redirect_to_404
		end
	end

	# DOCU: For fetching forms data
    # Triggered by: (POST) /forms/get_forms
    # Returns: { status: true/false, result: { forms_data }, error }
    # Last updated at: July 18, 2022
    # Owner: Adrian
	def get_forms

	end

	# DOCU: This will handle the creation of new forms
    # Triggered by: (POST) /forms/create_forms
	# Session - user_id
    # Returns: { status: true/false, result: { form_data }, error }
    # Last updated at: July 19, 2022
    # Owner: Adrian
	def create_form
		response_data = { :status => false, :result => {}, :error => nil }

		begin
			create_form = Form.create_form(params.merge!({ :user_id => session[:user_id] }))

			response_data.merge!(create_form)
		rescue Exception => ex
			response_data[:error] = ex.message
		end

		render :json => response_data
	end

	# DOCU: This will delete the form
    # Triggered by: (POST) /forms/delete_form
	# Session - user_id
    # Returns: { status: true/false, result, error }
    # Last updated at: July 31, 2022
    # Owner: Adrian
	def delete_form
		response_data = { :status => false, :result => {}, :error => nil }

		begin
			delete_form = Form.delete_form(params.merge!( :user_id => session[:user_id] ))

			response_data.merge!(delete_form)
		rescue Exception => ex
			response_data[:error] = ex.message
		end

		render :json => response_data
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
