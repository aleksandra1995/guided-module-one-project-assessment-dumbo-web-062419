class Forum < ActiveRecord::Base
   has_many :forum_books
   has_many :memberships
   has_many :users, through: :memberships 
   has_many :books, through: :forum_books
end