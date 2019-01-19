class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  validates :username, presence: true
  validates :school, presence: true
  validates :studentid, presence: true
  validates :email, presence: true

  has_many :books, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_books, through: :likes, source: :book
  has_many :comments, dependent: :destroy
  has_many :replies, dependent: :destroy

  acts_as_reader
  has_many :new_notifications
  
  def is_like?(book)
  	Like.find_by(user_id: self.id, book_id: book.id).present?
  end
end
