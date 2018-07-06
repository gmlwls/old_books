class RepliesController < ApplicationController
  def new
  	@comment = Comment.find(params[:comment_id])
  	@book = Book.find(params[:book_id])
  	@reply = Reply.new
  end
  def create
    @book = Book.find(params[:book_id])
    @comment = Comment.find(params[:comment_id])
    @reply = @comment.replies.build(comment_params)
    @reply.user_id = current_user.id
    @reply.save
  end
    private
  def comment_params
    params.require(:reply).permit(:content, :comment_id)
  end
end
