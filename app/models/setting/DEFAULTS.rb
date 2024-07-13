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

    email_contacts: {
      default: {
        address: "Riva del Vin San Polo 1097 San Polo, 30125 Venice Italy",
        email: "info@laportadacqua.com",
        phone: "+39 041 241 2124",
        whatsapp_number: "+39 041 241 2124",
        whatsapp_url: "https://wa.me/+390412412124",
        facebook_url: "https://www.facebook.com/Laportadacqua",
        instagram_url: "https://www.instagram.com/laportadacqua",
        tripadvisor_url: "https://www.tripadvisor.it/Restaurant_Review-g187870-d1735599-Reviews-La_Porta_D_Acqua-Venice_Veneto.html",
        homepage_url: "https://laportadacqua.com",
        google_url: "https://g.page/laportadacqua?share"
      },
      parser: :json
    },

    # How many days in advance can a reservation be made.
    reservation_max_days_in_advance: {
      default: 30
    },

    # How many hours in advance can a reservation be made.
    reservation_min_hours_in_advance: {
      default: 1
    },

    # In EUR, how much does the cover per person cost.
    cover_price: {
      default: 4
    },

    # On the landing page, we'll have an instagram integration, showing a post from the restaurant.
    instagram_landing_page_url: {
      default: "https://www.instagram.com/reel/CrbaJ6ksLUr/?igshid=YmMyMTA2M2Y="
    }
  }.with_indifferent_access.freeze
end
