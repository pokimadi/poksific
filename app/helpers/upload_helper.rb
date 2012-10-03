module UploadHelper
  
  def video_regexp
    @video_regexp = [ /^(?:https?:\/\/)?(?:www\.)?youtube\.com(?:\/v\/|\/watch\?v=)([A-Za-z0-9_-]{11})/, 
                     /^(?:https?:\/\/)?(?:www\.)?youtu\.be\/([A-Za-z0-9_-]{11})/,
                     /^(?:https?:\/\/)?(?:www\.)?youtube\.com\/user\/[^\/]+\/?#(?:[^\/]+\/){1,4}([A-Za-z0-9_-]{11})/
                     ]
  end
  
  def show(upload)
    
  end
  
  def video_id(source_url)
    video_regexp.each { |m| return m.match(source_url)[1] unless m.nil? }
  end

  
end
