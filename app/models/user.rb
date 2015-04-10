require 'scrypt'

class User < ActiveRecord::Base

  validates :username, :password, presence: true

  before_create :hash_password

  def authenticate(password)
    SCrypt::Password.new(self.password) == password
  end




  private

  def hash_password
    self.password = SCrypt::Password.create(self.password)
  end

end
