require 'scrypt'

class User < ActiveRecord::Base

  has_many :reports, dependent: :destroy

  validates :username, :password, presence: true
  validates :username, uniqueness: true

  before_create :hash_password

  def authenticate(password)
    SCrypt::Password.new(self.password) == password
  end




  private

  def hash_password
    self.password = SCrypt::Password.create(self.password)
  end

end
