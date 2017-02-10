class User

	include Mongoid::Document
	include ActiveModel::SecurePassword

	field :email, type: String
	field :password_digest, type: String
	has_secure_password

	validates_presence_of :email, :message => "ERROR: Email is required!"
	validates_presence_of :password_digest, :message => "ERROR: Password is required!"
	validates_uniqueness_of :email

	field :confirm_token, type: String, default: ''
	field :email_confirmed, type: Boolean, default: false

	field :first_time, type: Boolean, default: true

	field :first_name, type: String
	field :last_name, type: String
	validates_presence_of :first_name, :message => "ERROR: First name is required!"
	validates_presence_of :last_name, :message => "ERROR: Last name is required!"

	embeds_many :accounts, class_name: "Account"

end
