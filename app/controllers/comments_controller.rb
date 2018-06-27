class CommentsController < ApplicationController
  respond_to :js, :json, :html
  def create
    @book = Book.find(params[:book_id])
    @comment = @book.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment.save

    @new_notification = NewNotification.create! user: @book.user, content: "#{current_user.username}님이 #{@book.bookname}책에 댓글을 달았습니다.", link: book_path(@book)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :book_id)
  end
end
