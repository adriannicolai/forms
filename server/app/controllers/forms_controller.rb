include ApplicationHelper

class FormsController < ApplicationController
	before_action :check_user_session, except: [:landing_page]

	def landing_page
	end

    # DOCU: home page for forms
    # Triggered by: (GET) /forms
	# Session - user_id
    # Last updated at: August 18, 2022
    # Owner: Adrian
	def home_page
		begin
			@forms = Form.get_form_records({ :fields_to_filter => { :user_id => session[:user_id] }, :fields_to_select => "id, title, cache_response_count AS number_of_responses, DATE_FORMAT(updated_at, '%b %d %Y') AS last_modified_date" })

			raise @forms[:error] if (@forms[:error].present? && @forms[:error] != "Form not found")
		rescue Exception => ex
			redirect_to_404
		end
	end

	# DOCU: Method for the view form page
    # Triggered by: (GET) /forms
	# Session - user_id
    # Last updated at: August 31, 2022
    # Owner: Adrian
	def view_form
		begin
			# Decrypt the form id
			@form = Form.get_form_details({ :form_id => decrypt(params[:id]) })

			raise @form[:error] if !@form[:status]
		rescue Exception => ex
			redirect_to_404
		end
	end

	# DOCU: For fetching form data
    # Triggered by: (POST) /forms/get_form
    # Returns: { status: true/false, result: { forms_data }, error }
    # Last updated at: August 21, 2022
    # Owner: Adrian
	def get_form
		response_data = { :status => false, :result => {}, :error => nil }

		begin
			# Check fields for getting form details
			check_get_form_fields = check_fields(["form_id"], [], params)

			if check_get_form_fields[:status]
				form_details = Form.get_form_record({ :fields_to_select => "form_settings_json", :fields_to_filter => { :id => decrypt(params[:form_id]) }})
			else
				raise "An error occurred while getting form details."
			end
		rescue Exception => ex
			response_data[:error] = ex.message
		end

		render :json => response_data
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

	# DOCU: This will handle the creation of new forms question
    # Triggered by: (POST) /forms/create_question
	# Requires params - form_id, form_section_id
    # Returns: { status: true/false, result: { form_question }, error }
    # Last updated at: September 23, 2022
    # Owner: Adrian
	def create_question
		response_data = { :status => false, :result => {}, :error => nil }

		begin
			# Create a new form question
			create_form_question = FormQuestion.create_form_question({
				"question_type_id" => QUESTION_SETTINGS[:question_type][:paragraph],
				"form_id"          => decrypt(params[:form_id]),
				"form_section_id"  => params[:form_section_id]
			})

			# Guard clause when creating form question is unsuccessful
			raise create_form_question[:error] if !create_form_question[:status]

			# Make the status of the response to true
			response_data[:status] = true

			# Destructure the create_form_question
			form_id, form_title, form_section_id = create_form_question[:result].values_at("form_question", "title", "form_section_id")

			# Render the form question
			response_data[:result][:form_question] = render_to_string :partial => "/forms/partials/form_question_partials/paragraph", :locals => { :form_question => {
				"form_question_id" => form_id,
				"question_title"   => form_title,
			}}

			# Append the form section id to the response
			response_data[:result][:form_section_id] = form_section_id
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

	# DOCU: This will Update the form
    # Triggered by: (POST) /forms/delete_form
	# Session - user_id
    # Returns: { status: true/false, result, error }
    # Last updated at: July 31, 2022
    # Owner: Adrian
	def update_form
		response_data = { :status => false, :result => {}, :error => nil }

		begin
			# Guard clause for update type
			raise "Missing required fields" if !params[:update_type].present?

			response_data.merge!(Form.update_form(params.merge!({ "user_id" => session[:user_id] })))
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
