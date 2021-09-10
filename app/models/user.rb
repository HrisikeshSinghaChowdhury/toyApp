class User < ApplicationRecord
  before_save { self.email = email.downcase }
  validates :name, presence:true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 230 },
             uniqueness: true
  validates :password, presence: true, length: { maximum: 430 }
  has_secure_password
end
