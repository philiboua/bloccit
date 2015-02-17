class SummariesController < ApplicationController
  
  def index
    @post = Post.find(params[:id])
    @summaries = Summary.all
    authorize @summaries
   end

  def new
    @post = Post.find(params[:id])
    @summary = Summary.new
    authorize @summary
  end

  def show
    @post = Post.find(params[:id])
    @summary = Summary.find(params[:id])
    authorize @summary
  end

  def edit
    @post = Post.find(params[:id])
    @summary = Summary.find(params[:id])
    authorize @summary
  end

  
  def create
     @summary = Summary.new(params.require(:summary).permit(:body))
     authorize @summary
     if @summary.save
       redirect_to @summary, notice: "Topic was saved successfully."
     else
       flash[:error] = "Error creating topic. Please try again."
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

end
