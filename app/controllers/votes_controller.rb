class VotesController < ApplicationController
  before_action :signed_in_user

  def create
    @vote = current_user.votes.create(vote_params)
    # @vote.contest_id = Contest.find_by_id(params[:vote][:contest_id]).id
    redirect_to :back
    @posts = @contest.posts
    @vote = @posts.votes.new(vote_params)
  end

  private

    def vote_params
      params.require(:vote).permit(:up, :user_id, :post_id, :contest_id)
    end
end