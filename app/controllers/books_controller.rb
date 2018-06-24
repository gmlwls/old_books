class BooksController < ApplicationController
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
		book.classname = params[:book][:classname]
		book.price = params[:book][:price]
		book.major = params[:book][:major]
		book.state = params[:book][:state]
		book.img_url = params[:book][:image]
		book.method = params[:book][:method]
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
end
