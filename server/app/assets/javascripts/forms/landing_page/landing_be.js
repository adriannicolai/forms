$(document).ready(function(){
    $(document)
        .on("submit", "#register_user_form", submitRegisterUserForm) /* This handles the submission of register user form */
        .on("submit", "#login_user_form", submitLoginUserForm);      /* This handles the submission of login user form */
});

/**
* DOCU: This function is for submitting the register user form<br>
* Triggered: .on("submit", "#register_user_form", submitRegisterUserForm)<br>
* Last Updated Date: July 17, 2022
* @author Adrian
*/
function submitRegisterUserForm(e){
    e.preventDefault();

    let registerUserForm = $(this);

    $.post(registerUserForm.attr("action"), registerUserForm.serialize(), function(register_form_response){
        if(register_form_response.status){
            window.location.href = "/forms";
        }
        else{
            /* TODO: add error handling here */
            alert("error");
        }
    });
}

/**
* DOCU: This function is for submitting the login user form<br>
* Triggered: .on("submit", "#login_user_form", submitLoginUserForm)<br>
* Last Updated Date: July 17, 2022
* @author Adrian
*/
function submitLoginUserForm(e){
    e.preventDefault();

    let loginUserForm = $(this);

    $.post(loginUserForm.attr("action"), loginUserForm.serialize(), function(register_form_response){
        if(register_form_response.status){
            window.location.href = "/forms";
        }
        else{
            /* TODO: add error handling here */
            alert("error");
        }
    });
}