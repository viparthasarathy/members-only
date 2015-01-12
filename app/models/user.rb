class User < ActiveRecord::Base
	
	has_many :posts
	before_create :generate_remember_token
	has_secure_password


	

	def User.new_remember_token
		Digest::SHA1.hexdigest(SecureRandom.urlsafe_base64)
	end

	private

	def generate_remember_token
		self.remember_token = User.new_remember_token
	end

end
