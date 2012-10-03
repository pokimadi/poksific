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
    if source_url.blank?
      return nil
    else
      video_regexp.each { |m| 
          if !(m.match(source_url).nil?)
            return m.match(source_url)[1]
          end 
      }
    end
    return nil
  end

  
end
