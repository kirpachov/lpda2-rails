# frozen_string_literal: true

class Setting
  DEFAULTS = {
    default_language: {
      # value: :en,
      default: I18n.default_locale,
    },

    available_locales: {
      default: I18n.available_locales
    },

    max_people_per_reservation: {
      default: 10
    },

    email_contacts: {
      default: {
        address: 'Riva del Vin San Polo 1097 San Polo, 30125 Venice Italy',
        email: 'info@laportadacqua.com',
        phone: '+39 041 241 2124',
        whatsapp_number: '+39 041 241 2124',
        whatsapp_url: 'https://wa.me/+390412412124',
        facebook_url: 'https://www.facebook.com/Laportadacqua',
        instagram_url: 'https://www.instagram.com/laportadacqua',
        tripadvisor_url: 'https://www.tripadvisor.it/Restaurant_Review-g187870-d1735599-Reviews-La_Porta_D_Acqua-Venice_Veneto.html',
        homepage_url: 'https://laportadacqua.com',
        google_url: 'https://g.page/laportadacqua?share',
      },
      parser: :json
    }
  }.with_indifferent_access.freeze
end
