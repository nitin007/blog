require 'spec_helper'

describe UsersController, :type => :controller do
	render_views
	fixtures :users
	
	it "shows the index template with(login page)" do
		get :index
		response.should be_success
	end
	
	it "shows template for sign up" do
		get :new
		response.should be_success
	end
	
	context "registering a new user" do
		it "should redirect to posts list with a notice on successful registered" do
			post 'create', user: {:username => "nitin", :password => "nitin", :password_confirmation => "nitin"}
			flash[:notice].should_not be_nil
			response.should redirect_to(posts_path)
		end
	end
	
	context "logging in a user" do
		it "should redirect to posts list with a notice on sucessful registered" do
			post 'create', user: {:username => "nitin", :password => "nitin", :password_confirmation => "nitin"}
			post 'login', :username => "nitin", :password => "nitin"
			response.should redirect_to(posts_path)
		end
	end
end
