class User < ActiveRecord::Base

  has_many :reviews

  validates :name,
    presence: true
  validates :email,
    presence: true,
    uniqueness: true
  validates :password_digest,
    presence: true,
    length: { minimum: 5 }
  has_secure_password

end
