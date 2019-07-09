class Book < ActiveRecord::Base
    has_many :users, through: :forums
    has_many :forums
end