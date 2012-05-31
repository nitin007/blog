require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test "category attributes must not be empty" do
		category = Category.new
		assert category.invalid?
		assert category.errors[:name].any?
  end
  
  test "category name must be unique" do
    #FIX: You should use fixture to create default data. This way test would perform better. 
  	category1 = Category.new(:name => "education")
  	assert category1.save
  	
  	category2 = Category.new(:name => "education")
  	assert !category2.save
  end
  
  #FIX: Use fixture. Also test description should be small and sufficient. eg. "Assign default category to posts on destroy"
  test "posts under a category are move to default category before destroying that category" do
  	category = Category.new(:name => "painting")
  	category.save
    #FIX: To create associated object use object.association.create
  	post = Post.new(:name => "nitin", :title => "testing", :description => "this is a test", :category_id => category.id)
  	post.save
  	category.destroy
  	post.reload
    #FIX: Hardcoring id makes test regid. should use default_category.id
  	assert_equal 1, post.category_id
  end
end
