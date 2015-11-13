class UserConnection < ActiveRecord::Base
	# Enum to set request status :
    # => 0 for pending.
    # => 1 for rejected.
    # => 2 for accepted.
    enum request_status: { pending: 0, rejected: 1, accepted: 2 }
	validates_associated :user_a
	validates_presence_of :user_a
	validates_associated :user_b
	validates_presence_of :user_b
	validates_uniqueness_of :user_a_id, scope: :user_b_id
	validate :record_can_not_be_duplicate
	def record_can_not_be_duplicate
		if(UserConnection.exists?(user_a_id: user_b_id, user_b_id: user_b_id))
			errors.add(:error, 'request has been sent before')
			false
		end
	end

	validate :users_can_not_be_same
	def users_can_not_be_same
		if user_a_id == user_b_id
			errors.add(:users, 'can not be the same')
			false
		end
	end

	# User_b sends request to user_a.
	belongs_to :user_a , class_name: 'User' ,foreign_key: "user_a_id"
	belongs_to :user_b , class_name: 'User' ,foreign_key: "user_b_id"

	def where_pending
		self.where(request_status: 0)
	end
	def where_rejected
		self.where(request_status: 1)
	end
	def where_accepted
		self.where(request_status: 2)
	end
end
