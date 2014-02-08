class CommentsController < ApplicationController
  before_action :signed_in_user, only: [:index, :show, :edit, :update, :create, :destroy]
  before_filter :load_commentable

  def index
    @comments = @commentable.comments
    @feed_items = current_user.feed
  end

  def new
    @comment = @commentable.comments.new
    @feed_items = current_user.feed
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    if @comment.save
      redirect_to @commentable, notice: "Your comment was succesfully posted!"
    else
      render :new
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    @feed_items = current_user.feed
  end

  def update
    @comment = Comment.find(params[:id])
    respond_to do |format|
      if @comment.update_attributes(comment_params)
        format.html { redirect_to @comment, :notice => "#{@comment.title.titleize} was succesfully updated." }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  private

  def load_commentable
    resource, id =  request.path.split('/')[1,2]
    @commentable = resource.singularize.classify.constantize.find(id)
  end

  def comment_params
    params.require(:comment).permit(:user_id, :content)
  end
end
