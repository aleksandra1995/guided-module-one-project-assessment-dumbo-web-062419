class Forum < ActiveRecord::Base
   has_many :memberships
   has_many :comments
   has_many :users, through: :memberships 
   belongs_to :book

end