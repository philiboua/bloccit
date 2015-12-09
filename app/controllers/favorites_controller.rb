class FavoritesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.build(post: @post)

    authorize favorite

    if favorite.save
      flash[:notice] = "Successfully marked thid post as favorite"
      redirect_to [@post.topic, @post]
    else
      flash[:error] = "This post has not been marked as favorite"
      redirect_to [@post.topic, @post]
    end
  end

  def destroy
    @post = Post.find(params[:post_id])

    favorite = current_user.favorites.find(params[:id])

    authorize favorite

    if favorite.destroy
      flash[:notice] = "Removed favorite"
      redirect_to [@post.topic, @post]
    else
      flash[:error] = "Unable to remove favorite."
      redirect_to [@post.topic, @post]
    end
  end

end
