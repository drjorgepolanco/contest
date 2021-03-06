class UsersController < ApplicationController
  before_action :signed_in_user,  only: [:index, :show, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user,    only: [:edit, :update]
  before_action :admin_user,      only: :destroy


  def index
    @users = User.all
    @feed_items = current_user.feed
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    # @challenges = @user.challenges
    # @polls = @user.polls
    @feed_items = current_user.feed
    @followers = @user.followers.limit(6)
    @commentable = @user
    @comments = @commentable.comments
    @comment = Comment.new
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Talentcrops!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @feed_items = current_user.feed
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_path
  end

  def following
    @title = "Followed Users"
    @user = User.find(params[:id])
    @users = @user.followed_users
    @feed_items = current_user.feed
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers
    @feed_items = current_user.feed
    render 'show_follow'
  end

  def posts
    @user = User.find(params[:id])
    @posts = @user.posts
    @feed_items = @user.feed
  end

  def challenges
    @user = User.find(params[:id])
    @challenges = @user.challenges
    @challenges = @user.challenges
    @feed_items = @user.feed
  end

  def polls
    @user = User.find(params[:id])
    @polls = @user.polls
    @feed_items = @user.feed
  end
  
  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, 
                                  :email, :profile_pic, :tag, :info, 
                                  :date_of_birth, :password, 
                                  :password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
