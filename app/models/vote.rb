class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
   

  validates :user_id, presence: true
  validates :post_id, presence: true
  validates :contest_id, presence: true
  validates :contest_type, presence: true
end
