# frozen_string_literal: true

# This concern is used to track changes to models.
module TrackModelChanges
  extend ActiveSupport::Concern

  included do
    has_many :model_changes, as: :record, class_name: "Log::ModelChange", dependent: :destroy

    # TODO
    # check if, when you use again this callback, this function is called
    around_save :track_model_changes

    # TODO
    # check if, when you use again this callback, this function is called
    around_destroy :track_model_elimination
  end

  private

  def track_model_elimination
    delete_model_change! if yield
  end

  SECRET_FIELDS = (
    %w[password password_digest secret enc_otp_key token] +
      Rails.application.config.filter_parameters.map(&:to_s)
  ).uniq.freeze

  def track_model_changes
    my_changes = hide_secret_fields(changes)

    change_type = new_record? ? :create : :update

    if yield && my_changes.present?
      change_type == :create ? create_model_change!(my_changes) : update_model_change!(my_changes)
    end

    self
  end

  def hide_secret_fields(changes)
    changes.map do |k, v|
      next { k => [v[0], v[1]] } if SECRET_FIELDS.exclude?(k)

      { k => [v[0].to_s.blank? ? nil : "[FILTERED]", v[1].to_s.blank? ? nil : "[FILTERED]"] }
    end.reduce(:merge) || {}
  end

  def create_model_change!(args = {})
    SaveModelChangeJob.perform_async(model_change_params(args, "create"))
  end

  def update_model_change!(args = {})
    # Log::ModelChange.updated!(self, args)
    SaveModelChangeJob.perform_async(model_change_params(args, "update"))
  end

  def delete_model_change!(args = {})
    Log::ModelChange.deleted!(self, args)
    # SaveModelChangeJob.perform_async(model_change_params(args, 'delete'))
  end

  def model_change_params(args, change_type)
    JSON.parse({
      record_type: self.class.name,
      record_id: id,
      user_id: $current_user_id,
      # user_id: args[:user_id] || $current_user&.id,
      change_type:,
      record_changes: args.slice(*self.class.column_names),
      changed_fields: args.slice(*self.class.column_names).keys
      # version: ??
    }.to_json)
  end
end
