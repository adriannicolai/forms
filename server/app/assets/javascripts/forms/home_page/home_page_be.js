$(document).ready(function(){
    $(document)
        .on("submit", "#get_all_forms", submitGetAllForms)      /* This function will submit the get all forms and update the forms list */
        .on("change", "#form_sort_order", updateFormSortOrder)   /* This function will handle the submission of the form sort order  */
        .on("click", "#add_form_button", submitCreateNewForm);   /* This function will trigger the submission of the create new form */
});

/**
* DOCU: This function will change the sort order of fetching forms and submit the get all form<br>
* Triggered: .on("change", "#form_sort_order", updateFormSortOrder)<br>
* Last Updated Date: July 19, 2022
* @author Adrian
*/
function updateFormSortOrder(){
    let GetAllForms = $("#get_all_forms");

    /* TODO: will update this */
}

/**
* DOCU: This function will handle the submission the get all forms and update the forms list<br>
* Triggered: .on("submit", "#get_all_forms", submitGetAllForms)<br>
* Last Updated Date: July 19, 2022
* @author Adrian
*/
function submitGetAllForms(){
    let GetAllForms = $("#get_all_forms");

    if(parseInt(GetAllForms.data("is_processing")) === BOOLEAN_FIELD.no){
        GetAllForms.data("is_processing", BOOLEAN_FIELD.yes1);

        /* TODO: submit form here */
    }
}

/**
* DOCU: This function will trigger the submission of create new form<br>
* Triggered: .on("click", "#add_form_button", submitCreateNewForm)<br>
* Last Updated Date: July 27, 2022
* @author Adrian
*/
function submitCreateNewForm(){
    let createForm = $("#create_form");

    if(parseInt(createForm.data("is_processing")) === BOOLEAN_FIELD.no){
        createForm.data("is_processing", BOOLEAN_FIELD.yes);

        $.post(createForm.attr("action"), createForm.serialize(), function(create_form_response){
            if(create_form_response.status){
                window.open(`/forms/view?id=${create_form_response.result.id}`,"_self")
            }
            else{
                alert(create_form_response.error);
            }

            createForm.data("is_processing", BOOLEAN_FIELD.no);
        });
    }
}