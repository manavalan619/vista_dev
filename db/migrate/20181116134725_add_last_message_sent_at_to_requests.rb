class AddLastMessageSentAtToRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :member_requests, :last_message_sent_at, :datetime, default: -> { 'CURRENT_TIMESTAMP' }
  end
end
