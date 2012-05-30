require 'test_helper'
require 'digest/sha2'

class UserTest < ActiveSupport::TestCase
  test "user attributes must not be empty" do
  	user = User.new
  	assert user.invalid?
  	assert user.errors[:username].any?
  	assert user.errors[:password].any?
  end
  
  test "username must be unique" do
  	user1 = User.new(:username => "nitin", :password => "12345678", :password_confirmation => "12345678")
  	assert user1.save
  	
  	user2 = User.new(:username => "nitin", :password => "87654321", :password_confirmation => "87654321")
  	assert !user2.save
  	assert_equal "has already been taken", user2.errors[:username].join(';')
  end
  
  test "password must be greater than or equal to 5 characters" do
  	user = User.new(:username => "nitin", :password => "1234", :password_confirmation => "1234")
  	assert user.invalid?
  	
  	user.password = "12345"
  	user.password_confirmation = "12345"
  	assert user.valid?
  end
  
  test "password and password_confirmation must be equal" do
  	user = User.new(:username => "nitin", :password => "12345678", :password_confirmation => "12345679")
  	assert user.invalid?
  end
  
  test "password before storing into database must be hashed" do
  	user = User.new(:username => "nitin", :password => "12345678")
  	user.save
  	assert_equal user.password, Digest::SHA512.hexdigest('12345678')
  end
  
  test "user is authenticated before login" do
  	user = User.new(:username => "nitin", :password => "12345678")
  	user.save
  	assert User.authenticate("nitin", "12345678"), "username or password is incorrect!"
  end
end