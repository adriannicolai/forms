include ApplicationHelper
include UsersHelper
class User < ApplicationRecord
    # DOCU: Method to insert candidate for newly created users invited for interview
    # Triggered by UsersController#create_user
	# Requires: params - first_name, last_name, email, password, confirm_password
    # Returns: { status: true/false, result: { user_details }, error }
    # Last updated at: July 16, 2022
    # Owner: Adrian
    def self.create_user(params)
        response_data = { :status => false, :result => {}, :error => nil }

        begin
            # Validate for reqired fields
            check_user_params = check_fields(["first_name", "last_name", "email", "password", "confirm_password"], [], params)

            # Validate for user information
            if check_user_params[:status]
                validate_user_details = validate_new_user_info(check_user_params[:result])

                if validate_user_details[:status]

                else
                    response_data.merge!(validate_user_details)
                end
            else
                response_data.merge!(check_user_params)
            end

        rescue Exception => ex
            response_data[:error] = ex.message
        end

        return response_data
    end
end
