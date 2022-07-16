Rails.application.routes.draw do
	# DOCU: Route for users
    # Triggered by: /user...
    # Last updated at: July 16, 2022
    # Owner: Adrian
	scope "/user" do
		post "/create_user" => "users#create_user"
	end

	# DOCU: Route for forms
    # Triggered by: /user...
    # Last updated at: July 16, 2022
    # Owner: Adrian
	scope "/forms" do
		get "/" => "forms#home_page"
	end

	# Root URL
	root "forms#landing_page"
end
