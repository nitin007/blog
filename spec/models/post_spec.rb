require 'spec_helper'

describe Post do
	context "with its attributes empty" do
		it "should be invalid" do
			@post = Post.new
			@post.should_not be_valid
			@post.should have(1).error_on(:name)
			@post.should have(2).error_on(:title)
			@post.should have(1).error_on(:description)		
			@post.should have(1).error_on(:category_id)
		end
	end
	
	context "with its attributes filled" do
		it "should be valid" do
			@post = Post.new(:name => "nitin", :title => "rspec test", :description => "testing with rspec is fun", :category_id => 1)
			@post.should be_valid
		end
	end
	
	context "with its title less than 5 characters" do
		it "should be invalid" do
			@post = Post.new(:name => "nitin", :title => "rspc", :description => "testing with rspec is fun", :category_id => 1)
			@post.should_not be_valid
			@post.title = "rspecf test"
			@post.should be_valid			
		end
	end
end
