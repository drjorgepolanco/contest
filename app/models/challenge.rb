class Challenge < ActiveRecord::Base
  belongs_to :user
  has_many :posts, as: :contest
  has_many :comments, as: :commentable, dependent: :destroy
  default_scope -> { order('created_at DESC') }
  validates :image, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :user_id, presence: true


  # def self.from_users_followed_by(user)
  #   followed_user_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
  #   where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user.id)
  # end
end
