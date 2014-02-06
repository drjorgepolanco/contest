class StaticPagesController < ApplicationController
  def home
    if signed_in?
      # @post = current_user.posts.build
      @feed_items = current_user.feed
      @posts = Post.all
    end
  end

  def about
    @feed_items = current_user.feed
  end

  def help
    @feed_items = current_user.feed
  end

  def contact
    @feed_items = current_user.feed
  end
end
