class RepliesController < ApplicationController
  before_action :authenticate_user!
  def new
  	@comment = Comment.find(params[:comment_id])
  	@book = Book.find(params[:book_id])
  	@reply = Reply.new
  end
  def create
    @book = Book.find(params[:book_id])
    @comment = Comment.find(params[:comment_id])
    @reply = @comment.replies.build(reply_params)
    @reply.user_id = current_user.id
    @reply.save

    # if @comment.user_id != current_user.id
      @new_notification = NewNotification.create! user: @comment.user, content: "#{current_user.username}님이 회원님의 댓글에 대댓글을 달았습니다. (#{@book.bookname})" ,content_truncate: "#{current_user.username}님이 회원님의 댓글에 대댓글을 달았습니다. (#{@book.bookname})".truncate(20, omission: '...'), link: book_path(@book)
    # end

    redirect_to "/books/#{@book.id}/#reply-#{@reply.id}"

  end
  def destroy
    @reply = Reply.find(params[:id])
    @id = @reply.comment.book.id
    @reply.destroy
    redirect_to "/books/#{@id}#comment-box"
  end
  def edit
    @reply = Reply.find(params[:id])
  end
  def update 
    @reply = Reply.find(params[:id])
    @comment = @reply.comment
    @book = @comment.book
    @reply.update(reply_params)
  end


    private
  def reply_params
    params.require(:reply).permit(:content, :comment_id)
  end
end
