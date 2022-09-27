$(document).ready(function() {
    $(document)
        .on("submit", "#create_question_form", submitCreateQuestionForm)       /* This function will handle the submission of create question via ajax */
        .on("submit", "#update_form", submitUpdateForm)
});

/**
* DOCU: This function is for submiting the add question form and adding the question to the DOM<br>
* Triggered: .on("submit", "#create_question_form", submitCreateQuestionForm)<br>
* Last Updated Date: September 23, 2022
* @author Adrian
*/
function submitCreateQuestionForm(e){
    e.preventDefault();

    let create_question_form = $("#create_question_form");

    /* Submit the create question form via ajax */
    $.post(create_question_form.attr("action"), create_question_form.serialize(), (create_question_response) =>{
        if(create_question_response){
            /* Destructure create_question_response */
            let {form_section_id, form_question} = create_question_response.result;

            $(form_question).insertBefore($(`#form_section_${form_section_id}`).find(".add_question_trigger"));
        }
        else{
            /* TODO: Add error message here */
            alert(create_question_response.error);
        }
    });
}

/**
* DOCU: This function is for updating the form details for form title ir form description<br>
* Triggered: .on("submit", "#create_question_form", submitCreateQuestionForm)<br>
* Last Updated Date: September 27, 2022
* @author Adrian
*/
function submitUpdateForm(e){
    e.preventDefault();

    let submit_form = $("#update_form");

    $.post(submit_form.attr("action"), submit_form.serialize(), function(update_form_details_response){
        if(update_form_details_response.status){
            $("#form_title").val(update_form_details_response.result.title);
        }
        else{
            /* TODO: update error handling */
            alert(update_form_details_response.error);
        }
    });
}