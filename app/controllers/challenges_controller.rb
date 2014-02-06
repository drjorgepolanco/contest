class ChallengesController < ApplicationController
  before_action :set_challenge, only: [:show, :edit, :update, :destroy]

  def index
    @challenges = Challenge.all
    @feed_items = current_user.feed
  end

  def show
    @contest = @challenge
    @posts = @contest.posts
    @post = Post.new
    @feed_items = current_user.feed
    @title = "#{@contest.title.titleize}'s Posts"
  end

  def new
    @challenge = Challenge.new
    @feed_items = current_user.feed
  end

  def edit
    @feed_items = current_user.feed
  end

  def create
    @challenge = Challenge.new(challenge_params)

    respond_to do |format|
      if @challenge.save
        format.html { redirect_to @challenge, notice: "#{@challenge.title.titleize} was successfully created." }
        format.json { render action: 'show', status: :created, location: @challenge }
      else
        format.html { render action: 'new' }
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @challenge.update(challenge_params)
        format.html { redirect_to @challenge, notice: "#{@challenge.title.titleize} was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @challenge.destroy
    respond_to do |format|
      format.html { redirect_to challenges_url }
      format.json { head :no_content }
    end
  end

  private
    def set_challenge
      @challenge = Challenge.find(params[:id])
    end

    def challenge_params
      params.require(:challenge).permit(:user_id, :title, :description, :views, :tag, :image)
    end
end
