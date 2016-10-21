class User < ApplicationRecord
  validates :name, :email, presence: true
  validates :email, uniqueness: {case_sensitive: false}

  has_secure_password

  def received_messages
    Message.where(recipient: self)
  end

  def sent_messages
    Message.where(sender: self)
  end

  def latest_received_messages(n)
    received_message.order(created_at: :desc).limit(n)
  end

  def incoming_messages
    Message.where(recipient_id: id)
  end

  def unread_messages
    received_messages.unread
  end

  def to_s
    email
  end
end
