class MessagesController < ApplicationController
  before_action :require_user!

  def index
    load_user
    @user = User.find params[:user_id]
    @message = @user.sent_messages.build message_params
      if @messages.save
      else
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
