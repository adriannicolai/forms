include ApplicationHelper
include QueryHelper

class FormQuestion < ApplicationRecord
    # DOCU: Method to get all form details with section and questions
    # Triggered by FormsController#create_form
	# Requires: params - form_id, question_type_id, title
    # Optionals: params - choices
    # Returns: { status: true/false, result: form_details,error }
    # Last updated at: September 27, 2022
    # Owner: Adrian
    def self.create_form_question(params)
        response_data = { :status => false, :result => {}, :error => nil }

        begin
            params["title"] ||= "Untitled Question"

            check_form_question_params = check_fields(["form_id", "form_section_id", "question_type_id", "title"], [], params)

            if check_form_question_params[:status]
                ActiveRecord::Base.transaction do
                    # Create a new form question
                    create_form_question = insert_record(["
                        INSERT INTO form_questions (form_id, form_section_id, question_type_id, title, is_required, created_at, updated_at)
                        VALUES (?, ?, ?, ?, ?, NOW(), NOW())
                    ", check_form_question_params[:result][:form_id], check_form_question_params[:result][:form_section_id], check_form_question_params[:result][:question_type_id], check_form_question_params[:result][:title], BOOLEAN_FIELD[:no] ])

                    # Update the form section, append the new question to the question
                    if create_form_question.present?
                        add_question_id_on_form_sections = update_record(["
                            UPDATE form_sections SET
                                form_question_ids = IF(
                                    JSON_CONTAINS(form_question_ids, ?, '$'), form_question_ids, JSON_ARRAY_APPEND(form_question_ids, '$', ?)
                                )
                            WHERE id = ?
                        ", create_form_question, create_form_question, check_form_question_params[:result][:form_section_id]])

                        if add_question_id_on_form_sections.present?
                            response_data[:status] = true
                            response_data[:result] = self.get_form_question_record({:fields_to_filter => {:id => create_form_question}})[:result]
                        else
                            raise "Error in adding form_question_ids, Please try again later"
                        end
                    else
                        raise "Error in creating form question, Please try again later"
                    end
                end
            else
                response_data.merge!(check_form_question_params)
            end
        rescue Exception => ex
            response_data[:error] = ex.message
        end

        return response_data
    end

    # DOCU: Method to prepare the update query of update question
    # Triggered by FormsController#view_form
	# Requires: params - form_id, question_type_id, title
    # Optionals: params - choices, answer
    # Returns: { status: true/false, result: form_details,error }
    # Last updated at: July 26, 2022
    # Owner: Adrian
    def self.update_form_detail(params)
        response_data = { :status => false, :result => {}, :error => nil }

        begin

        rescue Exception => ex
            response_data[:error] = ex.message
        end

        return response_data
    end

    private
        # DOCU: Method to delete a question dynamically
        # Triggered by FormsController, FormQuestion
        # Requires: params - fields_to_filter
        # Returns: { status: true/false, result: form_details, error }
        # Last updated at: July 27, 2022
        # Owner: Adrian
        def self.delete_form_question(params)
            response_data = { :status => false, :result => {}, :error => nil }

            begin
                delete_form_record_query = ["
                    DELETE FROM form_questions WHERE
                "]

                params[:fields_to_filter].each_with_index do |(field, value), index|
                    delete_form_record_query[0] += " #{'AND' if index > 0} #{field} = ?"
                    delete_form_record_query    << value
                end

                response_data.merge!(delete_record(delete_form_record_query).present? ? { :status => true } : { :error => "error in deletinng form_question, Please try again later" })
            rescue Exception => ex
                response_data[:error] = ex.message
            end

            return response_data
        end

        # DOCU: Method to update form question
        # Triggered by FormsController#update_question
        # Requires: params - fields_to_update, fields_to_filter
        # Returns: { status: true/false, result: {}, error }
        # Last updated at: August 25, 2022
        # Owner: Adrian
        def self.update_form_question_details(params)
            response_data = { :status => false, :result => {}, :error => nil }

            begin
                update_form_question_query = ["
                    UPDATE SET #{params[:fields_to_update].map{ |field, value| "#{field}= '#{ActiveRecord::Base.sanitize_sql(value)}'" }.join(",") }
                    WHERE
                "]

                params[:fields_to_update].each_with_index do |(field, value), index|
                    update_form_question_query[0] += "#{' AND' if index > 0} #{field} #{field.is_a?(Array) ? 'IN(?)' : '=?'}"
                    update_form_question_query    << value
                end

                response_data.merge!(update_record(update_form_question_query).present? ? { :status => true } : { :error => "Error in updating form question. Please try again later." })
            rescue Exception => ex
                response_data[:error] = ex.message
            end

            return response_data
        end

        # DOCU: Method to fetch the form_question record dynamically
        # Triggered by FormQuestion#create_form_question
        # Requires: params - fields_to_filter
        # Optionals: params - fields_to_select
        # Returns: { status: true/false, result: {}, error }
        # Last updated at: August 25, 2022
        # Owner: Adrian
        def self.get_form_question_record(params)
            response_data = { :status => false, :result => {}, :error => nil }

            begin
                params["fields_to_select"] ||= "*"

                get_form_question_query = ["
                    SELECT #{ActiveRecord::Base.sanitize_sql(params["fields_to_select"])} FROM
                    form_questions WHERE
                "]

                params[:fields_to_filter].each_with_index do |(field, value), index|
                    get_form_question_query[0] += " #{'AND' if index > 0} #{field} #{field.is_a?(Array) ? 'IN(?)' : '=?'}"
                    get_form_question_query    << value
                end

                form_question = query_record(get_form_question_query)

                if form_question.present?
                    response_data[:status] = true
                    response_data[:result] = form_question
                else
                    response_data[:error] = "No form question record found, Please try again later."
                end
            rescue Exception => ex
                response_data["error"] = ex.message
            end

            return response_data
        end
end
