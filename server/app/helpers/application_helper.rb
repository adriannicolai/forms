module ApplicationHelper
    # DOCU: Function to check required and optional fields
    # Triggered by: UsersController
    # Requires: required_fields - [], optional_fields - []
    # Last updated at: July 16, 2022
    # Owner: Adrian
    def check_fields(required_fields = [], optional_fields = [], params)
        response_data = { :status => false, :result => {}, :error => nil }

        begin
            invalid_fields = []
            all_fields     = required_fields + optional_fields

            all_fields.each do |key|
                if params[key].present?
                    response_data[:result][key] = params[key].is_a?(String) ? params[key].strip : params[key]
                elsif required_fields.include?(key)
                    invalid_fields << key
                    response_data[:error] = "Missing required fields"
                end
            end

            response_data.merge!(invalid_fields.empty? ? { :status => true, :result => response_data[:result].symbolize_keys } : { :result => invalid_fields, :error => "Missing required fields" })
        rescue Exception => ex
            response_data[:error] = ex.message
        end

        return response_data
    end

    # DOCU: Function to encrypt password
    # Triggered: by UserModel
    # Requires: password
    # Last updated at: July 17, 2022
    # Owner: Adrian
    def encrypt_password(password)
        Digest::MD5.hexdigest("#{ENV["PASSWORD_PREFIX"]}#{password}password#{ENV["PASSWORD_SUFFIX"]}")
    end

    # DOCU: Function to redirect user to 404 page
    # Triggered by: UsersController, FormsController
    # Last updated at: July 20, 2022
    # Owner: Adrian
    def redirect_to_404
        redirect_to "/404.html"
    end

    # DOCU: Function to redirect user to 500 page
    # Triggered by: UsersController, FormsController
    # Last updated at: July 20, 2022
    # Owner: Adrian
    def redirect_to_500
        redirect_to "/500.html"
    end
end
