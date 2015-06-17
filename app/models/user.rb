class User < ActiveRecord::Base
  def self.find_from_auth_hash(auth_hash)
    email = auth_hash[:info][:email]
    self.find_by(email: email)
  end
end
