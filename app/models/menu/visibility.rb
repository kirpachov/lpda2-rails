# frozen_string_literal: true

module Menu
  class Visibility < ApplicationRecord
    # ##############################
    # Constants, settings, modules, et...
    # ##############################
    include TrackModelChanges

    # ##############################
    # Validations
    # ##############################
    validates :public_visible, inclusion: { in: [true, false] }
    validates :private_visible, inclusion: { in: [true, false] }

    # ##############################
    # Instance methods
    # ##############################
    def private?
      private_visible == true
    end

    def public?
      public_visible == true
    end

    def public!
      update!(public_visible: true)
    end

    def private!
      update!(private_visible: true)
    end
  end
end
