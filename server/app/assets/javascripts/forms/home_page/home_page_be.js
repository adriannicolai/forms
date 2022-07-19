$(document).ready(function(){
    $(document)
        .on("change", "#form_sort_order", updateFormSortOrder)
});

function updateFormSortOrder(){
    let GetAllForms = $("#get_all_forms");

    /* TODO: will update this */
}


function submitGetAllForms(){
    let GetAllForms = $("#get_all_forms");

    if(parseInt(GetAllForms.data("is_processing")) === BOOLEAN_FIELD.no){
        GetAllForms.data("is_processing", BOOLEAN_FIELD.yes1);

        /* TODO: submit form here */
    }
}