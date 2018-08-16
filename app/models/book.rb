class Book < ApplicationRecord
  serialize :img_url, Array
  mount_uploaders :img_url, ImageUploader
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy
end
