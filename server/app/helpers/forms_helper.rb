module FormsHelper
    # DOCU: Get the form question partial location by question type
    # Triggered by: ViewForm
    # Requires: question_type
    # Returns: form_partial_location
    # Last updated at: August 30, 2022
    # Owner: Adrian
    def get_form_question_partial_name(question_type)
        form_partial_location = case question_type.to_i
        when QUESTION_SETTINGS[:question_type][:multiple_choice]
            return "forms/partials/form_question_partials/multiple_choice"
        when QUESTION_SETTINGS[:question_type][:paragraph]
            return "forms/partials/form_question_partials/paragraph"
        when QUESTION_SETTINGS[:question_type][:checkbox]
            return "forms/partials/form_question_partials/checkbox"
        when QUESTION_SETTINGS[:question_type][:dropdown]
            return "forms/partials/form_question_partials/dropdown"
        else
            return "forms/partials/form_question_partials/paragraph"
        end

        return form_partial_location
    end
end
