class User < ApplicationRecord
  rolify
  validates_presence_of :name, :email, :password_digest
end
