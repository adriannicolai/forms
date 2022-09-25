$(document).ready(function () {
    $(document)
        .on("click", ".add_question_trigger", triggerAddQuestion)
        .on("change", "#form_title", triggerUpdateFormDetails);
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
* Triggered: .on("change", "#form_title", triggerUpdateFormDetails);<br>
* Last Updated Date: September 23, 2022
* @author Adrian
*/
function triggerUpdateFormDetails(){
    let update_form_details_form = $("#update_form");

    let form_detail_update_type  = $(this);

    /* Add data needed by the backend and submit the form */
    if(form_detail_update_type.attr("id") === FORM_DETAILS.title){
        update_form_details_form.children(".update_type").val(FORM_DETAILS.title);
    }
    else if(form_detail_update_type.attr("id") === FORM_DETAILS.description){
        update_form_details_form.children(".update_type").val(FORM_DETAILS.description);
    }
}