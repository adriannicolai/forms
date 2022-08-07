$(document).ready(function(){
    $(document)
        .on("click", "#login_user_trigger", () => {                        /* Trigger to submit the log in user form */
            $("#login_user_form").submit();
        })
        .on("click", "#register_user_trigger", () =>{
            $("#register_user_form").submit();
        })
        .on("click", ".show_login_signup_form", showHideLoginOrRegisterForm);   /* Trigger to show the sign up or signin form */

});

/**
* DOCU: This function is userd to handling errors in sign in or sign up pages<br>
* Triggered: submission of sign in or sign up form<br>
* Last Updated Date: August 7, 2022
* @author Adrian
*/
function showHideLoginOrRegisterForm(){
    let register_user_form = $("#register_user_form");
    let login_user_form    = $("#login_user_form");
    let form_action        = $(this).data("form_action") === "show_signup_form";

    if(form_action){
        register_user_form.removeClass("hidden");
        login_user_form.addClass("hidden");
    }
    else{
        register_user_form.addClass("hidden");
        login_user_form.removeClass("hidden");

    }
}

/**
* DOCU: This function is user to handling errors in sign in or sign up pages<br>
* Triggered: submission of sign in or sign up form<br>
*   @param {string} error_message
*   @param {array} error_fields
*   @param {string} error_form
* Last Updated Date: August 7, 2022
* @author Adrian
*/
function showErrorMessageSigninSignup(error_message, error_fields, error_form){
    /* Guard clause for missing required fields */
    if(error_message = null || error_fields == null || error_form == null) return false

    /* TODO: apply error messages after all is done */
    if (error_message === "Missing required fields"){

    }
}