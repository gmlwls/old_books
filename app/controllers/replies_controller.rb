class RepliesController < ApplicationController
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

    redirect_to "/books/#{@book.id}/#reply-#{@reply.id}"

  end
  def destroy
    @reply = Reply.find(params[:id])
    @reply.destroy
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
