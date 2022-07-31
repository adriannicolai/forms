$(document).ready(function(){
    $(document)
        .on("click", ".delete_form_trigger", triggerSubmitDeleteForm);  /* This function will trigger the submission of the delete form */
});


/**
* DOCU: This function will trigger the submission of delete form form and append form details<br>
* Triggered: .on("click", ".delete_form_trigger", triggerSubmitDeleteForm)<br>
* Last Updated Date: July 28, 2022
* @author Adrian
*/
function triggerSubmitDeleteForm(){
    let delete_form = $("#delete_form");
    let form_card   = $(this).parent("div");

    delete_form.find(".form_id").val(form_card.data("ecrypted_form_id"));

    delete_form.submit();
}