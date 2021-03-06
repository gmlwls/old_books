class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :redirect_except_owner, only: %i[destroy]
  respond_to :js, :json, :html
  def create
    @book = Book.find(params[:book_id])
    @comment = @book.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment.save

    

    if @book.user_id != current_user.id
      @new_notification = NewNotification.create! user: @book.user, content: "#{current_user.username}님이 #{@book.bookname}책에 댓글을 달았습니다." ,content_truncate: "#{current_user.username}님이 #{@book.bookname}책에 댓글을 달았습니다.".truncate(20, omission: '...'), link: book_path(@book)
    end
    redirect_to "/books/#{@book.id}/#comment-#{@comment.id}"
  end

  def destroy
    print(@comment)
    @id = @comment.book.id
    @comment.destroy
    redirect_to "/books/#{@id}#comment-box"
  end
  def edit
    @comment = Comment.find(params[:id])

  end
  def update 
    @comment = Comment.find(params[:id])
    @book = @comment.book
    @comment.update(comment_params)
    redirect_to "/books/#{@book.id}/#comment-#{@comment.id}"
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :book_id, :secret)
  end
  def redirect_except_owner
    @comment = Comment.find(params[:id])
    if @comment.user.id != current_user.id
      redirect_to root_path
    end
  end
end
