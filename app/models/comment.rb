class Comment < ApplicationRecord
  belongs_to :book
  belongs_to :user
  has_many :replies, dependent: :destroy
end
