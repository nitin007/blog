class UsersController < ApplicationController
	def index
		respond_to do |format|
			#session[:current_user] = nil
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end
  
	def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end
		
	def create
	  @user = User.new(params[:user])

	  respond_to do |format|
	    if @user.save
	    	session[:current_user] = @user.username
	    	session[:current_user_id] = @user.id
	      format.html { redirect_to posts_path, notice: 'You are successfully registered!' }
	      format.json { render json: posts_path, status: :created, location: posts_path }
	    else
	      format.html { render action: "new" }
	      format.json { render json: @user.errors, status: :unprocessable_entity }
	    end
	  end
	end
	
	def login
		respond_to do |format|
			if user = User.authenticate(params[:username], params[:password])
				session[:current_user] = user.username
				flash[:notice] = "You have logged in successfully!"
				format.html { redirect_to posts_path }
			else
				format.html { redirect_to login_path, notice: 'username or password is incorrect!'}
			end
		end
	end
	
	def logout
		session[:current_user] = nil
		redirect_to login_path
	end
end
