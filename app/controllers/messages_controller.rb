class MessagesController < ApplicationController
  before_action :require_user!

  def incoming
    @incoming_messages = current_user.incoming_messages
  end
end
