class Blog < ApplicationRecord
	belongs_to :user
	delegate :email, :to => :user, :prefix => true, :allow_nil => true
end
