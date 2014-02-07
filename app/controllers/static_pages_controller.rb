class StaticPagesController < ApplicationController
  def home
    if signed_in?
      # @post = current_user.posts.build
      @feed_items = current_user.feed
      @posts = Post.all
    end
  end

  def about
    if signed_in?
      @feed_items = current_user.feed
    end
  end

  def help
    if signed_in?
      @feed_items = current_user.feed
    end
  end

  def contact
    if signed_in?
      @feed_items = current_user.feed
    end
  end
end
