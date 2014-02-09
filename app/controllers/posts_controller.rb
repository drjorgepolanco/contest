class PostsController < ApplicationController
  before_action :signed_in_user, only: [:index, :show, :edit, :update, :create, :destroy]
  before_action :correct_user,   only: :destroy

  def index
    @posts = Post.all
    @feed_items = current_user.feed
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @followers = @user.followers.limit(6)
    @commentable = @post
    @comments = @commentable.comments
    @comment = Comment.new
    if signed_in?
      @feed_items = current_user.feed
    end
  end

  def new
    if signed_in?
      @post = current_user.posts.build
      @feed_items = current_user.feed
    end
  end

  def create
    @post = current_user.posts.build(post_params)
      respond_to do |format|
        if @post.save
          format.html { redirect_to @post, notice: "#{@post.title.titleize} was successfully created." }
          format.json { render action: 'show', status: :created, location: @post }
        else
          format.html { render action: 'new' }
          # render 'static_pages/home'
          @feed_items = []
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
  end

  def edit
    @title = "Edit Post!"
    @post = Post.find(params[:id])
    @user = current_user
    @feed_items = current_user.feed
  end

  def update
    @post = Post.find(params[:id])
    respond_to do |format|
      if @post.update_attributes(post_params)
        format.html { redirect_to @post, :notice => "#{@post.title.titleize} was succesfully updated." }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  private

    def post_params
      params.require(:post).permit(:title, :description, :image)
    end

    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end
end