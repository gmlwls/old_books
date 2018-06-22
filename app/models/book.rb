class Book < ApplicationRecord
	mount_uploader :img_url, ImageUploader
  belongs_to :user
end
