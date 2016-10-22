class MessagesController < ApplicationController
  before_action :require_user!

  def new
    @users = User.all #friends
    @message = Message.new
  end

  def create

    load_user
    @message = @user.sent_messages.build message_params
      if @message.save
        flash[:success] = "Message sent"
      else
        flash[:error] = "Error - Message not sent"
      end
  end

  def incoming
    @incoming_messages = current_user.incoming_messages
  end

  def show
    load_user
    @message = Message.find params[:id]
    if @message.read_at == nil && @user == @message.recipient
      @message.mark_as_read!
    end
  end

  def sent
    load_user
    @messages = @user.sent_messages
  end

  def received
    load_user
    @messages = @user.received_messages
  end

  def load_user
    if params[:user_id]
      @user = User.find params[:user_id]
    else
      @user = current_user
    end
  end

  private
  def message_params
    params.require(:message).permit(:recipient_id, :body)
  end
end
