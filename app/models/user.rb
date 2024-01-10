class User < ApplicationRecord


  has_many :sessions, :tweets
end
