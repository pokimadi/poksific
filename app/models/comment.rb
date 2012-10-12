class Comment < ActiveRecord::Base
  belongs_to :upload
  attr_accessible :body, :user_id
  belongs_to :user
  validates :body, presence: true, length: { maximum: 1000 }
  validates :user_id, presence: true
end
