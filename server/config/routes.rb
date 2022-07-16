Rails.application.routes.draw do
	# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
	scope "/user" do
		post "/create_user" => "users#create_user"
	end
	# Defines the root path route ("/")
	root "forms#landing_page"
end
