class Post < ApplicationRecord
  belongs_to :user
  default_scope -> {order(created_at: :desc)}             ##### lambda literal , stabby lambda ,  stabby literal
  validates :user_id , presence: true
  validates :content , presence: true , length: {maximum: 140}
end
