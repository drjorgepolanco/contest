class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @post  = current_user.posts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
      @posts = Post.all
    end
  end

  def about
  end

  def help
  end

  def contact
  end
end
