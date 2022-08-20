include ApplicationHelper
include QueryHelper

class Form < ApplicationRecord
    # DOCU: Method to insert candidate for newly created users invited for interview
    # Triggered by: FormsController#create_form
	# Requires: params - user_id
    # Returns: { status: true/false, result: { form_details }, error }
    # Last updated at: July 27, 2022
    # Owner: Adrian
    def self.create_form(params)
        response_data = { :status => false, :result => {}, :error => nil }

        begin
            check_new_form_params = check_fields(["user_id"], [], params)

            if check_new_form_params[:status]
                ActiveRecord::Base.transaction do
                    # Create a new form record
                    created_form_id = insert_record(["
                        INSERT INTO forms (title, user_id, form_settings_json, cache_response_count, created_at, updated_at)
                        VALUES ('untitled form', ?, ?, 0, NOW(), NOW())
                    ", check_new_form_params[:result][:user_id], DEFAULT_FORM_SETTING])

                    # return the encrypted form_id
                    if created_form_id.present?
                        # Create a new template section upon creating a new form
                        create_template_section_record = FormSection.create_form_section_record({ :form_id => created_form_id })

                        if create_template_section_record[:status]
                            response_data[:status]     = true
                            response_data[:result][:id] = encrypt(created_form_id)
                        else
                            raise create_template_section_record[:error] if !create_template_section_record[:status]
                        end
                    else
                        raise "Error creating form record, Please try again later"
                    end
                end
            else
                response_data.merge!(check_new_form_params)
            end

        rescue Exception => ex
            response_data[:error] = ex.message
        end

        return response_data
    end

    # DOCU: Method to get all form details with sections and questions
    # Triggered by FormsController#view_form
	# Requires: params - form_id
    # Returns: { status: true/false, result: form_details, error }
    # Last updated at: August 20, 2022
    # Owner: Adrian
    def self.get_form_details(params)
        response_data = { :status => false, :result => {}, :error => nil }

        begin
            form_details = query_record([
                "SELECT
                    JSON_OBJECTAGG(
                        form_section_id, form_question_details
                    ) AS form_questions
                FROM
                (
                    SELECT
                        JSON_ARRAYAGG(
                            JSON_OBJECT(
                                'form_question_id', form_questions.id,
                                'form_section_id', form_sections.id,
                                'question_title', form_questions.title,
                                'question_choices', form_questions.choices_json,
                                'is_required_question', form_questions.is_required,
                                'question_type_id', question_type_id
                            )) AS form_question_details,
                            form_sections.id AS form_section_id
                        FROM form_sections
                        INNER JOIN form_questions ON form_questions.form_section_id = form_sections.id
                        WHERE form_sections.form_id = ?
                        GROUP BY form_sections.id
                ) AS form_details", params[:form_id] ])

            if form_details["form_questions"].present?
                response_data[:status] = true
                response_data[:result] = JSON.parse(form_details["form_questions"])
            else
                raise "Cannot find form details."
            end
        rescue Exception => ex
            response_data[:error] = ex.message
        end

        return response_data
    end

    # DOCU: Method to get all form details with section and questions
    # Triggered by FormsController#view_form
	# Requires: params - form_id
    # Returns: { status: true/false, result, error }
    # Last updated at: July 31, 2022
    # Owner: Adrian
    def self.delete_form(params)
        response_data = { :status => false, :result => {}, :error => nil }

        begin
            # Check if the for required fields
            check_delete_form_params = check_fields(["form_id", "user_id"], [], params)

            if check_delete_form_params[:status]
                form_id = decrypt(check_delete_form_params[:result][:form_id])

                # Check if the form record is exisiting in the database
                get_form_record = self.get_form_record({
                    :fields_to_filter => { :user_id => check_delete_form_params[:result][:user_id], :id => form_id }
                })

                if get_form_record[:status]
                    ActiveRecord::Base.transaction do
                        # Delete the form_responses associated with the form_id
                        delete_form_responses = FormResponse.delete_form_response({ :fields_to_filter => { :form_id => form_id }})

                        if delete_form_responses[:status]
                            # Delete the form_questions associated with the form_id
                            delete_form_questions = FormQuestion.delete_form_question({ :fields_to_filter => { :form_id => form_id }})

                            if delete_form_questions[:status]
                                # Delete the form_sections associated with the form_id
                                delete_form_sections = FormSection.delete_form_section({ :fields_to_filter => { :form_id => form_id }})

                                if delete_form_sections[:status]
                                    # Delete the form associated with the form_id
                                    delete_form = delete_record([ "DELETE FROM forms WHERE id = ? AND user_id = ? ", form_id, check_delete_form_params[:result][:user_id] ])

                                    # Return the response
                                    if delete_form.present?
                                        response_data[:status] = true
                                    else
                                        raise "Error deleting form, Please try again later"
                                    end
                                else
                                    raise delete_form_sections[:error]
                                end
                            else
                                raise delete_form_questions[:error]
                            end
                        else
                            raise delete_form_responses[:error]
                        end
                    end
                else
                    raise get_form_record[:error]
                end
            else
                response_data.merge!(check_delete_form_params)
            end

        rescue Exception => ex
            response_data[:error] = ex.message
        end

        return response_data
    end

    private
        # DOCU: Method to fetch a single form record
        # Triggered by Forms
        # Requires: params - fields_to_select, fields_to_filter
        # Returns: { status: true/false, result: { form_details }, error }
        # Last updated at: July 20, 2022
        # Owner: Adrian
        def self.get_form_record(params)
            response_data = { :status => false, :result => {}, :error => nil }

            begin
                params[:fields_to_select] ||= "*"

                select_form_query = ["SELECT #{ActiveRecord::Base.sanitize_sql(params[:fields_to_select])} FROM
                    forms WHERE
                "]

                # Add the where clause depending on the fields_to_filter given
                params[:fields_to_filter].each_with_index do |(field, value), index|
                    select_form_query[0] += " #{ 'AND' if index > 0} #{field} = ?"
                    select_form_query << value
                end

                form_details = query_record(select_form_query)

                response_data.merge!(form_details.present? ? { :status => true, :result => form_details } : { :error => "Form not found" } )
            rescue Exception => ex
                response_data[:error] = ex.message
            end

            return response_data
        end

        # DOCU: Method to fetch form records
        # Triggered by Forms
        # Requires: params - fields_to_select, fields_to_filter
        # Returns: { status: true/false, result: { form_details }, error }
        # Last updated at: July 20, 2022
        # Owner: Adrian
        def self.get_form_records(params)
            response_data = { :status => false, :result => {}, :error => nil }

            begin
                params[:fields_to_select] ||= "*"

                select_form_query = ["SELECT #{ActiveRecord::Base.sanitize_sql(params[:fields_to_select])} FROM
                    forms WHERE
                "]

                # Add the where clause depending on the fields_to_filter given
                params[:fields_to_filter].each_with_index do |(field, value), index|
                    select_form_query[0] += " #{ 'AND' if index > 0} #{field} = ?"
                    select_form_query << value
                end

                form_details = query_records(select_form_query)

                response_data.merge!(form_details.present? ? { :status => true, :result => form_details } : { :error => "Form not found" } )
            rescue Exception => ex
                response_data[:error] = ex.message
            end

            return response_data
        end

        # DOCU: Method to set the query settings for order by
        # Triggered by Forms
        # Returns: { status: true/false, result: { query_settings }, error }
        # Last updated at: July 20, 2022
        # Owner: Adrian
        def self.format_page_order_settings(params)
                page_order = case params[:sort_by]
                when "Title ASC"
                    "ORDER BY title ASC"
                when "Title DESC"
                    "ORDER BY title DESC"
                when "Newest"
                    "ORDER BY id ASC"
                when "Oldest"
                    "ORDER BY id DESC"
                when "Last Update"
                    "ORDER BY formss.created_at DESC"
                else
                    "ORDER BY id DESC"
                end

            return page_order
        end

        # DOCU: Method to set the query settings for join statements
        # Triggered by Forms
        # Returns: { status: true/false, result: { query_settings }, error }
        # Last updated at: July 20, 2022
        # Owner: Adrian
        def self.format_page_join_settings(params)
            join_query = ""

            if params[:join_settings][:form_section].present?
            end

            return response_data
        end

        # DOCU: Method to update the form_section record
        # Triggered by Forms
        # Returns: { status: true/false, result: { query_settings }, error }
        # Last updated at: July 25, 2022
        # Owner: Adrian
        def self.update_form_section_record(params)
            response_data = { :status => false, :result => {}, :error => nil }

            begin
                update_form_section_query = ["
                    UPDATE form_sections SET #{params[:fields_to_update].map{ |field, value| "#{field}= '#{ActiveRecord::Base::sanitize_sql(value)}'"}.join(", ")},
                    updated_at = NOW() WHERE
                "]

                params[:fields_to_filter].each_with_index do |(field, value), index|
                    update_form_section_query[0] += " #{'AND' if index > 0 } #{field} #{field.is_a?(Array) ? 'IN(?)' : '=?'}"
                    update_form_section_query << value
                end

                response_data.merge!(update_record(update_form_section_query).present? ? { :status => true } : { :error => "Error in update_form_section_query, please try again later" })
            rescue Exception => ex
                response_data[:error] = ex.message
            end

            return response_data
        end
end
