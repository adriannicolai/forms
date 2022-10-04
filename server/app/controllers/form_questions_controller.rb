class FormQuestionsController < ApplicationController
  	# DOCU: This will handle the creation of new forms question
    # Triggered by: (POST) /forms/create_question
	# Requires params - form_id, form_section_id
    # Returns: { status: true/false, result: { form_question }, error }
    # Last updated at: September 23, 2022
    # Owner: Adrian
	def create_form_question
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

	def update_form_question
	end
end
