class BooksController < ApplicationController
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
end
