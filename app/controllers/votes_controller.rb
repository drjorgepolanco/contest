class VotesController < ApplicationController
  before_action :set_vote, only: [:destroy]
  before_action :set_post

  def create
    @vote = current_user.votes.build(post_id: @post.id)
    respond_to do |format|
      if @vote.save
        format.html { redirect_to post_path(@post.id), notice: 'You are now subscribed to this post.' }
      else
        format.html { redirect_to post_path(@post.id), alert: 'Your vote could not be processed.' }
      end
    end
  end

  def destroy
    @vote.destroy
    respond_to do |format|
      format.html { redirect_to post_path(@post.id), notice: 'You are now unsubscribed from this post.' }
      format.json { head :no_content }
    end
  end

  private

    def set_vote
      @vote = Vote.find(params[:id])
    end

    def set_post
      @post = Post.find(params[:post_id])
    end
end
