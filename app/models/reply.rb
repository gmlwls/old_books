class Reply < ApplicationRecord
  validates :content, presence: true
  belongs_to :comment
  belongs_to :user
end
