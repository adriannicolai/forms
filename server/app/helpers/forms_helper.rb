module FormsHelper
    # DOCU: Get the form question partial location by question type
    # Triggered by: ViewForm
    # Requires: question_type
    # Returns: form_partial_location
    # Last updated at: August 30, 2022
    # Owner: Adrian
    def get_form_question_partial_name(question_type)
        form_partial_location = "forms/partials/form_question_partials/"

        form_partial_location += case question_type.to_i
        when QUESTION_SETTINGS[:question_type][:multiple_choice]
            return "multiple_choice"
        when QUESTION_SETTINGS[:question_type][:paragraph]
            return "paragraph"
        when QUESTION_SETTINGS[:question_type][:checkbox]
            return "checkbox"
        when QUESTION_SETTINGS[:question_type][:dropdown]
            return "dropdown"
        else
            return "paragraph"
        end

        return form_partial_location
    end
end
