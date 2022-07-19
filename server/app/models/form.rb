include ApplicationHelper
include QueryHelper

class Form < ApplicationRecord
    # DOCU: Method to insert candidate for newly created users invited for interview
    # Triggered by FormsController#create_form
	# Requires: params - user_id
    # Returns: { status: true/false, result: { form_details }, error }
    # Last updated at: July 19, 2022
    # Owner: Adrian
    def self.create_form(params)
        response_data = { :status => false, :result => {}, :error => nil }

        begin
            check_new_form_params = check_fields(["user_id"], [], params)

            if check_new_form_params[:status]
                create_form = insert_record(["
                    INSERT INTO forms (user_id, form_settings_json, cache_response_count, created_at, updated_at)
                    VALUES (?, ?, 0, NOW(), NOW())
                ", check_new_form_params[:result][:user_id], DEFAULT_FORM_SETTING])

                if create_form.present?
                    response_data[:status] = true
                    response_data[:result] = self.get_form_record({:fields_to_filter => { :id => create_form }})
                else
                    response_data[:error]  = "Error creating form record, Please try again later"
                end
            else
                response_data.merge!(check_new_form_params)
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

        # DOCU: Method to set query setings such as sort order, limit for pagination settings
        # Triggered by Forms
        # Returns: { status: true/false, result: { query_settings }, error }
        # Last updated at: July 20, 2022
        # Owner: Adrian
        def self.format_get_form_query_settings
            response_data = { :status => false, :result => {}, :error => nil }

            begin

            rescue Exception => ex
                response_data[:error] = ex.message
            end

            return response_data
        end
end
