require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test "category attributes must not be empty" do
		category = Category.new
		assert category.invalid?
		assert category.errors[:name].any?
  end
  
  test "category name must be unique" do
  	category1 = Category.new(:name => "education")
  	assert category1.save
  	
  	category2 = Category.new(:name => "education")
  	assert !category2.save
  end
  
  test "posts under a category are move to default category before destroying that category" do
  	category = Category.new(:name => "painting")
  	category.save
  	post = Post.new(:name => "nitin", :title => "testing", :description => "this is a test", :category_id => category.id)
  	post.save
  	category.destroy
  	post.reload
  	assert_equal 1, post.category_id
  end
end
