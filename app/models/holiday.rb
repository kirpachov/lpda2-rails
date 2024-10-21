# frozen_string_literal: true

# This model will manage:
# - Weekly closing days (e.g. every Monday)
# - Weekly closing periods (e.g. every Monday from 11:00 to 15:00)
# - Specific days when the restaurant is closed (once)
# - Periods when the restaurant is closed (adiacents days, whole day)
# Possible configurations:
# 1. Need to specify a period when the restaurant is closed.
# { from_timestamp: <First day, 00:01>, to_timestamp: <Last day of the week, 23.59> }
# 2. Need to specify a single day when the restaurant is closed (the whole day).
# { from_timestamp: <Day, 00:01>, to_timestamp: <Day, 23:59> }
# 3. Need to close the restaurant just for a morning or evening once.
# { from_timestamp: <Day, 11:00>, to_timestamp: <Day, 15:00> }
# 4. Need to close the restaurant for a specific weekday: weekly closing day.
# { from_timestamp: <First day, 00:01>, to_timestamp: nil, weekday: 1, weekly_from: <00:01>, weekly_to: <23:59> }
# So, if one of `weekly_from`, `weekly_to` and `weekday` is specified, all are required. If none is specified, they can be nil.
class Holiday < ApplicationRecord
  # ##############################
  # Constants, settings, modules, et...
  # ##############################
  include TrackModelChanges

  extend Mobility
  translates :message

  # ##############################
  # Hooks
  # ##############################
  before_validation :assign_defaults, on: :create
  before_validation :auto_assign_weekday_from_timestamp

  # ##############################
  # Validations
  # ##############################
  validates :from_timestamp, presence: true
  validates :to_timestamp, presence: true, if: -> { weekly_from.blank? && weekly_to.blank? && weekday.blank? }
  validates :weekly_from, presence: true, if: -> { weekly_to.present? || weekday.present? }
  validates :weekly_to, presence: true, if: -> { weekly_from.present? || weekday.present? }
  validates :weekday, presence: true, if: -> { weekly_from.present? || weekly_to.present? }
  validate :weekly_to_less_than_weekly_from, if: -> { weekly_from.present? && weekly_to.present? }

  # ##############################
  # Scopes
  # ##############################
  scope :visible, -> { where("to_timestamp IS NULL OR to_timestamp >= :now", now: Time.zone.now) }
  scope :active_at, ->(time) {
    time = DateTime.parse(time.to_s) unless time.respond_to?(:strftime) && time.respond_to?(:wday)

    base = where("from_timestamp <= :time AND (to_timestamp IS NULL OR to_timestamp >= :time)", time: time)
    base.where(weekly_from: nil, weekly_to: nil, weekday: nil).or(
      base.where("weekly_from <= :hour AND weekly_to >= :hour AND weekday = :weekday", hour: time.strftime("%k:%M"), weekday: time.wday)
    )
  }

  # ##############################
  # Instance methods
  # ##############################
  def weekly_to_less_than_weekly_from
    return if weekly_to.blank? || weekly_from.blank?

    errors.add(:weekly_to, :less_than_weekly_from) if weekly_to < weekly_from
  end

  def weekly?
    weekly_from.present? || weekly_to.present? || weekday.present?
  end

  def assign_defaults
    self.from_timestamp ||= Time.zone.now
  end

  def auto_assign_weekday_from_timestamp
    return if weekday.present? || from_timestamp.blank?
    return if weekly_from.blank? || weekly_to.blank?

    self.weekday = from_timestamp.wday
  end
end
