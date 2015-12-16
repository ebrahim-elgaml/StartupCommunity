class Post < ActiveRecord::Base
	belongs_to :user , class_name: 'User' ,foreign_key: "user_id"
	belongs_to :user_tagged , class_name: 'User' ,foreign_key: "tagged_id"
	belongs_to :startup , class_name: 'Startup' ,foreign_key: "startup_id"
	has_many :comments
	validate :can_not_be_empty
	def can_not_be_empty
		if(text.blank? and image.blank?)
			errors.add(:post, 'can not be empty')
			false
		end
	end
	validate :should_have_owner
	def should_have_owner
		if(user_id.blank? and startup_id.blank?)
			errors.add(:post, 'should have owner')
			false
		end
	end
end
