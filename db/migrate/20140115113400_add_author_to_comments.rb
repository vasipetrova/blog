class AddAuthorToComments < ActiveRecord::Migration 
   def self.up
  	add_column :comments, :author, :integer
  end
  
  def self.down
  	drop_column :comments, :author
  end
end