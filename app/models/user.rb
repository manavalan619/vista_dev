# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  authentication_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  archived_at            :datetime
#  first_name             :string
#  last_name              :string
#  job_title              :string
#  company                :string
#  address                :string
#  onboarding_complete    :boolean          default(FALSE)
#  gender                 :string
#  preferences            :jsonb
#
# Indexes
#
#  index_users_on_authentication_token  (authentication_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_first_name            (first_name)
#  index_users_on_last_name             (last_name)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ApplicationRecord
  TRACKED_ATTRS = %i[
    first_name last_name job_title company address email encrypted_password
    onboarding_complete reset_password_sent_at
  ].freeze

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_secure_token :authentication_token

  has_paper_trail only: TRACKED_ATTRS, class_name: 'Versions::UserVersion'

  has_one :photo, as: :owner, dependent: :destroy, inverse_of: :owner
  has_many :profile_requests, dependent: :destroy
  has_many :shares, dependent: :destroy
  has_many :authorised_branches, -> { Share.authorised },
           through: :shares, source: :branch
  has_many :answers, dependent: :destroy, class_name: 'UserAnswer'
  has_many :devices, dependent: :destroy
  has_many :ignores, dependent: :destroy
  has_many :ignored_categories,
           through: :ignores,
           class_name: 'Category',
           source: :category
  has_many :interactions, dependent: :destroy
  has_many :moods, -> { where(type: 'mood') },
           class_name: 'Interaction',
           inverse_of: :user
  # NB: THIS WILL NEED TO CHANGE IF / WHEN WE INTRODUCE NEW TYPES
  has_many :recommendations, -> { where.not(type: 'mood') },
           class_name: 'Interaction',
           inverse_of: :user
  has_many :notifications, dependent: :destroy
  has_many :check_ins, dependent: :destroy
  has_many :future_check_ins, -> { future }, class_name: 'CheckIn'
  has_many :member_requests
  has_many :member_request_messages, as: :messageable

  accepts_nested_attributes_for :photo
  accepts_nested_attributes_for :answers

  enforce_nil :first_name, :last_name, :job_title, :company, :address, :gender

  scope :in_member_ids, lambda { |*member_ids|
    hashids = Hashids.new(Rails.application.secrets.hashid_salt, 6)
    decoded = member_ids.flatten.map { |id| hashids.decode(id).first }
    where(id: decoded)
  }
  scope :search, lambda { |term|
    where('users.first_name ILIKE :t OR users.last_name ILIKE :t', t: "%#{term}%")
  }
  scope :arriving_soonest_at_branch, lambda { |branch|
    joins(Arel.sql(%{
      LEFT OUTER JOIN "check_ins" ON "check_ins"."user_id" = "users"."id"
      AND DATE("check_ins"."arrival_date") >= DATE('#{Date.today}')
      AND "check_ins"."branch_id" = '#{branch.id}'
    })).order('"check_ins"."arrival_date" ASC, "users"."id" DESC')
  }
  scope :before, ->(id) { where('users.id < ?', id) }
  scope :before_member_id, lambda { |member_id|
    hashids = Hashids.new(Rails.application.secrets.hashid_salt, 6)
    decoded = hashids.decode(member_id).first
    before(decoded)
  }

  def avatar=(file)
    assign_attributes(photo_attributes: { image: file })
  end

  def name
    [first_name, last_name].join(' ')
  end

  def name=(name)
    first_name, last_name = name.split(' ')
    assign_attributes(first_name: first_name, last_name: last_name)
  end

  def member_id
    Rails.cache.fetch([self, :member_id]) do
      hashids = Hashids.new(Rails.application.secrets.hashid_salt, 6)
      hashids.encode(id)
    end
  end

  def mood
    Rails.cache.fetch([self, Date.current, :mood]) do
      moods.newest_first.for_today.limit(1).pluck(:description).first
    end
  end

  # TODO: maybe persist this in DB as a slug
  def self.find_by_member_id(member_id)
    hashids = Hashids.new(Rails.application.secrets.hashid_salt, 6)
    find(hashids.decode(member_id).first)
  end

  def hidden_categories
    preferences && preferences["hidden_categories"]
  end
end
