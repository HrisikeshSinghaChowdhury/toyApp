class User < ApplicationRecord
  has_many :microposts, dependent: :destroy
  before_save { self.email = email.downcase }
  validates :name, presence:true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 230 },
             uniqueness: true
  # validates :password, presence: true, length: { maximum: 430 },\
  # :on => :update, :unless => lambda { |user| user.password.blank? }
  validates :password_digest, presence: true,\
  if: ->(user) { user.password_digest_changed? }

  validates :avatar, presence: true
  has_secure_password
  has_one_attached :avatar
end