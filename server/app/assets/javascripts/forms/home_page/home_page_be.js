$(document).ready(function(){
    $(document)
        .on("submit", "#get_all_forms", submitGetAllForms)       /* This function will submit the get all forms and update the forms list */
        .on("change", "#form_sort_order", updateFormSortOrder)   /* This function will handle the submission of the form sort order  */
        .on("click", "#add_form_button", submitCreateNewForm)    /* This function will submit the submission of the create new form */
        .on("submit", "#delete_form", submitDeleteForm);  /* This function will submit the submission of the delete form */
});

/**
* DOCU: This function will change the sort order of fetching forms and submit the get all form<br>
* Triggered: .on("change", "#form_sort_order", updateFormSortOrder)<br>
* Last Updated Date: July 19, 2022
* @author Adrian
*/
function updateFormSortOrder(){
    let get_all_forms = $("#get_all_forms");

    /* TODO: will update this */
}

/**
* DOCU: This function will handle the submission the get all forms and update the forms list<br>
* Triggered: .on("submit", "#get_all_forms", submitGetAllForms)<br>
* Last Updated Date: July 31, 2022
* @author Adrian
*/
function submitGetAllForms(){
    let get_all_forms = $("#get_all_forms");

    if(parseInt(get_all_forms.data("is_processing")) === BOOLEAN_FIELD.no){
        get_all_forms.data("is_processing", BOOLEAN_FIELD.yes);

        /* TODO: submit form here */
    }
}

/**
* DOCU: This function will trigger the submission of create new form<br>
* Triggered: .on("click", "#add_form_button", submitCreateNewForm)<br>
* Last Updated Date: July 28, 2022
* @author Adrian
*/
function submitCreateNewForm(){
    let create_form = $("#create_form");

    if(parseInt(create_form.data("is_processing")) === BOOLEAN_FIELD.no){
        create_form.data("is_processing", BOOLEAN_FIELD.yes);

        $.post(create_form.attr("action"), create_form.serialize(), function(create_form_response){
            if(create_form_response.status){
                window.open(`/forms/view?id=${create_form_response.result.id}`,"_self");
            }
            else{
                alert(create_form_response.error);
            }

            create_form.data("is_processing", BOOLEAN_FIELD.no);
        });
    }
}

/**
* DOCU: This function will trigger the submission of delete form form and append form details<br>
* Triggered: .on("click", ".delete_form_trigger", submitDeleteForm)<br>
* Last Updated Date: July 28, 2022
* @author Adrian
*/
function submitDeleteForm(e){
    e.preventDefault();

    let deleteForm = $(this);

    if(parseInt(deleteForm.data("is_processing")) === BOOLEAN_FIELD.no){
        deleteForm.data("is_processing", BOOLEAN_FIELD.yes);

        $.post(deleteForm.attr("action"), deleteForm.serialize(), function(delete_form_response){
            deleteForm.data("is_processing", BOOLEAN_FIELD.no);
        });
    }
}