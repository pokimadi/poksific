class ChatsController < ApplicationController
  
  before_filter :signed_in_user
  
  def new
    #makes sure that chat  does not exist
    # Make sure user does exist.
    @user = User.find(params[:id])
    
    @chat = Chat.new
    
  end
  
  def create
    @user = User.find(params[:id])
    @add = "yes"
    if !(current_user?(@user))
      set_chat
      if @chat.save
        if @add == "yes"
          @chat.conversations.first.update_attributes(:user_id => current_user.id)
          @chat.users << (current_user)
          @chat.users << (@user)
        else
          @chat.communications.each do |com|
            com.update_attributes(:seen => false)
          end
        end
        redirect_to msg_path(@chat.id)
      else
        render 'new'
      end
    else
      redirect_to root_path  
    end
  end
  
  def destroy
    
  end
  
  def show
    chat = current_user.chats.where(:id => params[:id])
    if chat.empty?
      redirect_to root_path 
    else 
      @chat = chat[0]
      @chat.users.each do |user|
        @user = user unless current_user?(user)
      end
      communication = Communication.where(:user_id => current_user.id, :chat_id => @chat.id)
      communication[0].update_attributes(:seen => true)
    end 
  end
  
  def index
    @chat = current_user.chats
  end
  
  private
    def set_chat
      querry ="Select chat_id from Communications where user_id = ? and chat_id in (Select chat_id from communications 
                    Where user_id = ?)"
      load = Chat.where("id in (#{querry})",current_user.id, @user.id)
      if load.empty?
        @chat = Chat.new(params[:chat])
      else
        @add ="no"
        @chat = load[0]
        @chat.conversations.new(:message => params[:chat][:conversations_attributes]["0"][:message], 
                                :user_id => current_user.id)
      end
    end
end
