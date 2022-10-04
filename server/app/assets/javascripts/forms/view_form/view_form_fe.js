$(document).ready(function () {
    $(document)
        .on("click", ".add_question_trigger", triggerAddQuestion)           /* Function to trigger the adding of a question to a form */
        .on("change", "#form_title", triggerUpdateFormDetails)              /* Function to trtigger the updating of form details */
        .on("change", "#form_description", triggerUpdateFormDetails);       /* Function to trigger the updating of form description */
});

/**
* DOCU: This function is for tiggering the add question form<br>
* Triggered: .on("click", ".add_question_trigger", triggerAddQuestion)<br>
* Last Updated Date: September 4, 2022
* @author Adrian
*/
function triggerAddQuestion(){
    /* TODO: to update later to jquery instead of javascript */
    let create_question_form = $("#create_question_form");
    let form_section         = $(this).parent(".form_section");

    /* Add the value form_section_id to the form that will be created */
    document.getElementById("form_section_id").setAttribute("value", form_section.data("section_id"));

    /* Trigger the submit event of add question */
    create_question_form.submit();
}

/**
* DOCU: This function is for tiggering the update form_details form<br>
* Triggered: .on("change", "#form_title", triggerUpdateFormDetails), .on("change", "#form_description", triggerUpdateFormDetails);<br>
* Last Updated Date: October 4, 2022
* @author Adrian
*/
function triggerUpdateFormDetails(){
    let update_form_details_form = $("#update_form");

    /* Get the input who triggered the event */
    let form_update_input  = $(this);

    /* Add data needed by the backend and submit the form */
    if(form_update_input.attr("id") === FORM_DETAILS.title){
        update_form_details_form.children(".update_type").val(FORM_DETAILS.title);

        update_form_details_form.children(".title").val(form_update_input.val());
    }
    else if(form_update_input.attr("id") === FORM_DETAILS.description){
        update_form_details_form.children(".update_type").val(FORM_DETAILS.description);

        update_form_details_form.children(".description").val(form_update_input.val());
    }

    update_form_details_form.submit();
}