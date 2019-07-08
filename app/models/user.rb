class User < ActiveRecord::Base
    has_many :memberships
    has_many :forums, through: :memberships
    has_many :books, through: :forums
end