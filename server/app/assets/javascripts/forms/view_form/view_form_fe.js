$(document).ready(function () {
    $(document)
        .on("click", ".add_question_trigger", triggerAddQuestion)
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