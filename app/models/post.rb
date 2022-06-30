class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  default_scope -> {order(created_at: :desc)}             ##### lambda literal , stabby lambda ,  stabby literal
  validates :user_id , presence: true
  validates :content , length: {maximum: 140}             #presence: true
  # with_options if: :image do |f|
  #   f.validates :content , presence: true , length: {maximum: 140}
  # end
  validates :image , content_type:{ in: %w[image/jpeg image/gif image/png],message: "must be a valid image format"} ,size: {less_than: 5.megabytes, message: "should be less than 5mb "}     

  def display_image
    image.variant(resize_to_limit: [700, 700])
  end
  
end
