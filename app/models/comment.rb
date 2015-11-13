class Comment < ActiveRecord::Base
	validates_presence_of :text , :message => "can't be empty"
    validates_associated :user 
    validates_presence_of :user , :message => "should have owner"
    belongs_to :post
    validates_presence_of :post , :message => "should belong to a post"
    belong_to :post
    belong_to :user
end
