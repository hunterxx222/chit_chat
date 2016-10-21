class MessagesController < ApplicationController
  before_action :require_user!

  def incoming
    @incoming_messages = current_user.incoming_messages
  end

  def show
    @message = Message.find params[:id]
    if @message.unread? && current_user == @message.recipient
      @message.mark_as_read!
    end
  end

  def sent
    load_user
    @message = @user.sent_message
  end

  def received
    load_user
    @message = @user.received_message
  end

  def load_user
    if params[:user_id]
      @user = User.find params[:user_id]
    else
      @user = current_user
    end
  end
end
