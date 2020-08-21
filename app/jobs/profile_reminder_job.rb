class ProfileReminderJob < PushNotificationJob
  def perform(user)
    user.devices.each do |device|
      create_ios_notification(device) if device.ios?
      create_android_notification(device) if device.android?
    end
  end

  private

  def notification_type
    'profile_reminder'
  end

  def ios_notification_data
    { type: notification_type }
  end

  def notification_title
    I18n.t("notifications.#{notification_type}.title")
  end
end
