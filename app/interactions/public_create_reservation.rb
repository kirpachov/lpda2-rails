# frozen_string_literal: true

class PublicCreateReservation < ActiveInteraction::Base
  interface :params, methods: %i[[] merge! fetch each has_key?], default: {}

  validate :datetime_is_valid
  validate :datetime_format_is_valid
  validate :datetime_is_not_in_the_past
  validate :datetime_has_reservation_turn
  validate :datetime_is_in_valid_reservation_turn_step
  validate :datetime_is_not_too_far_in_the_future

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

  validate :lang_is_present

  validate :no_holidays

  validate :table_type_must_be_active

  attr_reader :reservation

  def execute
    @reservation = initialize_reservation

    errors.merge!(reservation.errors) unless reservation.valid? && reservation.save

    create_reservation_payment_if_needed if reservation.valid? && errors.empty?

    if errors.any? && reservation.persisted?
      reservation.destroy
      return nil
    end

    reservation
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
    @first_name ||= namify(params[:first_name])
  end

  def last_name
    @last_name ||= namify(params[:last_name])
  end

  def email
    @email ||= params[:email].to_s.strip
  end

  def phone
    @phone ||= params[:phone].to_s.gsub(/[.\-()\s]+/, "")
  end

  def adults
    @adults ||= params[:adults].to_i
  end

  def children
    @children ||= params[:children].to_i
  end

  def people
    @people ||= adults + children
  end

  def max_people_count
    @max_people_count ||= Setting[:max_people_per_reservation].to_i
  end

  def reservation_turn
    @reservation_turn ||= ReservationTurn.for(datetime)
  end

  def lang
    @lang ||= params[:lang].to_s.strip
  end

  def namify(str)
    str = str.to_s.strip.capitalize

    [
      " ",
      "'"
    ].each do |char|
      next if str.index(char).nil?

      str = str.split(char).map(&:capitalize).join(char)
    end

    str
  end

  def initialize_reservation
    Reservation.new(
      fullname: "#{first_name} #{last_name}",
      datetime:,
      adults:,
      children:,
      email:,
      phone:,
      notes: params[:notes].to_s.strip,
      lang:,
      other: {
        first_name:,
        last_name:
      },
      table_type:
    )
  end

  def table_type
    return @table_type if defined?(@table_type)

    find_table_type
  end

  def find_table_type
    return nil if params[:table_type_id].blank?

    @table_type = TableType.find_by(id: params[:table_type_id])

    errors.add(:base, "table type with id #{params[:table_type_id].inspect} not found.") unless @table_type

    @table_type
  end

  def create_reservation_payment_if_needed
    return unless reservation.requires_payment?

    if table_type
      call = AvailableSeatsForReservationTurnAndPgroup.run(
        pgroup: reservation.required_payment_group,
        table_type:,
        reservation_turn:,
        datetime:
      )

      if call.valid? && call.result < 0
        errors.add(:base, I18n.t("reservations.errors.no_seats_available_for_table_type_for_turn"))
      else
        errors.merge!(call.errors)
      end
    end

    reservation.create_payment! if errors.empty?
  rescue ActiveInteraction::InvalidInteractionError => e
    errors.add(:base, "Issue when creating payment: #{e.message}")

    ExceptionNotifier.notify_exception(
      NexiApiIssue.new(errors.full_messages.join(", ")),
      data: { errors: }
    )
  end

  # ###################################
  # Validation methods
  # ###################################
  def table_type_must_be_active
    return if table_type.nil? || table_type.status == "active"

    errors.add(:base, "table type must be active. got #{table_type&.status}")
  end

  def no_holidays
    return if datetime.blank?

    @holidays = Holiday.active_at(datetime)
    return if @holidays.empty?

    @holidays.each do |h|
      # TODO: i18n is ok?
      errors.add(:base, h.message)
    end
  end

  def phone_is_present
    return if phone.present?

    errors.add(:phone, "is missing")
  end

  def phone_is_valid
    # return if phone.blank? || phone.length >= 5
    return if /\A\+?[\d\s\-().]{7,}\z/.match?(phone)

    errors.add(:phone, "#{phone.inspect} is not a valid phone")
  end

  def first_name_is_present
    return if first_name.present?

    errors.add(:first_name, "is missing")
  end

  def first_name_is_valid
    return if /^[A-Za-zÀ-ÖØ-öø-ÿ'´\-\s]+$/.match?(first_name) && first_name.length >= 2

    errors.add(:first_name, "#{first_name.inspect} is not a valid first name")
  end

  def last_name_is_present
    return if last_name.present?

    errors.add(:last_name, "is missing")
  end

  def last_name_is_valid
    return if /^[A-Za-zÀ-ÖØ-öø-ÿ'´\-\s]+$/.match?(last_name) && last_name.length >= 2

    errors.add(:last_name, "#{last_name.inspect} is not a valid last name")
  end

  def people_count_is_valid
    errors.add(:adults, "is not a valid number") unless adults.is_a?(Integer)
    errors.add(:children, "is not a valid number") unless children.is_a?(Integer)
  end

  def people_count_is_not_zero
    return if people.to_i.positive?

    errors.add(:adults, "is not positive")
    errors.add(:children, "is not positive")
  end

  def people_count_is_not_greater_than_max_people_count
    return if people <= max_people_count

    errors.add(:adults, "is greater than the maximum allowed")
    errors.add(:children, "is greater than the maximum allowed")
  end

  def datetime_is_valid
    return if datetime.is_a?(DateTime)

    errors.add(:datetime, "is not a valid datetime")
  end

  def datetime_format_is_valid
    return if params[:datetime].to_s.blank?
    return if /\A\d{4}-\d{1,2}-\d{1,2} \d{1,2}:\d{2}\z/.match?(params[:datetime].to_s) # YYYY-M(M)-D(D) (H)H:MM
    # YYYY-MM-DDTHH:MM:SS.000Z
    return if /\A\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}.\d{3}Z?\z/.match?(params[:datetime].to_s)

    errors.add(:datetime,
               "has invalid format. Please use the format: YYYY-MM-DD HH:MM. Got: #{params[:datetime].inspect}")
  end

  def email_is_present
    return if email.present?

    errors.add(:email, "is empty or missing")
  end

  def email_is_valid
    return if email.match(URI::MailTo::EMAIL_REGEXP)

    errors.add(:email, "is not a valid email")
  end

  def no_other_reservations_for_this_email_and_datetime
    return if Reservation.visible.where(email:, datetime:).empty?

    errors.add(:email, "has another reservation for this datetime")
  end

  def datetime_is_not_in_the_past
    return if datetime.nil?
    return if datetime > Time.zone.now

    errors.add(:datetime, "is in the past")
  end

  def datetime_has_reservation_turn
    return if datetime.nil?
    return if reservation_turn

    errors.add(:datetime, "is not a valid date: there is no reservation turn for this datetime")
  end

  def datetime_is_not_too_far_in_the_future
    return if datetime.nil?
    return unless Setting[:reservation_max_days_in_advance].to_i.positive?
    return if datetime.to_date <= Time.zone.now.to_date + Setting[:reservation_max_days_in_advance].to_i.days

    errors.add(:datetime, "is too far in the future")
  end

  def datetime_is_in_valid_reservation_turn_step
    return if datetime.nil? || reservation_turn.nil?
    return if datetime.to_i % reservation_turn.step == 0

    errors.add(:datetime, "is not in a valid reservation turn step")
  end

  def lang_is_present
    return if lang.present?

    errors.add(:lang, "is blank")
  end
end
