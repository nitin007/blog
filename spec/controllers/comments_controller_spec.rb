require 'spec_helper'

describe CommentsController, :type => :controller do
	render_views
	fixtures :comments
	fixtures :posts	
	
	before(:each) do
		@comment = comments(:one)
	end
	
	context "creating a new comment" do
		it "should redirect to to post" do
			post 'create', :comment => {:commenter => @comment.commenter, :body => @comment.body}, :post_id => 1
			response.should be_redirect
		end
	end
	
	context "destroying a comment" do
		it "should redirect to post on destroys" do
			delete 'destroy', :id => @comment.id, :post_id => 1
			response.should be_redirect	
		end
	end
end
