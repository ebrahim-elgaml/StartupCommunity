class StartupFollower < ActiveRecord::Base
	validates_associated :startup
    validates_presence_of :startup , :message => "must have starup"
    validates_associated :user 
    validates_presence_of :user , :message => "must have owner"
    belongs_to :user
    belongs_to :startup
end
