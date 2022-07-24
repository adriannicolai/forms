
YES = 1
NO  = 0

FORM_SETTINGS = {
    respondent_settings:{
        is_editable:{
            editable:     0,
            not_editable: 1
        },
        is_corrent_answer_seen:{
            hidden_answer: 0,
            show_answer:   1
        }
    },
    quiz_mode_settings:{
        is_quiz_mode:{
            not_quiz: 0,
            quiz:     1
        },
    },
    default_value: 0
}

QUESTION_SETTINGS = {
    question: {
    title: "Untitled Question",
    description: "Description",
    choices: ["choice1"],
    },
    question_type: {
        multiple_choice: 0,
        paragraph:       1,
        checkbox:        2,
        dropdown:        3
    },
}

BOOLEAN_FIELD = {
    yes: 1,
    no:  0
}