class PushNotificationJob < ApplicationJob
  queue_as :default

  def perform(notification)
    @notification = notification

    @notification.user.devices.each do |device|
      create_ios_notification(device) if device.ios?
      create_android_notification(device) if device.android?
    end
  end

  private

  def notification_type
    @notification.human_type
  end


  def ios_notification_data
    { type: notification_type, object_id: @notification.object_id }
  end

  def android_notification_data
    { type: notification_type, title: notification_title, object_id: @notification.object_id }
  end

  def create_ios_notification(device)
    app = Rpush::Apnsp8::App.find_by(name: 'ios_member_app')
    # Bail out if no RPush app setup
    return unless app

    notification = Rpush::Apns::Notification.new
    notification.app = app
    notification.device_token = device.token
    notification.alert = notification_title
    notification.data = ios_notification_data
    notification.save!
  end

  def create_android_notification(device)
    app = Rpush::Gcm::App.find_by(name: 'android_member_app')
    # Bail out if no RPush app setup
    return unless app

    notification = Rpush::Gcm::Notification.new
    notification.app = app
    notification.registration_ids = [device.token]
    notification.data = android_notification_data
    notification.content_available = false
    notification.priority = 'normal' # Optional, can be either 'normal' or 'high'
    notification.save!
  end

  def notification_title
    name = @notification.name
    I18n.t("notifications.#{notification_type}.title", name: name)
  end
end
