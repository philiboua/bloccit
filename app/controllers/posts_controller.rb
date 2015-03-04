class PostsController < ApplicationController
  #def index
    #@posts = Post.all
     # authorize @posts
     # @posts = current_user && current_user.admin? ? Post.all : Post.where(user_id: current_user.id)
     # Post.visible_to(current_user)
     #@posts = policy_scope(Post)
  #end

  def show
    @post = Post.find(params[:id])
    @topic = Topic.find(params[:topic_id])
    @comments = @post.comments

  end

  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
      authorize @post 
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = current_user.posts.build(post_params)
    @post.topic = @topic
    # Rails.logger.info ">>>>>>> #{current_user.inspect}"
    #authorize @post
    if @post.save_with_initial_vote
      flash[:notice] = "Post was saved"
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
      authorize @post
  end

  def update
    @topic = Topic.find(params[:topic_id])
     @post = Post.find(params[:id])
        authorize @post
     if @post.update_attributes(post_params) # {post: {title: "my_title", body: "my_body"} }
       flash[:notice] = "Post was updated."
       redirect_to @post.topic
     else
       flash[:error] = "There was an error saving the post. Please try again."
       render :edit
     end
   end

   def destroy
     @topic = Topic.find(params[:topic_id])
     @post = Post.find(params[:id])
     title = @post.title
     authorize @post
 
     if @post.destroy
       flash[:notice] = "\"#{title}\" was deleted successfully."
       redirect_to @topic
     else
       flash[:error] = "There was an error deleting the post."
       render :show
     end
   end

   private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
