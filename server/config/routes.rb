Rails.application.routes.draw do
	# DOCU: Route for users
    # Triggered by: /user...
    # Last updated at: July 16, 2022
    # Owner: Adrian
	scope "/user" do
		post "/create_user" => "users#create_user"
		post "login"		=> "users#login"
	end

	# DOCU: Route for forms
    # Triggered by: /user...
    # Last updated at: September 4, 2022
    # Owner: Adrian
	scope "/forms" do
		get  "/" 		   		=> "forms#home_page"
		post "/get_form"   		=> "forms#get_form"
		post "/create_form" 	=> "forms#create_form"
		post "/delete_form" 	=> "forms#delete_form"
		post "/update_form"     => "forms#update_form"

		# View form page
		get  "/view" 	   		=> "forms#view_form"
		post "/update_form"	 	=> "forms#update_form"
	end

	scope "form_questions" do
		post "/create_form_question" => "form_questions#create_form_question"
		post "/update_form_question" => "form_questions#update_form_question"
	end

	# root logout
	get "logout" => "users#logout"

	# Root URL
	root "forms#landing_page"
end
