class CommentsController < ActionController::Base

  def create
   @post = Post.find(params[:post_id])
   @comment = @post.comments.new(comment_params)
   @comment.user_id = current_user.id

    #@topic = Topic.find(params[:topic_id])
    #@post = @topic.posts.find(params[:post_id])
    #comment = current_user.comments.new(comment_params)
    #@comments = @post.comments

  
    
   if @comment.save
      flash[:notice] = "Your comment was saved"
      redirect_to [@post.topic, @post]
    else
      flash[:error] = "There was an error saving your comment. Please try again."
      render :new
    end
  end


  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end