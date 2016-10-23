class User < ActiveRecord::Base
  has_many :scores
  validates :name, :email, presence: true
  has_secure_password
end
