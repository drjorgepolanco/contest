class ChallengePostsController < ApplicationController
  # before_action :signed_in_user, only: [:edit, :update, :create, :destroy]
  # before_action :correct_user,   only: :destroy
  before_filter :load_contest

  def index
    # @contest = Challenge.find(params[:challenge_id])
    @posts = @contest.posts
  end

  def new
    @post = @contest.posts.new
  end

  def create
    @post = @contest.posts.new(post_params)
    if @post.save
      redirect_to [@contest, :posts], notice: "Your Post was succesfully posted!"
    else
      render :new
    end
  end

private

  def post_params
    params.require(:post).permit(:title, :description, :image, :user_id)
  end

  # def correct_user
  #   @post = current_user.posts.find_by(id: params[:id])
  #   redirect_to root_url if @post.nil?
  # end

  def load_contest
    resource, id = request.path.split('/')[1, 2]
    @contest = resource.singularize.classify.constantize.find(id)
  end
end









#   # def index
#   #   @posts = Post.all
#   #   @feed_items = current_user.feed
#   # end

#   def index
#     if challenge_id.any?
#       @contest = Challenge.find(params[:challenge_id])
#       @posts = @contest.posts
#       @feed_items = current_user.feed
#     else
#       @posts = Post.all
#       @feed_items = current_user.feed
#     end
#   end

#   def show
#     @post = Post.find(params[:id])
#     @user = @post.user
#     @following = @user.followed_users.limit(6)
#     if signed_in?
#       @feed_items = current_user.feed
#     end
#   end

#   def new
#     @post = @contest.posts.new
#     @feed_items = current_user.feed
#   end 

#   def create
#     @post = @contest.posts.new(post_params)
#     if @post.save
#       redirect_to @contest, notice: "Your Post was succesfully posted!"
#     else
#       render :new
#     end
#   end

#   # def new
#   #   if signed_in?
#   #     @post = current_user.posts.build
#   #     @feed_items = current_user.feed
#   #   end
#   # end

#   # def create
#   #   @post = current_user.posts.build(post_params)
#   #     respond_to do |format|
#   #       if @post.save
#   #         format.html { redirect_to @post, notice: 'Your Post was successfully created.' }
#   #         format.json { render action: 'show', status: :created, location: @post }
#   #       else
#   #         format.html { render action: 'new' }
#   #         @feed_items = []
#   #         format.json { render json: @post.errors, status: :unprocessable_entity }
#   #       end
#   #     end

#   #   # if @post.save
#   #   #   flash[:success] = "Post created!"
#   #   #   redirect_to root_url
#   #   # else
#   #   #   @feed_items = []
#   #   #   render 'static_pages/home'
#   #   # end
#   # end

#   def edit
#     @title = "Edit Post!"
#     @post = Post.find(params[:id])
#     @user = current_user
#     @feed_items = current_user.feed
#   end

#   def update
#     @post = Post.find(params[:id])
#     respond_to do |format|
#       if @post.update_attributes(post_params)
#         format.html { redirect_to @post, :notice => "Post succesfully updated." }
#         format.json { head :no_content }
#       else
#         format.html { render :action => "edit" }
#         format.json { render :json => @post.errors, :status => :unprocessable_entity }
#       end
#     end
#   end

#   def destroy
#     # @post = Post.find(params[:id])
#     @post.destroy
#     respond_to do |format|
#       format.html { redirect_to root_path }
#       format.json { head :no_content }
#     end
#   end

#   private

#     def post_params
#       params.require(:post).permit(:title, :description, :image)
#     end

#     def correct_user
#       @post = current_user.posts.find_by(id: params[:id])
#       redirect_to root_url if @post.nil?
#     end

#     def load_contest
#       resource, id = request.path.split('/')[1, 2]
#       @contest = resource.singularize.classify.constantize.find(id)
#     end
# end


#   # def new
#   #   if challenge.id.any?
#   #     @post = @contest.post.new
#   #     @feed_items = current_user.feed
#   #   else
#   #     @post = Post.new
#   #     @feed_items = current_user.feed
#   #   end
#   # end

#   # def create
#   #   if challenge.id.any?
#   #     @post = @contest.post.build(post_params)
#   #     respond_to do |format|
#   #       if @post.save
#   #         format.html { redirect_to @post, notice: 'Your Post was successfully created.' }
#   #         format.json { render action: 'show', status: :created, location: @post }
#   #       else
#   #         format.html { render action: 'new' }
#   #         @feed_items = []
#   #         format.json { render json: @post.errors, status: :unprocessable_entity }
#   #       end
#   #     end
#   #   else
#   #     @post = current_user.posts.build(post_params)
#   #     respond_to do |format|
#   #       if @post.save
#   #         format.html { redirect_to @post, notice: 'Your Post was successfully created.' }
#   #         format.json { render action: 'show', status: :created, location: @post }
#   #       else
#   #         format.html { render action: 'new' }
#   #         @feed_items = []
#   #         format.json { render json: @post.errors, status: :unprocessable_entity }
#   #       end
#   #     end
#   #   end