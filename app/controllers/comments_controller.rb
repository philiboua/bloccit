class CommentsController < ApplicationController

  def create
   @post = Post.find(params[:post_id])
   @comment = @post.comments.build(comment_params)
   @comment.user_id = current_user.id

    # @topic = Topic.find(params[:topic_id])
    # @post = @topic.posts.find(params[:post_id])
    # @comment = @post.comments.new(comment_params)
    # @comment.user = current_user
    # @comments = @post.comments
   if @comment.save
      flash[:notice] = "Your comment was saved"
      redirect_to [@post.topic, @post]
    else
      flash[:error] = "There was an error saving your comment. Please try again."
      redirect_to [@post.topic, @post]
    end
  end

  def destroy
    # @post = @topic.posts.find(params[:post_id])
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
     authorize @comment

     if @comment.destroy
       flash[:notice] = "Comment was removed."
       redirect_to [@post.topic, @post]
     else
       flash[:error] = "Comment couldn't be deleted. Try again."
       redirect_to [@post.topic, @post]
     end
   end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end