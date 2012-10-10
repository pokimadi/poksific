class Communication < ActiveRecord::Base
  attr_accessible :chat_id, :user_id,:seen
  belongs_to :chat
  belongs_to :user
end
