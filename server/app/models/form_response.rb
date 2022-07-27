class FormResponse < ApplicationRecord

    private
        # DOCU: Method to delete a form_response dynamically
        # Triggered by FormsController, FormSection
        # Requires: params - fields_to_filter
        # Returns: { status: true/false, result: form_details, error }
        # Last updated at: July 26, 2022
        # Owner: Adrian
        def self.delete_form_response(params)
            response_data = { :status => false, :result => {}, :error => nil }

            begin
                # Delete all questions from

                delete_form_record_query = ["
                    DELETE FROM form_responses WHERE
                "]

                params[:fields_to_filter].each_with_index do |(field, value), index|
                    delete_form_record_query[0] += " #{'AND' if index > 0} #{field} = ?"
                    delete_form_record_query    << value
                end

                response_data.merge!(delete_record(delete_form_record_query).present? { :status => true } : { :error => "error in deletinng form_question, Please try again later" })
            rescue Exception => ex
                response_data[:error] = ex.message
            end

            return response_data
        end
end
