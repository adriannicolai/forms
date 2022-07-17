$(document).ready(function(){
    $(document)
        .on("submit", "#register_user_form", submitRegisterUserForm) /* This handles the submission of register user form */
});

function submitRegisterUserForm(e){
    e.preventDefault();

    let registerUserForm = $(this);

    $.post(registerUserForm.attr("action"), registerUserForm.serialize(), function(register_form_response){
        console.log(register_form_response);
        if(register_form_response.status){
            window.location.href = "/forms"
        }
        else{
            alert("error")
        }
    });
}