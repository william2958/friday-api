class User < ApplicationRecord

	include Mongoid::Document

	field :email, type: String
	field :password_digest, type: String
	has_secure_password

	validates_presence_of :email, :message => "ERROR: Email is required!"
  	validates_presence_of :password_digest, :message => "ERROR: Password is required!"
  	validates_uniqueness_of :email

  	field :first_name, type: String
  	field :last_name, type: String
  	validates_presence_of :first_name, :message => "ERROR: First name is required!"
  	validates_presence_of :last_name, :message => "ERROR: Last name is required!"

  	embeds_many :accounts, class_name: "Account"

end
