class User < ActiveRecord::Base
  has_many :scores
  validates :name, :email, presence: true
  validates_uniqueness_of :email
  has_secure_password
end
