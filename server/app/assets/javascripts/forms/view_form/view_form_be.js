$(document).ready(function() {
    $(document)
        .on("submit", "#create_question_form", submitCreateQuestionForm)       /* This function will handle the submission of create question via ajax */
});

/**
* DOCU: This function is for submiting the add question form and adding the question to the DOM<br>
* Triggered: .on("submit", "#create_question_form", submitCreateQuestionForm)<br>
* Last Updated Date: September 4, 2022
* @author Adrian
*/
function submitCreateQuestionForm(e){
    e.preventDefault();

    let create_question_form = $("#create_question_form");
    
    /* Sumbmit the create question form via ajax */
    $.post(create_question_form.attr("action"), create_question_form.serialize(), (create_question_response) =>{
        console.log(create_question_response);
        if(create_question_response){
            /* TODO: Append the question here */
        }
        else{
            /* TODO: Add error message here */
        }
    });

}