# frozen_string_literal: true

class PublicCreateReservation < ActiveInteraction::Base
  interface :params, methods: %i[[] merge! fetch each has_key?], default: {}

  validate :datetime_is_valid
  validate :datetime_format_is_valid
  validate :datetime_is_not_in_the_past
  validate :datetime_has_reservation_turn
  validate :datetime_is_in_valid_reservation_turn_step
  # TODO validate datetime is not in a holiday.

  validate :people_count_is_valid
  validate :people_count_is_not_zero
  validate :people_count_is_not_greater_than_max_people_count

  validate :email_is_present
  validate :email_is_valid
  validate :no_other_reservations_for_this_email_and_datetime

  validate :first_name_is_present
  validate :first_name_is_valid

  validate :last_name_is_present
  validate :last_name_is_valid

  validate :phone_is_present
  validate :phone_is_valid

  attr_reader :reservation

  def execute
    @reservation = Reservation.new(
      fullname: "#{first_name} #{last_name}",
      datetime:,
      people:,
      email:,
      phone:,
      notes: params[:notes].to_s.strip,
      other: {
        first_name:,
        last_name:
      }
    )

    errors.merge!(@reservation.errors) unless @reservation.valid? && @reservation.save

    @reservation
  end

  # ###################################
  # Utils methods
  # ###################################
  def datetime
    return @datetime if defined?(@datetime)

    @datetime = params[:datetime].is_a?(String) ? params[:datetime].to_datetime : params[:datetime]
  rescue Date::Error => e
    errors.add(:datetime, "is not a valid datetime: #{e.message}")
    @datetime = nil
  end

  def first_name
    @first_name ||= params[:first_name].to_s.strip.split(' ').map(&:capitalize).join(' ')
  end

  def last_name
    @last_name ||= params[:last_name].to_s.strip.split(' ').map(&:capitalize).join(' ')
  end

  def email
    @email ||= params[:email].to_s.strip
  end

  def phone
    @phone ||= params[:phone].to_s.gsub(/[.\-()\s]+/, '')
  end

  def people
    @people ||= params[:people].to_i
  end

  def max_people_count
    @max_people_count ||= Setting[:max_people_per_reservation].to_i
  end

  def reservation_turn
    @reservation_turn ||= ReservationTurn.where(weekday: (datetime.wday - 1) % 7)
                                         .where('starts_at <= ? AND ends_at >= ?', datetime.strftime("%k:%M"), datetime.strftime("%k:%M")).first
  end

  # ###################################
  # Validation methods
  # ###################################
  def phone_is_present
    return if phone.present?

    errors.add(:phone, 'is missing')
  end

  def phone_is_valid
    # return if phone.blank? || phone.length >= 5
    return if phone.match(/\A\+?[\d\s\-\(\).]{7,}\z/)

    errors.add(:phone, "#{phone.inspect} is not a valid phone")
  end

  def first_name_is_present
    return if first_name.present?

    errors.add(:first_name, 'is missing')
  end

  def first_name_is_valid
    return if first_name.match(/\A[A-Za-z\s']{2,}\z/)

    errors.add(:first_name, "#{first_name.inspect} is not a valid first name")
  end

  def last_name_is_present
    return if last_name.present?

    errors.add(:last_name, 'is missing')
  end

  def last_name_is_valid
    return if last_name.match(/\A[A-Za-z\s']{2,}\z/)

    errors.add(:last_name, "#{last_name.inspect} is not a valid last name")
  end

  def people_count_is_valid
    return if people.is_a?(Integer)

    errors.add(:people, 'is not a valid number')
  end

  def people_count_is_not_zero
    return if people > 0

    errors.add(:people, 'is zero')
  end

  def people_count_is_not_greater_than_max_people_count
    return if people <= max_people_count

    errors.add(:people, 'is greater than the maximum allowed')
  end

  def datetime_is_valid
    return if datetime.is_a?(DateTime)

    errors.add(:datetime, 'is not a valid datetime')
  end

  def datetime_format_is_valid
    return if params[:datetime].to_s.blank?
    return if params[:datetime].to_s.match(/\A\d{4}-\d{2}-\d{2} \d{2}:\d{2}\z/)

    errors.add(:datetime, "has invalid format. Please use the format: YYYY-MM-DD HH:MM. Got: #{params[:datetime].inspect}")
  end

  def email_is_present
    return if email.present?

    errors.add(:email, 'is empty or missing')
  end

  def email_is_valid
    return if email.match(URI::MailTo::EMAIL_REGEXP)

    errors.add(:email, 'is not a valid email')
  end

  def no_other_reservations_for_this_email_and_datetime
    return if Reservation.visible.where(email:, datetime:).empty?

    errors.add(:email, 'has another reservation for this datetime')
  end

  def datetime_is_not_in_the_past
    return if datetime.nil?
    return if datetime > Time.zone.now

    errors.add(:datetime, 'is in the past')
  end

  def datetime_has_reservation_turn
    return if datetime.nil?
    return if reservation_turn

    errors.add(:datetime, 'is not a valid date: there is no reservation turn for this datetime')
  end

  def datetime_is_in_valid_reservation_turn_step
    return if datetime.nil? || reservation_turn.nil?
    return if datetime.to_i % reservation_turn.step == 0

    errors.add(:datetime, 'is not in a valid reservation turn step')
  end
end