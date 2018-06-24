class MessagesController < ApplicationController
	respond_to :js, :json, :html
	def create
		@conversation = Conversation.includes(:recipient).find(params[:conversation_id])
		@message = @conversation.messages.create(message_params)
	end

	private
	def message_params
		params.require(:message).permit(:user_id, :body)
	end
end
