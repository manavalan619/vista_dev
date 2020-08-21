class ProfileProgressJob < PushNotificationJob
  def perform
    User.find_each do |user|
      @count = user.answers.count

      user.devices.each do |device|
        create_ios_notification(device) if device.ios?
        create_android_notification(device) if device.android?
      end
    end
  end

  private

  def notification_type
    'profile_progress'
  end

  def ios_notification_data
    { type: notification_type }
  end

  def notification_title
    I18n.t("notifications.#{notification_type}.title", count: @count)
  end
end
