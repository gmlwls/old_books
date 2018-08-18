class BooksController < ApplicationController
	before_action :authenticate_user!, :except => [:index, :introduction, :sgmail]
	respond_to :js, :json, :html
	def index
		@books = Book.order('created_at DESC').page params[:page]
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
		if params[:book][:cost].to_f != 0.0
			book.discount = ((params[:book][:cost].to_f - params[:book][:price].to_f) / params[:book][:cost].to_f * 100).round(2)
		end
		book.save
		redirect_to root_path
	end
	def destroy
		book = Book.find(params[:id])
		book.destroy
		notification = NewNotification.where(link: "/books/#{params[:id]}")
		notification.destroy_all
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
	      @books=Book.where(sell: false).order('created_at DESC').page params[:page]
	    else
	      @books = Book.where("author LIKE ? OR bookname LIKE ?", "%#{search}%", "%#{search}%").order('created_at DESC').page params[:page]
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
		@books = @user.books.page params[:page]
		@likes = @user.likes.page params[:page]
		@noti = @user.new_notifications.order('created_at DESC').all
 	end
	def old_mypage
		@user = current_user
		@books = @user.books.all
		@recent_books = @books.last(4)
		@likes = @user.likes.all
		@recent_likes = @likes.last(4)
 	end
    private
    def book_params
       params.require(:book).permit(:bookname, :author, :price, :content, {img_url: []})
    end
end
