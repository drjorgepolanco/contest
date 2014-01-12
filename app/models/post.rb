class Post < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :image, presence: true
  validates :title, presence: true, length: { maximum: 70 }
  validates :user_id, presence: true
end
