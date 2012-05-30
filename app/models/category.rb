class Category < ActiveRecord::Base
  attr_accessible :name
  
  has_many :posts
  
  before_destroy :move_to_default_category
  
  validates :name, :presence => true, :uniqueness => true
  
  private
		
		def move_to_default_category
			self.posts.update_all("category_id = 1")
		end
end
