$(document).ready(function(){
    $(document)
        .on("click", ".delete_form_trigger", triggerSubmitDeleteForm)  /* This function will trigger the submission of the delete form */
        .on("click",".card_clickable_area", function(){
            window.open(`/forms/view?id=${$(this).parent("div").data("ecrypted_form_id")}`, "_blank");
        });
});


/**
* DOCU: This function will trigger the submission of delete form form and append form details<br>
* Triggered: .on("click", ".delete_form_trigger", triggerSubmitDeleteForm)<br>
* Last Updated Date: July 31, 2022
* @author Adrian
*/
function triggerSubmitDeleteForm(){
    let delete_form = $("#delete_form");
    let form_card = $(this).closest("div.form_card_container");

    /* Add the data needed by the back end */
    console.log(form_card.length);
    delete_form.children(".form_id").val(form_card.data("ecrypted_form_id"));

    /* Add identifier for what form_card should be deleted */
    form_card.addClass("form_to_remove");

    delete_form.submit();
}