require 'spec_helper'

describe Category do
	context "with its attributes empty" do
		it "should not be valid" do
			@category = Category.new
			@category.should_not be_valid
			@category.should have(1).error_on(:name)
		end
	end
	
	context "with its attributes filled" do
		it "should be valid" do
			@category = Category.new(:name => "rspec")
			@category.should be_valid
		end
	end

	it "name should be unique" do
		@category1 = Category.new(:name => "rspec")
		@category1.should be_valid
		@category1.save
		
		@category2 = Category.new(:name => "rspec")
		@category2.should_not be_valid
		
		@category3 = Category.new(:name => "cucumber")
		@category3.should be_valid
		@category3.save
	end
	
	context "when destroyed" do
		it "all posts under it are moved to default category" do
			@category = Category.new(:name => "rspec")
			@category.should be_valid
			@category.save
			
			@post = Post.new(:name => "nitin", :title => "rspec test", :description => "testing with rspec is fun", :category_id => @category.id)
			@post.should be_valid
			@post.save
			
			@category.destroy
			@post.reload
			@post.category_id.should == 1
		end
	end
end
