class User < ActiveRecord::Base
	attr_accessible :email, :first_name, :last_name, :password, :password_confirmation
  before_save :encrypt_password
	validates :first_name, presence: true,
                    length: { minimum: 2, allow_blank: true}

	validates :last_name, presence: true,
                    length: { minimum: 2, allow_blank: true}

	validates :password, presence: true, length: { minimum: 6, allow_blank: true}, confirmation: true
	
	
	validates :password_confirmation, presence: true

	validates :email, presence: true, uniqueness: true

	def encrypt_password
    self.password = Digest::MD5::hexdigest(password)

	end

	def self.validate_login(email, password)
		user = User.find_by_email(email)
		if user && user.password == Digest::MD5::hexdigest(password)
			user
		else
			nil
		end
	end
end
