class User < ActiveRecord::Base
	validates_presence_of :first_name , :message => "first_name can't be empty"
    validates_presence_of :last_name , :message => "last_name can't be empty"
    #validates_presence_of :country , :message => "country can't be empty"
    #validates_presence_of :city , :message => "city can't be empty"
    #validates_presence_of :gender , :message => "gender can't be empty"

    has_many :startup_followers, dependent: :destroy
  	has_many :following_startups, :through => :startup_followers, source: 'startup'

    has_many :posts,
 	:foreign_key => :user_id,
 	:class_name => 'Post', :dependent => :destroy


 	has_many :comments,
 	:foreign_key => :user_id,
 	:class_name => 'Comment', :dependent => :destroy

 	has_many :startups,
 	:foreign_key => :user_id,
 	:class_name => 'Startup', :dependent => :destroy

  	has_many :user_a_connections,
 	:foreign_key => :user_a_id,
 	:class_name => 'UserConnection', :dependent => :destroy
	
	# User recieves requests. 	
 	has_many :friend_requests_connection,
 	:foreign_key => :user_a_id,
 	:class_name => 'UserConnection', :dependent => :destroy
 	has_many :friend_requests, -> { where  "user_connections.request_status = 0" },
 	through: :friend_requests_connection,
 	source: 'user_b'

 	# user rejects other users.
 	has_many :friend_rejections_connection,
 	:foreign_key => :user_a_id,
 	:class_name => 'UserConnection', :dependent => :destroy
 	has_many :friend_rejections, -> { where  "user_connections.request_status = 1" },
 	through:  :friend_rejections_connection,
 	source: 'user_b'


 	# User accepts other users.
 	has_many :friend_acceptance_connection,
 	:foreign_key => :user_a_id,
 	:class_name => 'UserConnection', :dependent => :destroy
 	has_many :friend_accepted, -> { where  "user_connections.request_status = 2" },
 	through:  :friend_acceptance_connection,
 	source:  'user_b'

 	
 	has_many :user_b_connections,
 	:foreign_key => :user_b_id,
 	:class_name => 'UserConnection', :dependent => :destroy
	
	# User send requests. 	
 	has_many :request_friends_connection,
 	:foreign_key => :user_b_id,
 	:class_name => 'UserConnection', :dependent => :destroy
 	has_many :request_friends, -> { where  "user_connections.request_status = 0" },
 	through: :request_friends_connection,
 	source: 'user_a'

 	# user rejected by other users.
 	has_many :rejected_by_connection,
 	:foreign_key => :user_b_id,
 	:class_name => 'UserConnection', :dependent => :destroy
 	has_many :rejected_by, -> { where  "user_connections.request_status = 1" },
 	through:  :rejected_by_connection,
 	source: 'user_a'

 	# User accepted by other users.
 	has_many :accepted_by_connection,
 	:foreign_key => :user_b_id,
 	:class_name => 'UserConnection', :dependent => :destroy
 	has_many :accepted_by, -> { where  "user_connections.request_status = 2" },
 	through:  :accepted_by_connection,
 	source:  'user_a'


 	before_create :set_auth_token

 	def set_auth_token
      return if authentication_token.present?
      self.authentication_token = generated_auth_token
    end

    def generated_auth_token
      SecureRandom.uuid.gsub(/\-/,'')
    end

	def friends
		User.where(id: (([] << self.friend_accepted) << self.accepted_by).flatten)
	end	
	def male?
		gender
	end
	def female?
		!gender
	end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


end
