class User < ActiveRecord::Base
  has_many :secrets
  has_many :likes, dependent: :destroy
  # has_many :secrets, through: :likes
  has_many :secrets_liked, through: :likes, source: :secret
  has_secure_password
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :name,  presence: true
  validates :email, presence: true, format: { with: EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  # validates :password, presence: true

  before_save do 
  	self.email.downcase!
  end

  # def self.with_secrets
  # 	self.joins(:secrets).select(:name, :email, :password_digest, :content)
  # end

end
