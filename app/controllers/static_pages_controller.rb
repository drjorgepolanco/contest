class StaticPagesController < ApplicationController
  def home
    @post = current_user.posts.build if signed_in?
  end

  def about
  end

  def help
  end

  def contact
  end
end
