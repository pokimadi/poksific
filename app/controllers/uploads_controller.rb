class UploadsController < ApplicationController

  before_filter :signed_in_user, except: [:index, :show, :video, :article]
  before_filter :correct_user, only: [:edit, :update,:destroy]
  before_filter :add_upload, only: :create
  
  def new
    @upload= current_user.uploads.new
  end
  
  def stag
    load = "SELECT upload_id FROM TAGS
    WHERE lower(name) like lower(?)"
    @v_upload = Upload.where("id IN (#{load}) ", "%#{params[:search]}%")
    render "uploads/index" 
  end
  
  def search
    load = "SELECT id FROM USERS
    WHERE lower(name) like lower(?)"
    tag = "SELECT upload_id FROM TAGS
    WHERE lower(name) like lower(?)"
    @v_upload = Upload.where("lower(title) Like lower(?)  or user_id IN (#{load}) or id IN (#{tag})", 
    "%#{params[:search]}%", "%#{params[:search]}%","%#{params[:search]}%")
    render "uploads/index" 
  end
  
  def show
    @upload = Upload.find(params[:id])
    @upload.lock!
    @upload.view = @upload.view + 1
    @upload.save!
  end
  
  def edit
     
  end
  
  def destroy
    Upload.find(params[:id]).destroy
    flash[:success] = "Upload destroyed."
    redirect_to uploads_path
  end

  
  def update
    @upload = Upload.find(params[:id])
    #TODO: Remove email update.
    if @upload.update_attributes(:title => params[:upload][:title], :about => params[:upload][:about], :tags_attributes => params[:upload][:tags_attributes])
      # Handle a successful update.
      flash[:success] = "Post updated"
      redirect_to @upload
    else
      render 'edit'
    end
    
  end
  
  def index
    @v_upload = Upload.paginate(page: params[:page], per_page: 20)
  end
  
  def post
    @v_upload = User.find(current_user.id).uploads.paginate(page: params[:page], per_page: 20)
  end

  def video
    @v_upload= Upload.get_videos(params[:page])
  end
  
  def article
    @v_upload= Upload.get_articles(params[:page]) 
  end
  
  def create 
    if @upload.save
      flash[:success] = "Item was created!"
      @upload.update_attributes( :url =>"http://poksific.herokuapp.com/uploads/#{@upload.id}") unless @update == false
      redirect_to root_path
    else
      render 'new'
    end
  end
  
  
  private
    def add_upload
      
        @upload = current_user.uploads.build(params[:upload])
        @upload.view = 1
        if @upload.type.downcase == "video"
          if video_id(@upload.url).blank?
            #Do something
            @upload.url = nil
          else
            if @upload.url[/youtu\.be\/([^\?]*)/]
              @upload.embedid= $1
            else
              # Regex from # http://stackoverflow.com/questions/3452546/javascript-regex-how-to-get-youtube-video-id-from-url/4811367#4811367
              @upload.url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
              @upload.embedid = $5
            end
          end
        elsif @upload.type.downcase == "article"
            if @upload.url.blank?
               @update = true
               @upload.url ="http://poksific.herokuapp.com/uploads"
            else
               @update = false 
            end
            
        end
    end

  
    def correct_user
      @upload = Upload.find(params[:id])
      redirect_to(root_path) unless current_user?(@upload.user)
    end
end
