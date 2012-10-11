module SessionsHelper
  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    current_user = user
  end

  #Assignment must be defined in ruby.
  def current_user=(user)
    @current_user = user
  end
  
  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "Please sign in." 
    end
  end
  
  def current_user?(user)
    user == current_user
  end

  
  def signed_in?
    !current_user.nil?
  end

  
  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end
  
  def sign_out
    current_user = nil
    cookies.delete(:remember_token)
  end
  
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.fullpath
  end
  
  def unread
    current_user.communications.where(:seen => false).count
  end
  
  def seen?(chat)
    com = Communication.where(:user_id => current_user.id, :chat_id => chat.id).first
    com.seen == true
  end

  def welcome(n_user)
    chat = Chat.new
    user = User.where(:admin => true).first
    chat.conversations.new(:message => "Hi #{n_user.name} ,\n" +
    "    Welcome to Poksific.herokuapp.com. The site is still in development,\n" +
    "so feel free to request any material or other changes that you feel \n " +
    "might be an improve the website. Anyways on lighter note have fun  \n" +
    "and share material with the community. " , :user_id => user.id )
    if chat.save
       n_user.chats<<(chat)
       user.chats<<(chat)
    end
  end


  
end
