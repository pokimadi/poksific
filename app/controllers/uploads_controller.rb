class UploadsController < ApplicationController

  before_filter :signed_in_user, except: [:index, :show, :video, :article, :post]
  before_filter :correct_user, only: [:edit, :update,:destroy]
  before_filter :add_upload, only: :create
  
  def new
    @upload= current_user.uploads.new
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
    if @upload.update_attributes(:title => params[:upload][:title], :about => params[:upload][:about])
      # Handle a successful update.
      flash[:success] = "Post updated"
      redirect_to @upload
    else
      render 'edit'
    end
    
  end
  
  def index
    @v_upload = Upload.all 
  end
  
  def post
    @v_upload = User.find(current_user.id).uploads
  end

  def video
    @v_upload= Upload.get_videos  
  end
  
  def article
    @v_upload= Upload.get_articles  
  end
  
  def create
    if @upload.save
      flash[:success] = "Item was created!"
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
               @upload.url ="poksific.herokuapp.com"
            end
        end
    end

  
    def correct_user
      @upload = Upload.find(params[:id])
      redirect_to(root_path) unless current_user?(@upload.user)
    end
end
