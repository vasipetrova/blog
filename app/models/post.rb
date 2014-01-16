class Post < ActiveRecord::Base
	belongs_to :user
	has_many :comments, :order => "created_at DESC"

	validates_presence_of :body, :title
end
