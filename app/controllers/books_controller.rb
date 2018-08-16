class BooksController < ApplicationController
	before_action :authenticate_user!, :except => [:index]
	respond_to :js, :json, :html
	def index
		@books = Book.page params[:page]
	end
	def new
		@book = Book.new
	end
	def info
		@search_results = Naver::Search.book(query: params[:info])
	end
	def create
		book = Book.new(book_params)
		book.user_id = current_user.id
		if params[:book][:cost] != 0
			book.discount = ((params[:book][:cost].to_f - params[:book][:price].to_f) / params[:book][:cost].to_f * 100).round(2)
		end
		book.save
		redirect_to root_path
	end
	def destroy
		book = Book.find(params[:id])
		book.destroy
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
	      @books=Book.where(sell: false).page params[:page]
	    else
	      @books = Book.where("author LIKE ? OR bookname LIKE ?", "%#{search}%", "%#{search}%").page params[:page]
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
		@books = @user.books.all
		@recent_books = @books.last(4)
		@likes = @user.likes.all
		@recent_likes = @likes.last(4)
 	end
	def mybook
		@user = current_user
		@books = @user.books.page params[:page]
	end
	def myzzim
		@user = current_user
		@likes = @user.likes.page params[:page]
	end
    private
    def book_params
       params.require(:book).permit(:bookname, :author, :price, :content, {img_url: []})
    end
end
