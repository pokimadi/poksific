class Conversation < ActiveRecord::Base
  attr_accessible :chat_id, :message, :user_id
  belongs_to :chat
  
  default_scope order: 'conversations.updated_at ASC'
  
  validates :message, presence: true, length: { maximum: 600 }
end
