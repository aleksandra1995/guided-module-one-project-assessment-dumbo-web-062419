class ForumBook < ActiveRecord::Base
    belongs_to :forum
    belongs_to :book 
end