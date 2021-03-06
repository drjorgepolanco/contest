class PollPostsController < ApplicationController
  before_action :signed_in_user, only: :create
  before_filter :load_contest

  def index
    @posts = @contest.posts
    @feed_items = current_user.feed
    @title = "#{@contest.title.titleize}'s Posts"
  end

  def new
    @post = @contest.posts.new
    @feed_items = current_user.feed
  end

  def create
    @post = @contest.posts.new(post_params)
    respond_to do |format|
      if @post.save
        format.html { redirect_to @contest, notice: "The Post was succesfully added to this Contest" }
        format.json { render action: 'show', status: :created, location: @post }
      else
        format.html { render action: 'new' }
        @feed_items = []
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

private

  def post_params
    params.require(:post).permit(:title, :description, :image, :user_id)
  end

  def load_contest
    resource, id = request.path.split('/')[1, 2]
    @contest = resource.singularize.classify.constantize.find(id)
  end
end