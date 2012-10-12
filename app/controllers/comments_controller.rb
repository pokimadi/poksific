class CommentsController < ApplicationController
  before_filter :signed_in_user
  def create
    @upload = Upload.find(params[:upload_id])
    @comment = @upload.comments.create(:body => params[:comment][:body] ,:user_id => current_user.id)
    redirect_to upload_path(@upload)
  end
  
  def destroy
    @upload = Upload.find(params[:upload_id])
    @comment = @upload.comments.find(params[:id])
    @comment.destroy
    redirect_to upload_path(@upload)
  end
  
end
