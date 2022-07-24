$(document).ready(function(){
    $(document)
        .on("submit", "#register_user_form", submitRegisterUserForm) /* This handles the submission of register user form */
        .on("submit", "#login_user_form", submitLoginUserForm);      /* This handles the submission of login user form */
});

/**
* DOCU: This function is for submitting the register user form<br>
* Triggered: .on("submit", "#register_user_form", submitRegisterUserForm)<br>
* Last Updated Date: July 24, 2022
* @author Adrian
*/
function submitRegisterUserForm(e){
    e.preventDefault();

    let registerUserForm = $(this);

    /* Prevent user from spam clicking the register button */
    if(parseInt(registerUserForm.data("is_processing")) === BOOLEAN_FIELD.no){
        registerUserForm.data("is_processing", BOOLEAN_FIELD.yes);

        $.post(registerUserForm.attr("action"), registerUserForm.serialize(), function(register_form_response){
            if(register_form_response.status){
                window.location.replace("/forms");

            }
            else{
                /* TODO: add error handling here */
                alert("error");
            }

            registerUserForm.data("is_processing", BOOLEAN_FIELD.no);
        });
    }
}

/**
* DOCU: This function is for submitting the login user form<br>
* Triggered: .on("submit", "#login_user_form", submitLoginUserForm)<br>
* Last Updated Date: July 24, 2022
* @author Adrian
*/
function submitLoginUserForm(e){
    e.preventDefault();

    let loginUserForm = $(this);

    /* Prevent user from spam clicking the login button */
    if(parseInt(loginUserForm.data("is_processing")) === BOOLEAN_FIELD.no){
        loginUserForm.data("is_processing", BOOLEAN_FIELD.yes);

        $.post(loginUserForm.attr("action"), loginUserForm.serialize(), function(register_form_response){
            if(register_form_response.status){
                window.location.replace("/forms");
            }
            else{
                /* TODO: add error handling here */
                alert("error");
            }

            loginUserForm.data("is_processing", BOOLEAN_FIELD.no);
        });
    }
}