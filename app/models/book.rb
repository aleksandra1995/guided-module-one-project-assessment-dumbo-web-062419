class Book < ActiveRecord::Base
    has_many :forum_books
    has_many :users, through: :forums 
    has_many :forums, though: :forum_books
end