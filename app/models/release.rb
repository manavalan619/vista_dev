# == Schema Information
#
# Table name: releases
#
#  id         :bigint(8)        not null, primary key
#  file       :string
#  status     :string           default("queued")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Release < ApplicationRecord
  STATUSES = %w[queued processing complete].freeze

  mount_uploader :file, ReleaseFileUploader

  default_scope -> { order(created_at: :desc) }
  scope :complete, -> { where(status: 'complete') }

  def self.latest
    complete.limit(1).first
  end

  def self.latest_timestamp
    complete.limit(1).pluck(:created_at).first
  end

  def self.latest_id
    complete.limit(1).pluck(:id).first
  end

  def latest?
    Release.latest_id == id
  end

  STATUSES.each do |method_name|
    define_method("#{method_name}?") { status == method_name }
  end

  after_commit :generate_json, on: :create

  def process!(args = {})
    update(args.merge(status: 'processing'))
    ActionCable.server.broadcast('release_channel', id: id, status: 'processing')
  end

  def complete!(args = {})
    update(args.merge(status: 'complete'))
    ActionCable.server.broadcast('release_channel', id: id, status: 'complete')
  end

  private

  def generate_json
    ReleaseJob.perform_later(self)
  end
end
