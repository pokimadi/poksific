class UploadsController < ApplicationController

  before_filter :signed_in_user
  before_filter :add_upload, only: :create
  
  def new
    @upload= current_user.uploads.new
  end
  
  def show
    @upload = Upload.find(params[:id])
  end
  
  def index
    
  end
  
  def video
    @v_upload= Upload.get_videos  
  end
  
  def create
    if @upload.save
      flash[:success] = "Item was created!"
      redirect_to root_path
    else
      render '/upload'
    end
  end
  
  def destroy
  end
  
  private
    def add_upload
      
        @upload = current_user.uploads.build(params[:upload])
        @upload.view = 1
        if @upload.type.downcase == "video"
          if @upload.url[/youtu\.be\/([^\?]*)/]
            @upload.embedid= $1
          else
            # Regex from # http://stackoverflow.com/questions/3452546/javascript-regex-how-to-get-youtube-video-id-from-url/4811367#4811367
            @upload.url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
            @upload.embedid = $5
          end
        end
         
       
    end
  
  

end
