class Book < ApplicationRecord
  mount_uploader :img_url, ImageUploader
  belongs_to :user
  has_many :likes
  has_many :liked_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy
end
