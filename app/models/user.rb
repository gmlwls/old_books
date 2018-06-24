class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
    
  has_many :likes
  has_many :liked_books, through: :likes, source: :book
  
  acts_as_reader
  has_many :new_notifications
  
  def is_like?(book)
  	Like.find_by(user_id: self.id, book_id: book.id).present?
  end
end
