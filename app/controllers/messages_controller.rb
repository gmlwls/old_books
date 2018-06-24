class MessagesController < ApplicationController
	respond_to :js, :json, :html
	def create
		@conversation = Conversation.includes(:recipient).find(params[:conversation_id])
		@message = @conversation.messages.create(message_params)
		if Message.create
	        if @message.user.username == @conversation.recipient.username
	            @new_notification = NewNotification.create! user: Conversation.find(params[:conversation_id]).sender,
	            content: "#{current_user.username.truncate(15, omission: '...')} 님으로 부터 메세지가 왔습니다.",
	            link: request.referrer
	                                                   
	        elsif @message.user.username == @conversation.sender.username
	            @new_notification = NewNotification.create! user: Conversation.find(params[:conversation_id]).recipient,
	            content: "#{current_user.username.truncate(15, omission: '...')} 님으로 부터 메세지가 왔습니다.",
	            link: request.referrer
	        end
	    end
	end

	private
	def message_params
		params.require(:message).permit(:user_id, :body)
	end
end
