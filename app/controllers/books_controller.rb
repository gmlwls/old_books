class BooksController < ApplicationController
	before_action :authenticate_user!, :except => [:index]
	respond_to :js, :json, :html
	def index
		@books = Book.all
	end
	def new
		@book = Book.new
	end
	def create
		book = Book.new
		book.user_id = current_user.id
		book.bookname = params[:book][:bookname]
		book.author = params[:book][:author]
		book.price = params[:book][:price]
		book.img_url = params[:book][:image]
		book.content = params[:book][:content]
		book.save
		redirect_to root_path
	end
	def show
		@book = Book.find(params[:id])
	end
	def like_toggle
		@book = Book.find(params[:book_id])
		like = Like.find_by(user_id: current_user.id, book_id: params[:book_id])
		if like.nil?
			Like.create(user_id: current_user.id, book_id: params[:book_id])
		else
			like.destroy
		end
	end
	def find
		search = params[:search]
	    if search.nil? || search.empty?
	      @books=Book.all
	    else
	      @books = Book.where("author LIKE ? OR bookname LIKE ?", "%#{search}%", "%#{search}%")
	    end
	end
	def sell
		@book = Book.find(params[:book_id])
		if @book.sell
			@book.sell = false
		else
			@book.sell = true
		end
		@book.save
	end
	def mypage
		@user = current_user
		@books = @user.books.last(4)
		@likes = @user.likes.all
	end
end
