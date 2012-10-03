# == Schema Information
#
# Table name: uploads
#
#  id         :integer         not null, primary key
#  type       :string(255)
#  url        :string(255)
#  title      :string(255)
#  about      :string(255)
#  user_id    :integer
#  embedid    :string(255)
#  view       :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Upload < ActiveRecord::Base
  
  #Can not use type as a datbase name
  self.inheritance_column = "inheritance_type"
  
  attr_accessible :about, :title, :type, :url
  validates :user_id, presence: true
  belongs_to :user

  default_scope order: 'uploads.created_at DESC'
  
  validates :about, presence: true, length: { maximum: 140 }
  validates :title, presence: true, length: { maximum: 60 }
  validates :url, presence: true, length: { maximum: 60 }
  validates :title, presence: true

  def self.get_videos
    where("lower(type) = 'video'")
  end

end
