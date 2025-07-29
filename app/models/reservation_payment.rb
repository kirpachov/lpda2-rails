# frozen_string_literal: true

# Payment associated to a reservation.
# Only reservations created when a payment is required will have one.
# If a reservation has one and it's not paid, reservation should not be shown in the dashboard as it's not completed.
class ReservationPayment < ApplicationRecord
  # ################################
  # Constants, settings, modules, et...
  # ################################

  DEFERRED_METHOD_TYPES = %w[html_nexi_authorization stripe_authorization].freeze

  # Initially "paid" was used for "authorized" too. Then we needed to distinguish when a payment was authorized but not yet paid,
  # or when a payment was paid after an authorization.
  enum status: {
    # Initial status, when payment is not yet done.
    todo: "todo",

    # When payment is deferred ("Autorizzazione") and it's not yet paid.
    authorized: "authorized",

    # When payment has been done.
    paid: "paid",

    refunded: "refunded"
  }

  enum preorder_type: {
    # Will require a payment with nexi before reservation can be created.
    # Will send user to nexi payment page. URL will be stored in hpp_url.
    # url_nexi_payment: "url_nexi_payment",

    # NEXI will give us an HTML form to be rendered in our page.
    # The form will basically be a POST request to NEXI.
    # We'll just serve the form to the user as NEXI gave it to us.
    html_nexi_payment: "html_nexi_payment",

    # Will require a preauthorization with nexi before reservation can be created.
    # Restaurant will have to confirm the payment manually, in case customer doesn't show up.
    html_nexi_authorization: "html_nexi_authorization",

    # Using Stripe as payment gateway manager.
    # Authorizing a transaction but without any actual charge
    stripe_authorization: "stripe_authorization",

    # Using stripe to manage a credit card payment.
    stripe_payment: "stripe_payment"
  }

  # ################################
  # Associations
  # ################################
  belongs_to :reservation, optional: false
  has_many :nexi_http_requests, through: :reservation
  # TODO
  # has_many :stripe_http_requests, through: :reservation

  # ################################
  # Validators
  # ################################
  validates :status, presence: true
  validates :hpp_url, presence: true
  validates :html, presence: true, if: -> { preorder_type.in?(%w[html_nexi_payment html_nexi_authorization]) }
  validates :preorder_type, presence: true
  validates :external_id, presence: true
  validates :value, presence: true, numericality: { only_integer: false, greater_than: 0 }

  before_validation :gen_hpp_url, if: -> { html.present? }
  # before_validation :gen_hpp_url # , if: -> { html.present? }

  scope :deferred, -> { where(preorder_type: DEFERRED_METHOD_TYPES) }
  scope :not_deferred, -> { where.not(preorder_type: DEFERRED_METHOD_TYPES) }

  def deferred?
    DEFERRED_METHOD_TYPES.include?(preorder_type.to_s)
  end
  alias deferred deferred?

  def gen_hpp_url
    return if reservation&.secret.blank?

    self.hpp_url ||= Rails.application.routes.url_helpers.do_payment_reservations_url(
      secret: reservation&.secret
      # host: "gigi"
    )
  end

  def clean_html
    html.gsub(/<!--.*?-->/m, "")
  end
end
