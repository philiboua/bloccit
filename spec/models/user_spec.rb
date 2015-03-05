  require 'rails_helper'

describe User do 

  # include TestFactories

  describe "#favorited(post)" do

    before do 
      @user = create(:user)  
      @post = create(:post, user: @user)   
    end

    it "returns `nil` if the user has not favorited the post" do 
      expect( @user.favorited(@post) ).to eq(nil)
    end

    it "returns the appropriate favorite if it exists" do
      @favorite = Favorite.new(user_id: @user.id, post_id: @post.id)
      @favorite.save
      #f = @user.favorites.where(post: @post).create
      expect( @user.favorited(@post) ).to eq(f)
    end
  
  end
end