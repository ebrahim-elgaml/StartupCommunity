class Startup < ActiveRecord::Base
	validates_presence_of :name , :message => "name can't be empty"
    validates_presence_of :category , :message => "category can't be empty"
    validates_presence_of :starting_date , :message => "created date can't be empty"
    validates_associated :user 
    validates_presence_of :user , :message => "must have owner"
    belongs_to :user
    validates_uniqueness_of :name


    has_many :posts,
 	:foreign_key => :user_id,
 	:class_name => 'Post', :dependent => :destroy

 	has_many :startup_followers, dependent: :destroy
  	has_many :followers, :through => :startup_followers

  	has_many :comments,
 	:foreign_key => :startip_id,
 	:class_name => 'Comment', :dependent => :destroy
end
