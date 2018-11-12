class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :blogs
  has_many :orders
  has_many :notifications, as: :recipient

  def name
  	self.first_name+" "+self.last_name
  end
end
