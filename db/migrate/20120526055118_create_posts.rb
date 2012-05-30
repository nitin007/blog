class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :name
      t.string :title
      t.text :description
      t.references :category
      t.references :users

      t.timestamps
    end
    add_index :posts, :category_id
    add_index :posts, :users_id
  end
end
