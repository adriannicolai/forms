include ApplicationHelper
include QueryHelper

class FormSection < ApplicationRecord
    # DOCU: Method to insert form section record
    # Triggered by FormsController#create_form
	# Requires: params - user_id
    # Returns: { status: true/false, error }
    # Last updated at: July 27, 2022
    # Owner: Adrian
    def self.create_form_section_record(params)
        response_data = { :status => false, :result => {}, :error => nil }

        begin
            create_form_section_id = insert_record(["
                INSERT INTO form_sections (form_id, form_question_ids, created_at, updated_at)
                VALUES (?, '[]', NOW(), NOW())", params[:form_id]
            ])

            # Create a new form question after creating a section
            if create_form_section_id.present?
                create_form_question = FormQuestion.create_form_question({
                    "question_type_id" => QUESTION_SETTINGS[:question_type][:paragraph],
                    "form_id"          => params[:form_id],
                    "form_section_id"  => create_form_section_id
                })

                if create_form_question[:status]
                    response_data.merge!(create_form_question)
                else
                    raise create_form_question[:error]
                end
            else
                raise "Somethign went wrong in creatting form section, Please try again later"
            end
        rescue Exception => ex
            response_data[:error] = ex.message
        end

        return response_data
    end
end
