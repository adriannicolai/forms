$(document).ready(function(){
    $(document)
        .on("submit", "#register_user_form", submitRegisterUserForm) /* This handles the submission of register user form */
        .on("submit", "#login_user_form", submitLoginUserForm);      /* This handles the submission of login user form */
});

/**
* DOCU: This function is for submitting the register user form<br>
* Triggered: .on("submit", "#register_user_form", submitRegisterUserForm)<br>
* Last Updated Date: July 28, 2022
* @author Adrian
*/
function submitRegisterUserForm(e){
    e.preventDefault();

    let register_user_form = $(this);

    /* Prevent user from spam clicking the register button */
    if(parseInt(register_user_form.data("is_processing")) === BOOLEAN_FIELD.no){
        register_user_form.data("is_processing", BOOLEAN_FIELD.yes);

        $.post(register_user_form.attr("action"), register_user_form.serialize(), function(register_form_response){
            if(register_form_response.status){
                window.open("/forms","_self");

            }
            else{
                /* TODO: add error handling here */
                alert(register_form_response.error);
            }

            register_user_form.data("is_processing", BOOLEAN_FIELD.no);
        });
    }
}

/**
* DOCU: This function is for submitting the login user form<br>
* Triggered: .on("submit", "#login_user_form", submitLoginUserForm)<br>
* Last Updated Date: July 28, 2022
* @author Adrian
*/
function submitLoginUserForm(e){
    e.preventDefault();

    let login_user_form = $(this);

    /* Prevent user from spam clicking the login button */
    if(parseInt(login_user_form.data("is_processing")) === BOOLEAN_FIELD.no){
        login_user_form.data("is_processing", BOOLEAN_FIELD.yes);

        $.post(login_user_form.attr("action"), login_user_form.serialize(), function(register_form_response){
            if(register_form_response.status){
                window.open("/forms","_self");
            }
            else{
                /* TODO: add error handling here */
                alert(register_form_response.error);
            }

            login_user_form.data("is_processing", BOOLEAN_FIELD.no);
        });
    }
}