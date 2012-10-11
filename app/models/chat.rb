class Chat < ActiveRecord::Base
  attr_accessible :conversations_attributes
  
  has_many :communications
  has_many :users, :through => :communications
  has_many :conversations ,  dependent: :destroy
  
  default_scope order: 'chats.updated_at DESC'
  
  
  accepts_nested_attributes_for :conversations, :allow_destroy => :true, 
    :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }

end
