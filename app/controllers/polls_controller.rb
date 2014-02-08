  class PollsController < ApplicationController
  before_action :set_poll, only: [:show, :edit, :update, :destroy]

  def index
    @polls = Poll.all
    @feed_items = current_user.feed
  end

  def show
    @contest = @poll
    @posts = @contest.posts
    @post = Post.new
    @feed_items = current_user.feed
    @title = "#{@contest.title.titleize}'s Posts"
  end

  def new
    @poll = Poll.new
    @feed_items = current_user.feed
  end

  def edit
    @feed_items = current_user.feed
  end

  def create
    @poll = Poll.new(poll_params)

    respond_to do |format|
      if @poll.save
        format.html { redirect_to @poll, notice: "#{@poll.title.titleize} was successfully created." }
        format.json { render action: 'show', status: :created, location: @poll }
      else
        format.html { render action: 'new' }
        format.json { render json: @poll.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @poll.update(poll_params)
        format.html { redirect_to @poll, notice: "#{@poll.title.titleize} was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @poll.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @poll.destroy
    respond_to do |format|
      format.html { redirect_to polls_url }
      format.json { head :no_content }
    end
  end

  private
    def set_poll
      @poll = Poll.find(params[:id])
    end

    def poll_params
      params.require(:poll).permit(:user_id, :title, :description, :views, :tag, :image)
    end
end
