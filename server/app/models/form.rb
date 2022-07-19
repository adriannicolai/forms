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

                else

                end
            else
                response_data.merge!(check_new_form_params)
            end

        rescue Exception => ex
            response_data[:error] = ex.message
        end

        return response_data
    end

end
