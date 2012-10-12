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
  
  attr_accessible :about, :title, :type, :url, :tags_attributes
  validates :user_id, presence: true
  belongs_to :user
  has_many :tags, dependent: :destroy
  has_many :comments, dependent: :destroy

  default_scope order: 'uploads.created_at DESC'
  
  validates :about, presence: true, length: { maximum: 600 }
  validates :title, presence: true, length: { maximum: 80 }
  validates :url, presence: true, length: { maximum: 160 }
  
   #TODO:might want to mak tag a many to many relationship for speed.
 
  accepts_nested_attributes_for :tags, :allow_destroy => :true, 
    :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }


  def self.get_videos
    where("lower(type) = 'video'")
  end

  def self.get_articles
    where("lower(type) = 'article'")
  end
end
