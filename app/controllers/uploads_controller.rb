class UploadsController < ApplicationController

  before_filter :signed_in_user, except: [:index, :show, :video, :article]
  before_filter :add_upload, only: :create
  
  def new
    @upload= current_user.uploads.new
  end
  
  def show
    @upload = Upload.find(params[:id])
    @upload.view = @upload.view + 1
  end
  
  def index
    @v_upload = Upload.all
    
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
  
  def destroy
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
  
  

end
