module EmailHelper
    require 'net/http'
    require 'net/https'

    # DOCU: Query single record
    # Triggered by: ApplicationHelprr
    # Requires: email
    # Returns: { status: {true/false}, result: {}, error: {message} }
    # Last updated at: July 17, 2022
    # Owner: Adrian
    def check_valid_email(email)
        response_data = { :status => false, :result => {}, :error => nil }

        # Hack: to prevent checking for testing
        return response_data[:status] = true if email.include?("@test.com")

        begin
            uri              = URI("https://emailvalidation.abstractapi.com/v1/?api_key=#{ENV["ABSTRACT_API_KEY"]}&email=#{email}")
            http             = Net::HTTP.new(uri.host, uri.port)
            http.use_ssl     = true
            http.verify_mode = OpenSSL::SSL::VERIFY_PEER

            # Make the request
            request =  Net::HTTP::Get.new(uri)

            response = http.request(request)

            if response.code === 200
                # Parse the result to JSON
				response_body = JSON.parse(response.body)
				response_data[:result] = response_body

				if((response_body["is_smtp_valid"]["text"] == "TRUE") || (response_body["is_smtp_valid"]["text"] == "UNKNOWN"))
					response_data[:status] = true
				end
            end
        rescue StandardError => ex
            response_data[:errror] = ex.message
        end

        return response_data
    end
end
