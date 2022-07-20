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
    # Last updated at: July 16, 2022
    # Owner: Adrian
	scope "/forms" do
		get "/" 		   => "forms#home_page"
		post "get_forms"   => "forms#get_forms"
		post "create_form" => "forms#create_form"

		get "/view" 	   => "forms#view_form"
	end

	# root logout
	get "logout" => "users#logout"

	# Root URL
	root "forms#landing_page"
end
