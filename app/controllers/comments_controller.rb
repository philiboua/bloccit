class CommentsController < ApplicationController

  def create
   #@post = Post.find(params[:post_id])
   #@comment = @post.comments.build(comment_params)
   #@comment.user_id = current_user.id

    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
    @comments = @post.comments
   if @comment.save
      flash[:notice] = "Your comment was saved"
      redirect_to [@post.topic, @post]
    else
      flash[:error] = "There was an error saving your comment. Please try again."
      redirect_to [@post.topic, @post]
    end
  end

  def destroy
   
     @post = Post.find(params[:post_id])
     @comment = @post.comments.find(params[:id])
     authorize @comment

     if @comment.destroy
       flash[:notice] = "Comment was removed."
   
     else
       flash[:error] = "Comment couldn't be deleted. Try again."
     
     end

     respond_to do |format|
       format.html
       format.js
     end

   end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end