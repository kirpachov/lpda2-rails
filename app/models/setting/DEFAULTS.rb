# frozen_string_literal: true

class Setting
  DEFAULTS = {
    default_language: {
      # value: :en,
      default: I18n.default_locale
    },

    available_locales: {
      default: I18n.available_locales.join(",")
    },

    # When a customer is creating a reservation, how many people can they reserve for.
    # When have more that this number of people, they need to call the restaurant.
    max_people_per_reservation: {
      default: 10
    },

    # How many days in advance can a reservation be made.
    reservation_max_days_in_advance: {
      default: 30
    },

    # How many hours in advance can a reservation be made.
    reservation_min_hours_in_advance: {
      default: 0
    },

    # How many hours in advance can a reservation be cancelled.
    reservation_min_hours_advance_cancel: {
      default: 0
    },

    # People that did pay with nexi and cancelled the reservation in time, should be refunded automatically ?
    nexi_auto_refund_cancelled_reservations: {
      default: "true"
    },

    # In EUR, how much does the cover per person cost.
    cover_price: {
      default: 4
    },

    # On the landing page, we'll have an instagram integration, showing a post from the restaurant.
    instagram_landing_page_url: {
      default: "https://www.instagram.com/reel/CrbaJ6ksLUr/?igshid=YmMyMTA2M2Y="
    },

    # Where users are redirected to after clicking the call-to-action in the feedback email
    # (e.g. a Google Form, TripAdvisor or Google Reviews page). Editable by admins.
    feedback_url: {
      default: Config.hash[:frontend_base_url]
    }
  }.with_indifferent_access.freeze
end
