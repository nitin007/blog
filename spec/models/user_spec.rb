require 'spec_helper'
require 'digest/sha2'

describe User do
	context "with its attributes empty" do
		it "should_not be_valid" do
			@user = User.new
			@user.should_not be_valid
			@user.should have(1).error_on(:username)
			@user.should have(2).error_on(:password)
			@user.should have(0).error_on(:password_confirmation)
		end
	end
	
	context "with its username" do
		it "should be unique" do
			@user1 = User.new(:username => "nitin", :password => "abcdef", :password_confirmation => "abcdef")
			@user1.should be_valid
			@user1.save
			
			@user2 = User.new(:username => "nitin", :password => "ghijkl", :password_confirmation => "ghijkl")
			@user2.should_not be_valid
			
			@user3 = User.new(:username => "jagdeep", :password => "ghijkl", :password_confirmation => "ghijkl")
			@user3.should be_valid
		end
	end
	
	context "with its password" do
		it "should be greater than or equal to 5 characters" do
			@user = User.new(:username => "nitin", :password => "abcd", :password_confirmation => "abcd")
			@user.should_not be_valid
			
			@user = User.new(:username => "nitin", :password => "abcdef", :password_confirmation => "abcdef")
			@user.should be_valid
		end
	end
	
	context "with its password and password_confirmation" do
		it "should be equal" do
			@user = User.new(:username => "nitin", :password => "abcdef", :password_confirmation => "abcdeg")
			@user.should_not be_valid
			
			@user = User.new(:username => "nitin", :password => "abcdef", :password_confirmation => "abcdef")
			@user.should be_valid
		end
	end
	
	context "password before storing into database" do
		it "should be hashed" do
			@user = User.new(:username => "nitin", :password => "abcdef", :password_confirmation => "abcdef")
			@user.should be_valid
			@user.save
			@user.password.should be == Digest::SHA512.hexdigest('abcdef')
		end
	end
	
	it "is authenticated before login" do
		@user = User.new(:username => "nitin", :password => "abcdef", :password_confirmation => "abcdef")
		@user.should be_valid
		@user.save
		User.authenticate(@user.username, '12345678').should == nil
		User.authenticate(@user.username, 'abcdef').should be_valid
	end
end
