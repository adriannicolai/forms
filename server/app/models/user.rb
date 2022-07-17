include ApplicationHelper
include UsersHelper
include QueryHelper

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
                    create_new_user = insert_record(["
                        INSERT INTO users (first_name, last_name, email, password, created_at, updated_at)
                        VALUES (?, ?, ?, ?, NOW(), NOW())
                    ", check_user_params[:result][:first_name], check_user_params[:result][:last_name], check_user_params[:result][:email], encrypt_password(check_user_params[:result][:password])])

                    if create_new_user.present?
                        response_data[:status] = true
                        response_data[:result] = self.get_user_record({ :fields_to_filter => { :id => create_new_user }})[:result]
                    else
                        response_data[:error] = "Something went wrong with creating a new user, Please try again later"
                    end
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

    # DOCU: Method for processing the login for users
    # Triggered by UsersController#create_user
	# Requires: params - first_name, last_name, email, password, confirm_password
    # Returns: { status: true/false, result: { user_details }, error }
    # Last updated at: July 16, 2022
    # Owner: Adrian
    def self.login_user(params)
        response_data = { :status => false, :result => {}, :error => nil }

        begin
            #Validate user parameters
            check_user_params = check_fields(["email", "password"], [], params)

            if check_user_params[:status]
                # Find the user record
                user_details = self.get_user_record({ :fields_to_filter => { :email => check_user_params[:result][:email].downcase, :password => encrypt_password(check_user_params[:result][:password]) }})

                # Add the user details to be returned
                response_data.merge!(user_details)
            else
                response_data.merge!(check_user_params)
            end

        rescue Exception => ex
            response_data[:error] = ex.message
        end

        return response_data
    end

    private
        # DOCU: Method to insert candidate for newly created users invited for interview
        # Triggered by UsersController#create_user
        # Requires:  params - fields_to_filter
        # Optionals: params - fields_to_select
        # Returns: { status: true/false, result: { user_details }, error }
        # Last updated at: July 17, 2022
        # Owner: Adrian
        def self.get_user_record(params)
            response_data = { :status => false, :result => {}, :error => nil }

            begin
                params[:fields_to_select] ||= "*"

                select_user_query = ["SELECT #{ActiveRecord::Base.sanitize_sql(params[:fields_to_select])} FROM users
                #{ ' WHERE'if params[:fields_to_filter].present?}"]

                # Add to the where clause
                if params[:fields_to_filter].present?
                    params[:fields_to_filter].each_with_index do |(field, value), index|
                        select_user_query[0] += "#{' AND' if index > 0} #{field} #{field.is_a?(Array) ? 'IN(?)' : '= ?'}"
                        select_user_query << value
                    end
                end

                user_details = query_record(select_user_query)

                response_data.merge!(user_details.present? ? { :status => true, :result => user_details } : { :error => "User not found" })
            rescue Exception => ex
                response_data[:error] = ex.message
            end

            return response_data
        end
end
