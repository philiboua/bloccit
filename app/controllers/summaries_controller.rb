class SummariesController < ApplicationController
  before_action :find_post_and_topic
  
  def index
    @summaries = Summary.all
    authorize @summaries
   end

  def new
    @summary = Summary.new
    authorize @summary
  end

  def show
    @summary = @post.summary
    authorize @summary
  end

  def edit
    @summary = Summary.find(params[:id])
    authorize @summary
  end

  
  def create
     @summary = @post.build_summary(params.require(:summary).permit(:body))
     authorize @summary
     if @summary.save
       redirect_to [@topic, @post, @summary], notice: "Summary was saved successfully."
     else
       flash[:error] = "Error creating summary. Please try again."
       render :new
     end
   end

   def update
     @summary = Summary.find(params[:id])
     authorize @summary
     if @summary.update_attributes(params.require(:summary).permit(:body))
       redirect_to @summary
     else
       flash[:error] = "Error saving topic. Please try again."
       render :edit
     end
   end

   private

   def find_post_and_topic
    @post = Post.find(params[:post_id])
    @topic = Topic.find(params[:topic_id])
   end

end
