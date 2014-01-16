class AddAuthorToPosts < ActiveRecord::Migration 
   def self.up
  	add_column :posts, :author, :integer
  end
  
  def self.down
  	drop_column :posts, :author
  end
end