class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :blogs
  has_many :orders
  has_many :notifications

  def name
  	self.first_name+" "+self.last_name
  end

  def unread_notification_count
    @unread_notifications = Notification.where(:user_id => self.id, :read => nil)
    @unread_notifications_count = @unread_notifications.count
  end

  def unread_notifications
    @unread_notifications = Notification.where(:user_id => self.id, :read => nil).order(created_at: :desc)
  end
end
