# RuboCop Inspection Report

481 files inspected, 4195 offenses detected:

### Gemfile - (1 offense)
  * **Line # 1 - convention:** Style/FrozenStringLiteralComment: Missing frozen string literal comment.

    ```rb
    source "https://rubygems.org"
    ```

### Guardfile - (2 offenses)
  * **Line # 1 - convention:** Style/FrozenStringLiteralComment: Missing frozen string literal comment.

    ```rb
    # A sample Guardfile
    ```

  * **Line # 43 - convention:** Layout/LineLength: Line is too long. [180/120]

    ```rb
      # watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] }
    ```

### Rakefile - (1 offense)
  * **Line # 1 - convention:** Style/FrozenStringLiteralComment: Missing frozen string literal comment.

    ```rb
    # Add your own tasks in files placed in lib/tasks ending in .rake,
    ```

### app/channels/application_cable/channel.rb - (1 offense)
  * **Line # 1 - convention:** Style/FrozenStringLiteralComment: Missing frozen string literal comment.

    ```rb
    module ApplicationCable
    ```

### app/channels/application_cable/connection.rb - (1 offense)
  * **Line # 1 - convention:** Style/FrozenStringLiteralComment: Missing frozen string literal comment.

    ```rb
    module ApplicationCable
    ```

### app/controllers/application_controller.rb - (6 offenses)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class ApplicationController`.

    ```rb
    class ApplicationController < ActionController::API
    ```

  * **Line # 59 - convention:** Style/SafeNavigation: Use safe navigation (`&.`) instead of checking if an object exists before calling the method.

    ```rb
          record.image_to_record.destroy! if record.image_to_record
    ```

  * **Line # 93 - convention:** Metrics/AbcSize: Assignment Branch Condition size for json_metadata is too high. [<1, 21, 11> 23.73/17]

    ```rb
      def json_metadata(resources) ...
    ```

  * **Line # 93 - convention:** Metrics/CyclomaticComplexity: Cyclomatic complexity for json_metadata is too high. [9/7]

    ```rb
      def json_metadata(resources) ...
    ```

  * **Line # 93 - convention:** Metrics/MethodLength: Method has too many lines. [17/10]

    ```rb
      def json_metadata(resources) ...
    ```

  * **Line # 93 - convention:** Metrics/PerceivedComplexity: Perceived complexity for json_metadata is too high. [9/8]

    ```rb
      def json_metadata(resources) ...
    ```

### app/controllers/v1/admin/menu/allergens_controller.rb - (4 offenses)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class V1::Admin::Menu::AllergensController`.

    ```rb
      class AllergensController < ApplicationController
    ```

  * **Line # 28 - convention:** Metrics/AbcSize: Assignment Branch Condition size for create is too high. [<2, 26, 6> 26.76/17]

    ```rb
        def create ...
    ```

  * **Line # 40 - convention:** Metrics/AbcSize: Assignment Branch Condition size for update is too high. [<0, 22, 7> 23.09/17]

    ```rb
        def update ...
    ```

  * **Line # 40 - convention:** Metrics/CyclomaticComplexity: Cyclomatic complexity for update is too high. [8/7]

    ```rb
        def update ...
    ```

### app/controllers/v1/admin/menu/categories_controller.rb - (16 offenses)
  * **Line # 5 - convention:** Metrics/ClassLength: Class has too many lines. [176/100]

    ```rb
        class CategoriesController < ApplicationController ...
    ```

  * **Line # 5 - convention:** Style/Documentation: Missing top-level documentation comment for `class V1::Admin::Menu::CategoriesController`.

    ```rb
        class CategoriesController < ApplicationController
    ```

  * **Line # 40 - convention:** Metrics/AbcSize: Assignment Branch Condition size for create is too high. [<1, 20, 5> 20.64/17]

    ```rb
          def create ...
    ```

  * **Line # 50 - convention:** Metrics/AbcSize: Assignment Branch Condition size for update is too high. [<0, 18, 5> 18.68/17]

    ```rb
          def update ...
    ```

  * **Line # 81 - convention:** Metrics/AbcSize: Assignment Branch Condition size for add_dish is too high. [<3, 20, 3> 20.45/17]

    ```rb
          def add_dish ...
    ```

  * **Line # 81 - convention:** Metrics/MethodLength: Method has too many lines. [12/10]

    ```rb
          def add_dish ...
    ```

  * **Line # 97 - convention:** Metrics/AbcSize: Assignment Branch Condition size for move is too high. [<0, 18, 7> 19.31/17]

    ```rb
          def move ...
    ```

  * **Line # 119 - convention:** Metrics/AbcSize: Assignment Branch Condition size for copy is too high. [<3, 22, 2> 22.29/17]

    ```rb
          def copy ...
    ```

  * **Line # 119 - convention:** Metrics/MethodLength: Method has too many lines. [14/10]

    ```rb
          def copy ...
    ```

  * **Line # 128 - convention:** Performance/RedundantMerge: Use `copy_params[:parent_id] = params[:parent_id]` instead of `copy_params.merge!(parent_id: params[:parent_id])`.

    ```rb
            copy_params.merge!(parent_id: params[:parent_id]) if params.key?(:parent_id)
    ```

  * **Line # 149 - convention:** Metrics/MethodLength: Method has too many lines. [12/10]

    ```rb
          def add_category ...
    ```

  * **Line # 170 - warning:** Lint/BooleanSymbol: Symbol with a boolean name - you probably meant to use `true`.

    ```rb
            publishing_now = [true, 1, "true", "1", :true].include?(params[:public_visible])
    ```

  * **Line # 184 - warning:** Lint/BooleanSymbol: Symbol with a boolean name - you probably meant to use `true`.

    ```rb
            [true, 1, "true", "1", :true].include? params[:force]
    ```

  * **Line # 199 - convention:** Performance/RedundantMerge: Use `update_params[:visibility_id] = nil` instead of `update_params.merge!(visibility_id: nil)`.

    ```rb
              update_params.merge!(visibility_id: nil)
    ```

  * **Line # 223 - convention:** Metrics/AbcSize: Assignment Branch Condition size for single_item_full_json is too high. [<0, 19, 2> 19.1/17]

    ```rb
          def single_item_full_json(item) ...
    ```

  * **Line # 223 - convention:** Metrics/MethodLength: Method has too many lines. [12/10]

    ```rb
          def single_item_full_json(item) ...
    ```

### app/controllers/v1/admin/menu/dishes_controller.rb - (22 offenses)
  * **Line # 5 - convention:** Metrics/ClassLength: Class has too many lines. [250/100]

    ```rb
        class DishesController < ApplicationController ...
    ```

  * **Line # 5 - convention:** Style/Documentation: Missing top-level documentation comment for `class V1::Admin::Menu::DishesController`.

    ```rb
        class DishesController < ApplicationController
    ```

  * **Line # 39 - convention:** Metrics/AbcSize: Assignment Branch Condition size for create is too high. [<1, 34, 7> 34.73/17]

    ```rb
          def create ...
    ```

  * **Line # 39 - convention:** Metrics/CyclomaticComplexity: Cyclomatic complexity for create is too high. [8/7]

    ```rb
          def create ...
    ```

  * **Line # 39 - convention:** Metrics/MethodLength: Method has too many lines. [11/10]

    ```rb
          def create ...
    ```

  * **Line # 47 - convention:** Layout/LineLength: Line is too long. [127/120]

    ```rb
                                                 menu_category_id: params[:category_id].present? ? params[:category_id].to_i : nil)
    ```

  * **Line # 56 - convention:** Metrics/AbcSize: Assignment Branch Condition size for update is too high. [<1, 28, 6> 28.65/17]

    ```rb
          def update ...
    ```

  * **Line # 93 - convention:** Layout/LineLength: Line is too long. [131/120]

    ```rb
                                           menu_category_id: params[:category_id].blank? ? nil : params[:category_id].to_i).destroy_all
    ```

  * **Line # 127 - convention:** Metrics/AbcSize: Assignment Branch Condition size for copy is too high. [<2, 19, 1> 19.13/17]

    ```rb
          def copy ...
    ```

  * **Line # 127 - convention:** Metrics/MethodLength: Method has too many lines. [14/10]

    ```rb
          def copy ...
    ```

  * **Line # 146 - convention:** Metrics/AbcSize: Assignment Branch Condition size for add_ingredient is too high. [<3, 20, 3> 20.45/17]

    ```rb
          def add_ingredient ...
    ```

  * **Line # 146 - convention:** Metrics/MethodLength: Method has too many lines. [12/10]

    ```rb
          def add_ingredient ...
    ```

  * **Line # 172 - convention:** Metrics/AbcSize: Assignment Branch Condition size for move_ingredient is too high. [<2, 18, 2> 18.22/17]

    ```rb
          def move_ingredient ...
    ```

  * **Line # 188 - convention:** Metrics/AbcSize: Assignment Branch Condition size for add_tag is too high. [<3, 20, 3> 20.45/17]

    ```rb
          def add_tag ...
    ```

  * **Line # 205 - warning:** Lint/UselessAssignment: Useless assignment to variable - `e`.

    ```rb
          rescue ActiveRecord::RecordNotFound => e
    ```

  * **Line # 209 - convention:** Metrics/AbcSize: Assignment Branch Condition size for move_tag is too high. [<2, 18, 2> 18.22/17]

    ```rb
          def move_tag ...
    ```

  * **Line # 225 - convention:** Metrics/AbcSize: Assignment Branch Condition size for add_allergen is too high. [<3, 20, 3> 20.45/17]

    ```rb
          def add_allergen ...
    ```

  * **Line # 225 - convention:** Metrics/MethodLength: Method has too many lines. [12/10]

    ```rb
          def add_allergen ...
    ```

  * **Line # 244 - warning:** Lint/UselessAssignment: Useless assignment to variable - `e`.

    ```rb
          rescue ActiveRecord::RecordNotFound => e
    ```

  * **Line # 250 - convention:** Metrics/AbcSize: Assignment Branch Condition size for move_allergen is too high. [<2, 18, 2> 18.22/17]

    ```rb
          def move_allergen ...
    ```

  * **Line # 266 - convention:** Metrics/AbcSize: Assignment Branch Condition size for add_image is too high. [<3, 20, 3> 20.45/17]

    ```rb
          def add_image ...
    ```

  * **Line # 283 - warning:** Lint/UselessAssignment: Useless assignment to variable - `e`.

    ```rb
          rescue ActiveRecord::RecordNotFound => e
    ```

### app/controllers/v1/admin/menu/ingredients_controller.rb - (3 offenses)
  * **Line # 5 - convention:** Style/Documentation: Missing top-level documentation comment for `class V1::Admin::Menu::IngredientsController`.

    ```rb
        class IngredientsController < ApplicationController
    ```

  * **Line # 29 - convention:** Metrics/AbcSize: Assignment Branch Condition size for create is too high. [<2, 27, 5> 27.53/17]

    ```rb
          def create ...
    ```

  * **Line # 43 - convention:** Metrics/AbcSize: Assignment Branch Condition size for update is too high. [<0, 25, 6> 25.71/17]

    ```rb
          def update ...
    ```

### app/controllers/v1/admin/menu/tags_controller.rb - (4 offenses)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class V1::Admin::Menu::TagsController`.

    ```rb
      class TagsController < ApplicationController
    ```

  * **Line # 28 - convention:** Metrics/AbcSize: Assignment Branch Condition size for create is too high. [<2, 26, 6> 26.76/17]

    ```rb
        def create ...
    ```

  * **Line # 40 - convention:** Metrics/AbcSize: Assignment Branch Condition size for update is too high. [<0, 22, 7> 23.09/17]

    ```rb
        def update ...
    ```

  * **Line # 40 - convention:** Metrics/CyclomaticComplexity: Cyclomatic complexity for update is too high. [8/7]

    ```rb
        def update ...
    ```

### app/controllers/v1/admin/preferences_controller.rb - (3 offenses)
  * **Line # 5 - convention:** Style/Documentation: Missing top-level documentation comment for `class V1::Admin::PreferencesController`.

    ```rb
        class PreferencesController < ApplicationController
    ```

  * **Line # 6 - convention:** Rails/LexicallyScopedActionFilter: `value` is not explicitly defined on the class.

    ```rb
          before_action :validate_key_exists, only: %i[value show update]
    ```

  * **Line # 23 - convention:** Layout/LineLength: Line is too long. [153/120]

    ```rb
            # render json: current_user.preference(params[:key]).as_json(except: %i[id created_at]).merge(value: current_user.preference_value(params[:key]))
    ```

### app/controllers/v1/admin/preorder_reservation_groups_controller.rb - (3 offenses)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class V1::Admin::PreorderReservationGroupsController`.

    ```rb
      class PreorderReservationGroupsController < ApplicationController
    ```

  * **Line # 8 - convention:** Metrics/AbcSize: Assignment Branch Condition size for index is too high. [<4, 18, 2> 18.55/17]

    ```rb
        def index ...
    ```

  * **Line # 72 - convention:** Layout/LineLength: Line is too long. [123/120]

    ```rb
                "Invalid params. PreorderReservationGroup or ActiveRecord::Relation expected, but #{item_or_items.class} given"
    ```

### app/controllers/v1/admin/public_messages_controller.rb - (2 offenses)
  * **Line # 8 - convention:** Metrics/AbcSize: Assignment Branch Condition size for index is too high. [<4, 19, 2> 19.52/17]

    ```rb
        def index ...
    ```

  * **Line # 11 - convention:** Rails/WhereEquals: Use `where(key: params[:key])` instead of manually constructing SQL.

    ```rb
          items = items.where("key = ?", params[:key]) if params[:key].present?
    ```

### app/controllers/v1/admin/reservation_tags_controller.rb - (1 offense)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class V1::Admin::ReservationTagsController`.

    ```rb
      class ReservationTagsController < ApplicationController
    ```

### app/controllers/v1/admin/reservation_turn_messages_controller.rb - (3 offenses)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class V1::Admin::ReservationTurnMessagesController`.

    ```rb
      class ReservationTurnMessagesController < ApplicationController
    ```

  * **Line # 26 - convention:** Metrics/AbcSize: Assignment Branch Condition size for create is too high. [<2, 22, 5> 22.65/17]

    ```rb
        def create ...
    ```

  * **Line # 38 - convention:** Metrics/AbcSize: Assignment Branch Condition size for update is too high. [<1, 21, 4> 21.4/17]

    ```rb
        def update ...
    ```

### app/controllers/v1/admin/reservation_turns_controller.rb - (1 offense)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class V1::Admin::ReservationTurnsController`.

    ```rb
      class ReservationTurnsController < ApplicationController
    ```

### app/controllers/v1/admin/reservations_controller.rb - (6 offenses)
  * **Line # 4 - convention:** Metrics/ClassLength: Class has too many lines. [149/100]

    ```rb
      class ReservationsController < ApplicationController ...
    ```

  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class V1::Admin::ReservationsController`.

    ```rb
      class ReservationsController < ApplicationController
    ```

  * **Line # 6 - convention:** Layout/LineLength: Line is too long. [133/120]

    ```rb
                      only: %i[show refund_payment refresh_payment_status deliver_confirmation_email update destroy update_status add_tag
    ```

  * **Line # 135 - convention:** Metrics/AbcSize: Assignment Branch Condition size for export is too high. [<2, 20, 2> 20.2/17]

    ```rb
        def export ...
    ```

  * **Line # 135 - convention:** Metrics/MethodLength: Method has too many lines. [12/10]

    ```rb
        def export ...
    ```

  * **Line # 171 - convention:** Metrics/MethodLength: Method has too many lines. [14/10]

    ```rb
        def single_item_full_json(item) ...
    ```

### app/controllers/v1/admin/settings_controller.rb - (1 offense)
  * **Line # 5 - convention:** Style/Documentation: Missing top-level documentation comment for `class V1::Admin::SettingsController`.

    ```rb
        class SettingsController < ApplicationController
    ```

### app/controllers/v1/auth_controller.rb - (14 offenses)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class V1::AuthController`.

    ```rb
      class AuthController < ApplicationController
    ```

  * **Line # 9 - convention:** Metrics/AbcSize: Assignment Branch Condition size for login is too high. [<1, 28, 3> 28.18/17]

    ```rb
        def login ...
    ```

  * **Line # 33 - convention:** Metrics/AbcSize: Assignment Branch Condition size for root is too high. [<0, 22, 3> 22.2/17]

    ```rb
        def root ...
    ```

  * **Line # 33 - convention:** Metrics/MethodLength: Method has too many lines. [16/10]

    ```rb
        def root ...
    ```

  * **Line # 57 - convention:** Metrics/AbcSize: Assignment Branch Condition size for refresh_token is too high. [<2, 25, 1> 25.1/17]

    ```rb
        def refresh_token ...
    ```

  * **Line # 57 - convention:** Metrics/MethodLength: Method has too many lines. [14/10]

    ```rb
        def refresh_token ...
    ```

  * **Line # 94 - convention:** Layout/LineLength: Line is too long. [122/120]

    ```rb
          # If you're logged in and you require reset password, something is wrong, so imma logout you to avoid complications.
    ```

  * **Line # 99 - convention:** Style/SafeNavigation: Use safe navigation (`&.`) instead of checking if an object exists before calling the method.

    ```rb
          user.send_reset_password_email if user
    ```

  * **Line # 106 - convention:** Layout/LineLength: Line is too long. [122/120]

    ```rb
        # - code / token / secret: the secret of the ResetPasswordSecret. Present in the email sent by require_reset_password.
    ```

  * **Line # 109 - convention:** Layout/LineLength: Line is too long. [124/120]

    ```rb
        # TODO: somebody may bruteforce this endpoint to set a password for some user. May protect with ip / cookies / delay (?)
    ```

  * **Line # 110 - convention:** Metrics/AbcSize: Assignment Branch Condition size for reset_password is too high. [<2, 35, 8> 35.96/17]

    ```rb
        def reset_password ...
    ```

  * **Line # 110 - convention:** Metrics/CyclomaticComplexity: Cyclomatic complexity for reset_password is too high. [9/7]

    ```rb
        def reset_password ...
    ```

  * **Line # 110 - convention:** Metrics/MethodLength: Method has too many lines. [13/10]

    ```rb
        def reset_password ...
    ```

  * **Line # 110 - convention:** Metrics/PerceivedComplexity: Perceived complexity for reset_password is too high. [9/8]

    ```rb
        def reset_password ...
    ```

### app/controllers/v1/images_controller.rb - (10 offenses)
  * **Line # 4 - convention:** Metrics/ClassLength: Class has too many lines. [125/100]

    ```rb
      class ImagesController < ApplicationController ...
    ```

  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class V1::ImagesController`.

    ```rb
      class ImagesController < ApplicationController
    ```

  * **Line # 45 - convention:** Metrics/AbcSize: Assignment Branch Condition size for update_record is too high. [<2, 31, 5> 31.46/17]

    ```rb
        def update_record ...
    ```

  * **Line # 45 - convention:** Metrics/MethodLength: Method has too many lines. [16/10]

    ```rb
        def update_record ...
    ```

  * **Line # 118 - convention:** Rails/Blank: Use `if image.attached_image.blank?` instead of `unless image.attached_image.present?`.

    ```rb
          return render_error(status: 500, message: "attached_image is missing") unless image.attached_image.present?
    ```

  * **Line # 128 - convention:** Style/RedundantInterpolation: Prefer `to_s` over string interpolation.

    ```rb
          render_error(status: 404, message: "#{I18n.t("record_not_found", model: Image, id: params[:id].inspect)}")
    ```

  * **Line # 135 - convention:** Style/RedundantInterpolation: Prefer `to_s` over string interpolation.

    ```rb
                       message: "#{I18n.t("record_not_found_by", model: Image, attribute: :key, ...
    ```

  * **Line # 141 - convention:** Rails/TimeZone: Do not use `Time.now` without zone. Use one of `Time.zone.now`, `Time.current`, `Time.now.in_time_zone`, `Time.now.utc`, `Time.now.getlocal`, `Time.now.xmlschema`, `Time.now.iso8601`, `Time.now.jisx0301`, `Time.now.rfc3339`, `Time.now.httpdate`, `Time.now.to_i`, `Time.now.to_f` instead.

    ```rb
          @pixel.events.create!(event_data: { ip: request.remote_ip }, event_time: Time.now)
    ```

  * **Line # 145 - convention:** Style/RedundantInterpolation: Prefer `to_s` over string interpolation.

    ```rb
                       message: "#{I18n.t("record_not_found", model: Log::ImagePixel, ...
    ```

  * **Line # 154 - convention:** Layout/LineLength: Line is too long. [164/120]

    ```rb
                                                              id: params[:id].inspect)}#{params[:variant].present? ? " with variant #{params[:variant].inspect}" : ""}")
    ```

### app/controllers/v1/menu/categories_controller.rb - (1 offense)
  * **Line # 33 - convention:** Layout/LineLength: Line is too long. [147/120]

    ```rb
          @item = Menu::Category.visible.public_visible.find_by(id: params[:id]) || Menu::Category.visible.private_visible.find_by(secret: params[:id])
    ```

### app/controllers/v1/menu/dishes_controller.rb - (2 offenses)
  * **Line # 32 - convention:** Metrics/AbcSize: Assignment Branch Condition size for full_json is too high. [<0, 25, 2> 25.08/17]

    ```rb
        def full_json(item_or_items) ...
    ```

  * **Line # 32 - convention:** Metrics/MethodLength: Method has too many lines. [11/10]

    ```rb
        def full_json(item_or_items) ...
    ```

### app/controllers/v1/nexi_controller.rb - (1 offense)
  * **Line # 4 - convention:** Layout/LineLength: Line is too long. [142/120]

    ```rb
      # After the user is sent to the NEXI payment page, NEXI will send a POST request to this endpoint to let us know the outcome of the payment.
    ```

### app/controllers/v1/profile_controller.rb - (1 offense)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class V1::ProfileController`.

    ```rb
      class ProfileController < ApplicationController
    ```

### app/controllers/v1/public_data_controller.rb - (3 offenses)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class V1::PublicDataController`.

    ```rb
      class PublicDataController < ApplicationController
    ```

  * **Line # 7 - convention:** Metrics/AbcSize: Assignment Branch Condition size for index is too high. [<1, 18, 0> 18.03/17]

    ```rb
        def index ...
    ```

  * **Line # 7 - convention:** Metrics/MethodLength: Method has too many lines. [17/10]

    ```rb
        def index ...
    ```

### app/controllers/v1/reservations_controller.rb - (9 offenses)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class V1::ReservationsController`.

    ```rb
      class ReservationsController < ApplicationController
    ```

  * **Line # 17 - convention:** Metrics/AbcSize: Assignment Branch Condition size for do_payment is too high. [<0, 20, 4> 20.4/17]

    ```rb
        def do_payment ...
    ```

  * **Line # 33 - convention:** Metrics/AbcSize: Assignment Branch Condition size for create is too high. [<3, 22, 1> 22.23/17]

    ```rb
        def create ...
    ```

  * **Line # 33 - convention:** Metrics/MethodLength: Method has too many lines. [13/10]

    ```rb
        def create ...
    ```

  * **Line # 70 - convention:** Metrics/AbcSize: Assignment Branch Condition size for valid_dates is too high. [<11, 62, 12> 64.1/17]

    ```rb
        def valid_dates ...
    ```

  * **Line # 70 - convention:** Metrics/CyclomaticComplexity: Cyclomatic complexity for valid_dates is too high. [10/7]

    ```rb
        def valid_dates ...
    ```

  * **Line # 70 - convention:** Metrics/MethodLength: Method has too many lines. [18/10]

    ```rb
        def valid_dates ...
    ```

  * **Line # 70 - convention:** Metrics/PerceivedComplexity: Perceived complexity for valid_dates is too high. [10/8]

    ```rb
        def valid_dates ...
    ```

  * **Line # 77 - convention:** Layout/LineLength: Line is too long. [190/120]

    ```rb
          if Setting.where(key: :reservation_max_days_in_advance).first.present? && (to_date > Time.zone.now.to_date + Setting.where(key: :reservation_max_days_in_advance).first.value.to_i.days)
    ```

### app/controllers/v2/reservations_controller.rb - (3 offenses)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class V2::ReservationsController`.

    ```rb
      class ReservationsController < ApplicationController
    ```

  * **Line # 8 - convention:** Metrics/AbcSize: Assignment Branch Condition size for valid_times is too high. [<2, 19, 3> 19.34/17]

    ```rb
        def valid_times ...
    ```

  * **Line # 8 - convention:** Metrics/MethodLength: Method has too many lines. [16/10]

    ```rb
        def valid_times ...
    ```

### app/interactions/assign_translation.rb - (2 offenses)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class AssignTranslation`.

    ```rb
    class AssignTranslation < ActiveInteraction::Base
    ```

  * **Line # 6 - convention:** Performance/UnfreezeString: Use unary plus to get an unfrozen string literal.

    ```rb
      interface :value, methods: {}.methods & String.new.methods & ActionController::Parameters.new.methods,
    ```

### app/interactions/auth/authenticate_user.rb - (1 offense)
  * **Line # 35 - convention:** Metrics/MethodLength: Method has too many lines. [17/10]

    ```rb
        def find_user ...
    ```

### app/interactions/auth/authorize_api_request.rb - (3 offenses)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class Auth::AuthorizeApiRequest`.

    ```rb
      class AuthorizeApiRequest < ActiveInteraction::Base
    ```

  * **Line # 17 - convention:** Metrics/MethodLength: Method has too many lines. [12/10]

    ```rb
        def authenticate_and_get_user ...
    ```

  * **Line # 46 - convention:** Style/RedundantArgument: Argument " " is redundant because it is implied by default.

    ```rb
          return headers["Authorization"].split(" ").last if headers["Authorization"].present?
    ```

### app/interactions/auth/json_web_token.rb - (1 offense)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class Auth::JsonWebToken`.

    ```rb
      class JsonWebToken
    ```

### app/interactions/auth/refresh_jwt_token.rb - (5 offenses)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class Auth::RefreshJwtToken`.

    ```rb
      class RefreshJwtToken < ActiveInteraction::Base
    ```

  * **Line # 20 - convention:** Metrics/AbcSize: Assignment Branch Condition size for validate_and_refresh_token is too high. [<4, 36, 7> 36.89/17]

    ```rb
        def validate_and_refresh_token ...
    ```

  * **Line # 20 - convention:** Metrics/MethodLength: Method has too many lines. [15/10]

    ```rb
        def validate_and_refresh_token ...
    ```

  * **Line # 25 - convention:** Rails/TransactionExitStatement: Exit statement `return` is not allowed. Use `raise` (rollback) or `next` (commit).

    ```rb
            return refresh_token_not_found! if refresh_token.nil?
    ```

  * **Line # 27 - convention:** Rails/TransactionExitStatement: Exit statement `return` is not allowed. Use `raise` (rollback) or `next` (commit).

    ```rb
            return user_not_found! if user.nil? || user.deleted?
    ```

### app/interactions/copy_image.rb - (2 offenses)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class CopyImage`.

    ```rb
    class CopyImage < ActiveInteraction::Base
    ```

  * **Line # 9 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<1, 18, 2> 18.14/17]

    ```rb
      def execute ...
    ```

### app/interactions/create_image.rb - (4 offenses)
  * **Line # 19 - convention:** Metrics/AbcSize: Assignment Branch Condition size for assign_to_record is too high. [<1, 20, 4> 20.42/17]

    ```rb
      def assign_to_record ...
    ```

  * **Line # 19 - convention:** Metrics/MethodLength: Method has too many lines. [11/10]

    ```rb
      def assign_to_record ...
    ```

  * **Line # 60 - convention:** Style/PreferredHashMethods: Use `Hash#key?` instead of `Hash#has_key?`.

    ```rb
          next unless params.has_key?(key)
    ```

  * **Line # 66 - convention:** Layout/LineLength: Line is too long. [128/120]

    ```rb
                   "Missing valid image param. Looking for :image, :file or :image_file of type ActionDispatch::Http::UploadedFile")
    ```

### app/interactions/create_missing_images.rb - (1 offense)
  * **Line # 7 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<3, 23, 4> 23.54/17]

    ```rb
      def execute ...
    ```

### app/interactions/create_preorder_dates.rb - (4 offenses)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class CreatePreorderDates`.

    ```rb
    class CreatePreorderDates < ActiveInteraction::Base
    ```

  * **Line # 18 - convention:** Performance/RedundantEqualityComparisonBlock: Use `all?(Hash)` instead of block.

    ```rb
        unless params.present? && params[:dates].is_a?(Array) && params[:dates].all? { |i| i.is_a?(Hash) }
    ```

  * **Line # 23 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<2, 23, 4> 23.43/17]

    ```rb
      def execute ...
    ```

  * **Line # 23 - convention:** Metrics/MethodLength: Method has too many lines. [12/10]

    ```rb
      def execute ...
    ```

### app/interactions/create_preorder_group.rb - (4 offenses)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class CreatePreorderGroup`.

    ```rb
    class CreatePreorderGroup < ActiveInteraction::Base
    ```

  * **Line # 22 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<0, 18, 5> 18.68/17]

    ```rb
      def execute ...
    ```

  * **Line # 37 - convention:** Metrics/AbcSize: Assignment Branch Condition size for create_group is too high. [<1, 23, 2> 23.11/17]

    ```rb
      def create_group ...
    ```

  * **Line # 37 - convention:** Metrics/MethodLength: Method has too many lines. [16/10]

    ```rb
      def create_group ...
    ```

### app/interactions/dev/cat_image.rb - (2 offenses)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class Dev::CatImage`.

    ```rb
      class CatImage < ActiveInteraction::Base
    ```

  * **Line # 19 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<10, 19, 2> 21.56/17]

    ```rb
        def execute ...
    ```

### app/interactions/dev/import_images.rb - (3 offenses)
  * **Line # 12 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<3, 22, 3> 22.41/17]

    ```rb
        def execute ...
    ```

  * **Line # 28 - convention:** Metrics/AbcSize: Assignment Branch Condition size for all is too high. [<3, 21, 5> 21.79/17]

    ```rb
        def all ...
    ```

  * **Line # 32 - convention:** Style/MultilineBlockChain: Avoid multi-line chains of blocks.

    ```rb
                   end.filter do |file_data|
    ```

### app/interactions/dev/menu/generate_fake_menu.rb - (12 offenses)
  * **Line # 18 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<9, 81, 4> 81.6/17]

    ```rb
        def execute ...
    ```

  * **Line # 18 - convention:** Metrics/MethodLength: Method has too many lines. [37/10]

    ```rb
        def execute ...
    ```

  * **Line # 39 - convention:** Rails/Output: Do not write to stdout. Use Rails's logger if you want to log.

    ```rb
          puts "Fixed price menu: ##{fixed_price_menu.id} #{fixed_price_menu.name} #{fixed_price_menu.price}€"
    ```

  * **Line # 44 - convention:** Rails/Output: Do not write to stdout. Use Rails's logger if you want to log.

    ```rb
            puts "Category ##{category.id} #{category.name} has #{category.children.count} children (is both parent and children)"
    ```

  * **Line # 44 - convention:** Layout/LineLength: Line is too long. [126/120]

    ```rb
            puts "Category ##{category.id} #{category.name} has #{category.children.count} children (is both parent and children)"
    ```

  * **Line # 53 - convention:** Rails/Output: Do not write to stdout. Use Rails's logger if you want to log.

    ```rb
          puts "Private menu: ##{private_menu.id} #{private_menu.name}"
    ```

  * **Line # 61 - convention:** Layout/LineLength: Line is too long. [134/120]

    ```rb
                                               public_to: nil, private_from: nil, private_to: nil, daily_from: "11:00", daily_to: "14:00")
    ```

  * **Line # 62 - convention:** Rails/Output: Do not write to stdout. Use Rails's logger if you want to log.

    ```rb
          puts "Public daily menu, only for lunch time: ##{public_daily_menu.id} #{public_daily_menu.name}"
    ```

  * **Line # 66 - convention:** Rails/Output: Do not write to stdout. Use Rails's logger if you want to log.

    ```rb
            puts "Dish ##{dish.id} #{dish.name} has #{dish.suggestions.count} suggestions"
    ```

  * **Line # 80 - convention:** Metrics/MethodLength: Method has too many lines. [11/10]

    ```rb
        def add_children_to(menu, count:, dishes_per_category:) ...
    ```

  * **Line # 95 - convention:** Metrics/AbcSize: Assignment Branch Condition size for add_dishes_to is too high. [<6, 28, 1> 28.65/17]

    ```rb
        def add_dishes_to(category:, count:) ...
    ```

  * **Line # 95 - convention:** Metrics/MethodLength: Method has too many lines. [15/10]

    ```rb
        def add_dishes_to(category:, count:) ...
    ```

### app/interactions/dev/menu/import_allergens.rb - (3 offenses)
  * **Line # 6 - convention:** Style/Documentation: Missing top-level documentation comment for `class Dev::Menu::ImportAllergens`.

    ```rb
      class ImportAllergens < ActiveInteraction::Base
    ```

  * **Line # 11 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<5, 17, 1> 17.75/17]

    ```rb
        def execute ...
    ```

  * **Line # 11 - convention:** Metrics/MethodLength: Method has too many lines. [11/10]

    ```rb
        def execute ...
    ```

### app/interactions/dev/menu/import_categories.rb - (7 offenses)
  * **Line # 6 - convention:** Style/Documentation: Missing top-level documentation comment for `class Dev::Menu::ImportCategories`.

    ```rb
      class ImportCategories < ActiveInteraction::Base
    ```

  * **Line # 11 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<10, 30, 4> 31.87/17]

    ```rb
        def execute ...
    ```

  * **Line # 11 - convention:** Metrics/MethodLength: Method has too many lines. [19/10]

    ```rb
        def execute ...
    ```

  * **Line # 29 - convention:** Rails/NegateInclude: Use `.exclude?` and remove the negation part.

    ```rb
            if row["imageId"].present? && (image = Image.find_by(member_id: row["imageId"])) && !category.images.include?(image)
    ```

  * **Line # 29 - convention:** Layout/LineLength: Line is too long. [124/120]

    ```rb
            if row["imageId"].present? && (image = Image.find_by(member_id: row["imageId"])) && !category.images.include?(image)
    ```

  * **Line # 42 - convention:** Layout/LineLength: Line is too long. [124/120]

    ```rb
                                                                                         liberal_parsing: true).to_a.map(&:to_h)
    ```

  * **Line # 44 - convention:** Style/MapToHash: Pass a block to `to_h` instead of calling `map.to_h`.

    ```rb
          @categories = data.map { |j| [j["categoryId"], j["menuId"]] }.to_h
    ```

### app/interactions/dev/menu/import_dishes.rb - (19 offenses)
  * **Line # 6 - convention:** Style/Documentation: Missing top-level documentation comment for `class Dev::Menu::ImportDishes`.

    ```rb
      class ImportDishes < ActiveInteraction::Base
    ```

  * **Line # 11 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<13, 66, 13> 68.51/17]

    ```rb
        def execute ...
    ```

  * **Line # 11 - convention:** Metrics/CyclomaticComplexity: Cyclomatic complexity for execute is too high. [13/7]

    ```rb
        def execute ...
    ```

  * **Line # 11 - convention:** Metrics/MethodLength: Method has too many lines. [30/10]

    ```rb
        def execute ...
    ```

  * **Line # 11 - convention:** Metrics/PerceivedComplexity: Perceived complexity for execute is too high. [13/8]

    ```rb
        def execute ...
    ```

  * **Line # 12 - convention:** Metrics/BlockLength: Block has too many lines. [28/25]

    ```rb
          CSV.foreach(file, headers: true, col_sep: ";", liberal_parsing: true) do |row| ...
    ```

  * **Line # 29 - convention:** Rails/NegateInclude: Use `.exclude?` and remove the negation part.

    ```rb
            if (category = Menu::Category.find_by(member_id: "lpda-category-#{menu_ids[row["id"]]}")) && !dish.categories.include?(category)
    ```

  * **Line # 29 - convention:** Layout/LineLength: Line is too long. [136/120]

    ```rb
            if (category = Menu::Category.find_by(member_id: "lpda-category-#{menu_ids[row["id"]]}")) && !dish.categories.include?(category)
    ```

  * **Line # 33 - convention:** Rails/NegateInclude: Use `.exclude?` and remove the negation part.

    ```rb
            if row["imageId"].present? && (image = Image.find_by(member_id: row["imageId"])) && !dish.images.include?(image)
    ```

  * **Line # 60 - convention:** Layout/LineLength: Line is too long. [124/120]

    ```rb
                                                                                         liberal_parsing: true).to_a.map(&:to_h)
    ```

  * **Line # 62 - convention:** Style/MapToHash: Pass a block to `to_h` instead of calling `map.to_h`.

    ```rb
          @menu_ids = data.map { |j| [j["foodItemId"], j["categoryId"]] }.to_h
    ```

  * **Line # 72 - convention:** Style/HashTransformValues: Prefer `transform_values` over `map {...}.to_h`.

    ```rb
          @tag_ids = data.group_by { |j| j["foodItemId"] }.map { |k, v| [k, v.map { |j| j["tagId"] }] }.to_h
    ```

  * **Line # 72 - convention:** Style/MapToHash: Pass a block to `to_h` instead of calling `map.to_h`.

    ```rb
          @tag_ids = data.group_by { |j| j["foodItemId"] }.map { |k, v| [k, v.map { |j| j["tagId"] }] }.to_h
    ```

  * **Line # 79 - convention:** Layout/LineLength: Line is too long. [125/120]

    ```rb
                                                                                          liberal_parsing: true).to_a.map(&:to_h)
    ```

  * **Line # 81 - convention:** Style/HashTransformValues: Prefer `transform_values` over `map {...}.to_h`.

    ```rb
          @allergen_ids = data.group_by { |j| j["foodItemId"] }.map { |k, v| [k, v.map { |j| j["allergenId"] }] }.to_h
    ```

  * **Line # 81 - convention:** Style/MapToHash: Pass a block to `to_h` instead of calling `map.to_h`.

    ```rb
          @allergen_ids = data.group_by { |j| j["foodItemId"] }.map { |k, v| [k, v.map { |j| j["allergenId"] }] }.to_h
    ```

  * **Line # 88 - convention:** Layout/LineLength: Line is too long. [127/120]

    ```rb
                                                                                            liberal_parsing: true).to_a.map(&:to_h)
    ```

  * **Line # 90 - convention:** Style/HashTransformValues: Prefer `transform_values` over `map {...}.to_h`.

    ```rb
          @ingredient_ids = data.group_by { |j| j["foodItemId"] }.map { |k, v| [k, v.map { |j| j["ingredientId"] }] }.to_h
    ```

  * **Line # 90 - convention:** Style/MapToHash: Pass a block to `to_h` instead of calling `map.to_h`.

    ```rb
          @ingredient_ids = data.group_by { |j| j["foodItemId"] }.map { |k, v| [k, v.map { |j| j["ingredientId"] }] }.to_h
    ```

### app/interactions/dev/menu/import_ingredients.rb - (3 offenses)
  * **Line # 6 - convention:** Style/Documentation: Missing top-level documentation comment for `class Dev::Menu::ImportIngredients`.

    ```rb
      class ImportIngredients < ActiveInteraction::Base
    ```

  * **Line # 11 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<7, 21, 1> 22.16/17]

    ```rb
        def execute ...
    ```

  * **Line # 11 - convention:** Metrics/MethodLength: Method has too many lines. [13/10]

    ```rb
        def execute ...
    ```

### app/interactions/dev/menu/import_menus.rb - (4 offenses)
  * **Line # 6 - convention:** Style/Documentation: Missing top-level documentation comment for `class Dev::Menu::ImportMenus`.

    ```rb
      class ImportMenus < ActiveInteraction::Base
    ```

  * **Line # 11 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<7, 24, 3> 25.18/17]

    ```rb
        def execute ...
    ```

  * **Line # 11 - convention:** Metrics/MethodLength: Method has too many lines. [15/10]

    ```rb
        def execute ...
    ```

  * **Line # 24 - convention:** Rails/NegateInclude: Use `.exclude?` and remove the negation part.

    ```rb
            if row["imageId"].present? && (image = Image.find_by(member_id: row["imageId"])) && !menu.images.include?(image)
    ```

### app/interactions/dev/menu/import_tags.rb - (3 offenses)
  * **Line # 6 - convention:** Style/Documentation: Missing top-level documentation comment for `class Dev::Menu::ImportTags`.

    ```rb
      class ImportTags < ActiveInteraction::Base
    ```

  * **Line # 11 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<6, 23, 3> 23.96/17]

    ```rb
        def execute ...
    ```

  * **Line # 11 - convention:** Metrics/MethodLength: Method has too many lines. [13/10]

    ```rb
        def execute ...
    ```

### app/interactions/dev/table_info.rb - (3 offenses)
  * **Line # 14 - convention:** Rails/Output: Do not write to stdout. Use Rails's logger if you want to log.

    ```rb
          puts log_table_info if output == "log"
    ```

  * **Line # 34 - convention:** Rails/NegateInclude: Use `.exclude?` and remove the negation part.

    ```rb
          elsif !PERMITTED_OUTPUT_OPTIONS.include?(output)
    ```

  * **Line # 52 - convention:** Rails/Output: Do not write to stdout. Use Rails's logger if you want to log.

    ```rb
          puts table_info
    ```

### app/interactions/export_reservations.rb - (5 offenses)
  * **Line # 22 - convention:** Metrics/AbcSize: Assignment Branch Condition size for write_all is too high. [<2, 31, 4> 31.32/17]

    ```rb
      def write_all(sheet) ...
    ```

  * **Line # 22 - convention:** Metrics/MethodLength: Method has too many lines. [13/10]

    ```rb
      def write_all(sheet) ...
    ```

  * **Line # 32 - convention:** Layout/LineLength: Line is too long. [151/120]

    ```rb
                    [reservation.id, reservation.fullname, reservation.datetime.strftime("%e/%m/%Y %k:%M").strip, reservation.children, reservation.adults,
    ```

  * **Line # 33 - convention:** Layout/LineLength: Line is too long. [132/120]

    ```rb
                     reservation.email, reservation.phone, reservation.table, reservation.notes, reservation.status, reservation.secret,
    ```

  * **Line # 34 - convention:** Layout/LineLength: Line is too long. [130/120]

    ```rb
                     reservation.created_at.strftime("%e/%m/%Y %k:%M").strip, reservation.updated_at.strftime("%e/%m/%Y %k:%M").strip,
    ```

### app/interactions/fetch_reservation_payment_status.rb - (12 offenses)
  * **Line # 8 - convention:** Rails/Blank: Use `if reservation_payment.external_id.blank?` instead of `unless reservation_payment.external_id.present?`.

    ```rb
        errors.add(:reservation_payment, "does not have an 'external_id'") unless reservation_payment.external_id.present?
    ```

  * **Line # 23 - convention:** Metrics/AbcSize: Assignment Branch Condition size for fetch_nexi_status is too high. [<3, 46, 14> 48.18/17]

    ```rb
      def fetch_nexi_status ...
    ```

  * **Line # 23 - convention:** Metrics/CyclomaticComplexity: Cyclomatic complexity for fetch_nexi_status is too high. [12/7]

    ```rb
      def fetch_nexi_status ...
    ```

  * **Line # 23 - convention:** Metrics/MethodLength: Method has too many lines. [24/10]

    ```rb
      def fetch_nexi_status ...
    ```

  * **Line # 23 - convention:** Metrics/PerceivedComplexity: Perceived complexity for fetch_nexi_status is too high. [10/8]

    ```rb
      def fetch_nexi_status ...
    ```

  * **Line # 40 - convention:** Performance/Casecmp: Use `call.result["esito"].to_s.casecmp("ko").zero?` instead of `call.result["esito"].to_s.downcase == "ko"`.

    ```rb
        return if reservation_payment.todo? && call.result["esito"].to_s.downcase == "ko" && call.result.dig("errore",
    ```

  * **Line # 41 - convention:** Layout/LineLength: Line is too long. [126/120]

    ```rb
                                                                                                             "codice").to_s == "2"
    ```

  * **Line # 44 - convention:** Rails/Blank: Use `if item.blank?` instead of `unless item.present?`.

    ```rb
        unless item.present?
    ```

  * **Line # 49 - convention:** Rails/Blank: Use `if item["stato"].blank?` instead of `unless item["stato"].present?`.

    ```rb
        unless item["stato"].present?
    ```

  * **Line # 56 - convention:** Layout/LineLength: Line is too long. [170/120]

    ```rb
        # Non Creato: il pagamento non è arrivato all’autorizzazione, si è verificato un problema sulle fasi precedenti (es.: interruzione del 3dSecure da parte dell’utente).
    ```

  * **Line # 57 - convention:** Layout/LineLength: Line is too long. [185/120]

    ```rb
        # Autorizzato: il pagamento è stato autorizzato, non ancora contabilizzato. La contabilizzazione avviene di default automaticamente da parte di NEXI, alle ore 24 dello stesso giorno
    ```

  * **Line # 59 - convention:** Layout/LineLength: Line is too long. [168/120]

    ```rb
        # Annullato: il pagamento è stato autorizzato ma poi annullato, o per errore di notifica, o su esplicita azione dell’esercente (tramite back office, o tramite API).
    ```

### app/interactions/generate_image_variants.rb - (1 offense)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class GenerateImageVariants`.

    ```rb
    class GenerateImageVariants < ActiveInteraction::Base
    ```

### app/interactions/menu/can_publish_category.rb - (12 offenses)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class Menu::CanPublishCategory`.

    ```rb
      class CanPublishCategory < ActiveInteraction::Base
    ```

  * **Line # 10 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<2, 41, 10> 42.25/17]

    ```rb
        def execute ...
    ```

  * **Line # 10 - convention:** Metrics/CyclomaticComplexity: Cyclomatic complexity for execute is too high. [11/7]

    ```rb
        def execute ...
    ```

  * **Line # 10 - convention:** Metrics/MethodLength: Method has too many lines. [14/10]

    ```rb
        def execute ...
    ```

  * **Line # 10 - convention:** Metrics/PerceivedComplexity: Perceived complexity for execute is too high. [11/8]

    ```rb
        def execute ...
    ```

  * **Line # 61 - convention:** Layout/LineLength: Line is too long. [159/120]

    ```rb
                 "Category '#{category.name}' is not a root category: has a parent category '#{category.parent.name}'", { parent_category_id: category.parent.id })
    ```

  * **Line # 65 - convention:** Layout/LineLength: Line is too long. [197/120]

    ```rb
          reason(:missing_price, "Category '#{category.name}' has no price. Price is missing in some of the dishes too. Either place a price on all of the dishes, or place a price for the category.", {
    ```

  * **Line # 71 - convention:** Metrics/AbcSize: Assignment Branch Condition size for missing_price? is too high. [<1, 25, 10> 26.94/17]

    ```rb
        def missing_price? ...
    ```

  * **Line # 71 - convention:** Metrics/CyclomaticComplexity: Cyclomatic complexity for missing_price? is too high. [9/7]

    ```rb
        def missing_price? ...
    ```

  * **Line # 71 - convention:** Metrics/PerceivedComplexity: Perceived complexity for missing_price? is too high. [9/8]

    ```rb
        def missing_price? ...
    ```

  * **Line # 73 - convention:** Style/NumericPredicate: Use `category.price.to_i.positive?` instead of `category.price.to_i > 0`.

    ```rb
          return false if category.price.present? && category.price.to_i > 0
    ```

  * **Line # 74 - convention:** Layout/LineLength: Line is too long. [126/120]

    ```rb
          return false if category.dishes.visible.where(price: nil).empty? && category.dishes.visible.map(&:price).all? do |price|
    ```

### app/interactions/menu/copy_allergen.rb - (3 offenses)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class Menu::CopyAllergen`.

    ```rb
      class CopyAllergen < ActiveInteraction::Base
    ```

  * **Line # 27 - convention:** Metrics/AbcSize: Assignment Branch Condition size for do_copy_allergen is too high. [<3, 18, 3> 18.49/17]

    ```rb
        def do_copy_allergen ...
    ```

  * **Line # 43 - convention:** Metrics/AbcSize: Assignment Branch Condition size for do_copy_image is too high. [<3, 22, 8> 23.6/17]

    ```rb
        def do_copy_image ...
    ```

### app/interactions/menu/copy_category.rb - (11 offenses)
  * **Line # 4 - convention:** Metrics/ClassLength: Class has too many lines. [128/100]

    ```rb
      class CopyCategory < ActiveInteraction::Base ...
    ```

  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class Menu::CopyCategory`.

    ```rb
      class CopyCategory < ActiveInteraction::Base
    ```

  * **Line # 94 - convention:** Metrics/AbcSize: Assignment Branch Condition size for do_copy_category is too high. [<5, 30, 5> 30.82/17]

    ```rb
        def do_copy_category ...
    ```

  * **Line # 94 - convention:** Metrics/MethodLength: Method has too many lines. [12/10]

    ```rb
        def do_copy_category ...
    ```

  * **Line # 112 - convention:** Metrics/AbcSize: Assignment Branch Condition size for do_copy_images is too high. [<3, 22, 10> 24.35/17]

    ```rb
        def do_copy_images ...
    ```

  * **Line # 112 - convention:** Metrics/CyclomaticComplexity: Cyclomatic complexity for do_copy_images is too high. [8/7]

    ```rb
        def do_copy_images ...
    ```

  * **Line # 112 - convention:** Metrics/MethodLength: Method has too many lines. [12/10]

    ```rb
        def do_copy_images ...
    ```

  * **Line # 112 - convention:** Metrics/PerceivedComplexity: Perceived complexity for do_copy_images is too high. [9/8]

    ```rb
        def do_copy_images ...
    ```

  * **Line # 129 - convention:** Metrics/AbcSize: Assignment Branch Condition size for do_copy_dishes is too high. [<2, 19, 9> 21.12/17]

    ```rb
        def do_copy_dishes ...
    ```

  * **Line # 129 - convention:** Metrics/MethodLength: Method has too many lines. [12/10]

    ```rb
        def do_copy_dishes ...
    ```

  * **Line # 170 - convention:** Metrics/AbcSize: Assignment Branch Condition size for validate_parent_id is too high. [<0, 20, 5> 20.62/17]

    ```rb
        def validate_parent_id ...
    ```

### app/interactions/menu/copy_dish.rb - (12 offenses)
  * **Line # 26 - convention:** Metrics/MethodLength: Method has too many lines. [12/10]

    ```rb
        def execute ...
    ```

  * **Line # 45 - convention:** Metrics/AbcSize: Assignment Branch Condition size for do_copy_dish is too high. [<3, 18, 3> 18.49/17]

    ```rb
        def do_copy_dish ...
    ```

  * **Line # 61 - convention:** Metrics/AbcSize: Assignment Branch Condition size for do_copy_images is too high. [<3, 22, 9> 23.96/17]

    ```rb
        def do_copy_images ...
    ```

  * **Line # 61 - convention:** Metrics/CyclomaticComplexity: Cyclomatic complexity for do_copy_images is too high. [8/7]

    ```rb
        def do_copy_images ...
    ```

  * **Line # 61 - convention:** Metrics/MethodLength: Method has too many lines. [12/10]

    ```rb
        def do_copy_images ...
    ```

  * **Line # 61 - convention:** Metrics/PerceivedComplexity: Perceived complexity for do_copy_images is too high. [9/8]

    ```rb
        def do_copy_images ...
    ```

  * **Line # 78 - convention:** Metrics/AbcSize: Assignment Branch Condition size for do_copy_ingredients is too high. [<2, 19, 8> 20.71/17]

    ```rb
        def do_copy_ingredients ...
    ```

  * **Line # 78 - convention:** Metrics/MethodLength: Method has too many lines. [12/10]

    ```rb
        def do_copy_ingredients ...
    ```

  * **Line # 95 - convention:** Metrics/AbcSize: Assignment Branch Condition size for do_copy_tags is too high. [<2, 19, 8> 20.71/17]

    ```rb
        def do_copy_tags ...
    ```

  * **Line # 95 - convention:** Metrics/MethodLength: Method has too many lines. [12/10]

    ```rb
        def do_copy_tags ...
    ```

  * **Line # 118 - convention:** Metrics/AbcSize: Assignment Branch Condition size for do_copy_allergens is too high. [<2, 19, 8> 20.71/17]

    ```rb
        def do_copy_allergens ...
    ```

  * **Line # 118 - convention:** Metrics/MethodLength: Method has too many lines. [12/10]

    ```rb
        def do_copy_allergens ...
    ```

### app/interactions/menu/copy_ingredient.rb - (3 offenses)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class Menu::CopyIngredient`.

    ```rb
      class CopyIngredient < ActiveInteraction::Base
    ```

  * **Line # 27 - convention:** Metrics/AbcSize: Assignment Branch Condition size for do_copy_ingredient is too high. [<3, 18, 3> 18.49/17]

    ```rb
        def do_copy_ingredient ...
    ```

  * **Line # 43 - convention:** Metrics/AbcSize: Assignment Branch Condition size for do_copy_image is too high. [<3, 22, 8> 23.6/17]

    ```rb
        def do_copy_image ...
    ```

### app/interactions/menu/copy_tag.rb - (3 offenses)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class Menu::CopyTag`.

    ```rb
      class CopyTag < ActiveInteraction::Base
    ```

  * **Line # 27 - convention:** Metrics/AbcSize: Assignment Branch Condition size for do_copy_tag is too high. [<3, 18, 3> 18.49/17]

    ```rb
        def do_copy_tag ...
    ```

  * **Line # 43 - convention:** Metrics/AbcSize: Assignment Branch Condition size for do_copy_image is too high. [<3, 22, 8> 23.6/17]

    ```rb
        def do_copy_image ...
    ```

### app/interactions/menu/export_menu.rb - (18 offenses)
  * **Line # 13 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<2, 25, 2> 25.16/17]

    ```rb
        def execute ...
    ```

  * **Line # 13 - convention:** Metrics/MethodLength: Method has too many lines. [11/10]

    ```rb
        def execute ...
    ```

  * **Line # 30 - convention:** Metrics/AbcSize: Assignment Branch Condition size for write_all is too high. [<10, 79, 10> 80.26/17]

    ```rb
        def write_all(sheet) ...
    ```

  * **Line # 30 - convention:** Metrics/CyclomaticComplexity: Cyclomatic complexity for write_all is too high. [11/7]

    ```rb
        def write_all(sheet) ...
    ```

  * **Line # 30 - convention:** Metrics/MethodLength: Method has too many lines. [21/10]

    ```rb
        def write_all(sheet) ...
    ```

  * **Line # 30 - convention:** Metrics/PerceivedComplexity: Perceived complexity for write_all is too high. [11/8]

    ```rb
        def write_all(sheet) ...
    ```

  * **Line # 34 - convention:** Layout/LineLength: Line is too long. [148/120]

    ```rb
                      ["Category", cat.id, cat.name_it, cat.name_en, cat.description_it, cat.description_en, cat.status, cat.images.map(&:url)].flatten)
    ```

  * **Line # 37 - convention:** Layout/LineLength: Line is too long. [153/120]

    ```rb
                        ["Dish", dish.id, dish.name_it, dish.name_en, dish.description_it, dish.description_en, dish.status, dish.images.map(&:url)].flatten)
    ```

  * **Line # 40 - convention:** Layout/LineLength: Line is too long. [132/120]

    ```rb
                          ["Tag", tag.id, tag.name_it, tag.name_en, tag.description_it, tag.description_en, tag.status, tag.image&.url])
    ```

  * **Line # 45 - convention:** Layout/LineLength: Line is too long. [172/120]

    ```rb
                          ["Allergen", allergen.id, allergen.name_it, allergen.name_en, allergen.description_it, allergen.description_en, allergen.status, allergen.image&.url])
    ```

  * **Line # 50 - convention:** Layout/LineLength: Line is too long. [188/120]

    ```rb
                          ["Ingredient", ingredient.id, ingredient.name_it, ingredient.name_en, ingredient.description_it, ingredient.description_en, ingredient.status, ingredient.image&.url])
    ```

  * **Line # 56 - convention:** Metrics/AbcSize: Assignment Branch Condition size for write_menu is too high. [<2, 18, 2> 18.22/17]

    ```rb
        def write_menu(sheet) ...
    ```

  * **Line # 61 - convention:** Layout/LineLength: Line is too long. [179/120]

    ```rb
                      [cat.id, cat.name_it, cat.name_en, cat.description_it, cat.description_en, cat.status, cat.price, cat.updated_at, cat.created_at, cat.images.map(&:url)].flatten)
    ```

  * **Line # 65 - convention:** Metrics/AbcSize: Assignment Branch Condition size for write_dishes is too high. [<2, 17, 2> 17.23/17]

    ```rb
        def write_dishes(sheet) ...
    ```

  * **Line # 70 - convention:** Layout/LineLength: Line is too long. [189/120]

    ```rb
                      [dish.id, dish.name_it, dish.name_en, dish.description_it, dish.description_en, dish.status, dish.price, dish.updated_at, dish.created_at, dish.images.map(&:url)].flatten)
    ```

  * **Line # 78 - convention:** Layout/LineLength: Line is too long. [198/120]

    ```rb
                      [allergen.id, allergen.name_it, allergen.name_en, allergen.description_it, allergen.description_en, allergen.status, allergen.image&.url, allergen.updated_at, allergen.created_at])
    ```

  * **Line # 87 - convention:** Layout/LineLength: Line is too long. [164/120]

    ```rb
                      [tag.id, tag.name_it, tag.name_en, tag.description_it, tag.description_en, tag.status, tag.color, tag.image&.url, tag.updated_at, tag.created_at])
    ```

  * **Line # 95 - convention:** Layout/LineLength: Line is too long. [216/120]

    ```rb
                      [ingredient.id, ingredient.name_it, ingredient.name_en, ingredient.description_it, ingredient.description_en, ingredient.status, ingredient.image&.url, ingredient.updated_at, ingredient.created_at])
    ```

### app/interactions/menu/move_allergen.rb - (3 offenses)
  * **Line # 20 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<4, 26, 5> 26.78/17]

    ```rb
        def execute ...
    ```

  * **Line # 20 - convention:** Metrics/MethodLength: Method has too many lines. [13/10]

    ```rb
        def execute ...
    ```

  * **Line # 22 - convention:** Rails/SkipsModelValidations: Avoid using `update_all` because it skips validations.

    ```rb
            Menu::AllergensInDish.where(dish_id:).update_all("index = index + 100000")
    ```

### app/interactions/menu/move_dish.rb - (5 offenses)
  * **Line # 6 - convention:** Layout/LineLength: Line is too long. [125/120]

    ```rb
      # So when we 'move a dish', we actually move it to a new index in a category, we don't update the index of the dish itself.
    ```

  * **Line # 24 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<4, 26, 5> 26.78/17]

    ```rb
        def execute ...
    ```

  * **Line # 24 - convention:** Metrics/MethodLength: Method has too many lines. [13/10]

    ```rb
        def execute ...
    ```

  * **Line # 26 - convention:** Rails/SkipsModelValidations: Avoid using `update_all` because it skips validations.

    ```rb
            Menu::DishesInCategory.where(menu_category_id: category_id).update_all("index = index + 100000")
    ```

  * **Line # 60 - convention:** Layout/LineLength: Line is too long. [124/120]

    ```rb
          @siblings ||= Menu::DishesInCategory.where(menu_category_id: category_id).where.not(id: association&.id).order(:index)
    ```

### app/interactions/menu/move_ingredient.rb - (3 offenses)
  * **Line # 20 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<4, 26, 5> 26.78/17]

    ```rb
        def execute ...
    ```

  * **Line # 20 - convention:** Metrics/MethodLength: Method has too many lines. [13/10]

    ```rb
        def execute ...
    ```

  * **Line # 22 - convention:** Rails/SkipsModelValidations: Avoid using `update_all` because it skips validations.

    ```rb
            Menu::IngredientsInDish.where(dish_id:).update_all("index = index + 100000")
    ```

### app/interactions/menu/move_tag.rb - (3 offenses)
  * **Line # 20 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<4, 26, 5> 26.78/17]

    ```rb
        def execute ...
    ```

  * **Line # 20 - convention:** Metrics/MethodLength: Method has too many lines. [13/10]

    ```rb
        def execute ...
    ```

  * **Line # 22 - convention:** Rails/SkipsModelValidations: Avoid using `update_all` because it skips validations.

    ```rb
            Menu::TagsInDish.where(dish_id:).update_all("index = index + 100000")
    ```

### app/interactions/menu/order_dishes_in_category.rb - (1 offense)
  * **Line # 18 - convention:** Rails/SkipsModelValidations: Avoid using `update_all` because it skips validations.

    ```rb
            Menu::DishesInCategory.where(category:).update_all("index = index + 100000")
    ```

### app/interactions/menu/search_allergens.rb - (8 offenses)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class Menu::SearchAllergens`.

    ```rb
      class SearchAllergens < ActiveInteraction::Base
    ```

  * **Line # 7 - convention:** Metrics/MethodLength: Method has too many lines. [15/10]

    ```rb
        def execute ...
    ```

  * **Line # 36 - convention:** Layout/LineLength: Line is too long. [163/120]

    ```rb
          items.joins(:menu_allergens_in_dishes).where(menu_allergens_in_dishes: { menu_dish_id: params[:associated_dish_id] }).order("menu_allergens_in_dishes.index")
    ```

  * **Line # 42 - convention:** Layout/LineLength: Line is too long. [124/120]

    ```rb
          items.where.not(id: Menu::AllergensInDish.where(menu_dish_id: params[:avoid_associated_dish_id]).select(:allergen_id))
    ```

  * **Line # 50 - convention:** Style/PreferredHashMethods: Use `Hash#key?` instead of `Hash#has_key?`.

    ```rb
          return items unless params.has_key?(:name)
    ```

  * **Line # 56 - convention:** Style/PreferredHashMethods: Use `Hash#key?` instead of `Hash#has_key?`.

    ```rb
          return items unless params.has_key?(:description)
    ```

  * **Line # 62 - convention:** Style/PreferredHashMethods: Use `Hash#key?` instead of `Hash#has_key?`.

    ```rb
          return items unless params.has_key?(:status)
    ```

  * **Line # 68 - convention:** Style/PreferredHashMethods: Use `Hash#key?` instead of `Hash#has_key?`.

    ```rb
          return items unless params.has_key?(:query)
    ```

### app/interactions/menu/search_categories.rb - (7 offenses)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class Menu::SearchCategories`.

    ```rb
      class SearchCategories < SearchRecords
    ```

  * **Line # 7 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<9, 50, 12> 52.2/17]

    ```rb
        def execute ...
    ```

  * **Line # 7 - convention:** Metrics/CyclomaticComplexity: Cyclomatic complexity for execute is too high. [12/7]

    ```rb
        def execute ...
    ```

  * **Line # 7 - convention:** Metrics/MethodLength: Method has too many lines. [16/10]

    ```rb
        def execute ...
    ```

  * **Line # 7 - convention:** Metrics/PerceivedComplexity: Perceived complexity for execute is too high. [12/8]

    ```rb
        def execute ...
    ```

  * **Line # 20 - convention:** Style/PreferredHashMethods: Use `Hash#key?` instead of `Hash#has_key?`.

    ```rb
          categories = categories.where(parent_id: params[:parent_id].presence) if params.has_key?(:parent_id)
    ```

  * **Line # 27 - convention:** Performance/Casecmp: Use `params[:fixed_price].to_s.casecmp("true").zero?` instead of `params[:fixed_price].to_s.downcase == "true"`.

    ```rb
            value = params[:fixed_price].to_s.downcase == "true"
    ```

### app/interactions/menu/search_dishes.rb - (8 offenses)
  * **Line # 4 - convention:** Metrics/ClassLength: Class has too many lines. [105/100]

    ```rb
      class SearchDishes < ActiveInteraction::Base ...
    ```

  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class Menu::SearchDishes`.

    ```rb
      class SearchDishes < ActiveInteraction::Base
    ```

  * **Line # 9 - convention:** Metrics/MethodLength: Method has too many lines. [21/10]

    ```rb
        def execute ...
    ```

  * **Line # 48 - convention:** Layout/LineLength: Line is too long. [153/120]

    ```rb
          items.where.not(id: params[:can_suggest].to_i).where.not(id: Menu::DishSuggestion.where(dish_id: params[:can_suggest].to_i).select(:suggestion_id))
    ```

  * **Line # 92 - convention:** Metrics/AbcSize: Assignment Branch Condition size for filter_by_price is too high. [<8, 72, 20> 75.15/17]

    ```rb
        def filter_by_price(items) ...
    ```

  * **Line # 92 - convention:** Metrics/CyclomaticComplexity: Cyclomatic complexity for filter_by_price is too high. [21/7]

    ```rb
        def filter_by_price(items) ...
    ```

  * **Line # 92 - convention:** Metrics/MethodLength: Method has too many lines. [20/10]

    ```rb
        def filter_by_price(items) ...
    ```

  * **Line # 92 - convention:** Metrics/PerceivedComplexity: Perceived complexity for filter_by_price is too high. [21/8]

    ```rb
        def filter_by_price(items) ...
    ```

### app/interactions/menu/search_ingredients.rb - (8 offenses)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class Menu::SearchIngredients`.

    ```rb
      class SearchIngredients < ActiveInteraction::Base
    ```

  * **Line # 7 - convention:** Metrics/MethodLength: Method has too many lines. [15/10]

    ```rb
        def execute ...
    ```

  * **Line # 36 - convention:** Layout/LineLength: Line is too long. [169/120]

    ```rb
          items.joins(:menu_ingredients_in_dishes).where(menu_ingredients_in_dishes: { menu_dish_id: params[:associated_dish_id] }).order("menu_ingredients_in_dishes.index")
    ```

  * **Line # 42 - convention:** Layout/LineLength: Line is too long. [128/120]

    ```rb
          items.where.not(id: Menu::IngredientsInDish.where(menu_dish_id: params[:avoid_associated_dish_id]).select(:ingredient_id))
    ```

  * **Line # 50 - convention:** Style/PreferredHashMethods: Use `Hash#key?` instead of `Hash#has_key?`.

    ```rb
          return items unless params.has_key?(:name)
    ```

  * **Line # 56 - convention:** Style/PreferredHashMethods: Use `Hash#key?` instead of `Hash#has_key?`.

    ```rb
          return items unless params.has_key?(:description)
    ```

  * **Line # 62 - convention:** Style/PreferredHashMethods: Use `Hash#key?` instead of `Hash#has_key?`.

    ```rb
          return items unless params.has_key?(:status)
    ```

  * **Line # 68 - convention:** Style/PreferredHashMethods: Use `Hash#key?` instead of `Hash#has_key?`.

    ```rb
          return items unless params.has_key?(:query)
    ```

### app/interactions/menu/search_tags.rb - (7 offenses)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class Menu::SearchTags`.

    ```rb
      class SearchTags < ActiveInteraction::Base
    ```

  * **Line # 7 - convention:** Metrics/MethodLength: Method has too many lines. [15/10]

    ```rb
        def execute ...
    ```

  * **Line # 36 - convention:** Layout/LineLength: Line is too long. [148/120]

    ```rb
          items.joins(:menu_tags_in_dishes).where(menu_tags_in_dishes: { menu_dish_id: params[:associated_dish_id] }).order("menu_tags_in_dishes.index")
    ```

  * **Line # 50 - convention:** Style/PreferredHashMethods: Use `Hash#key?` instead of `Hash#has_key?`.

    ```rb
          return items unless params.has_key?(:name)
    ```

  * **Line # 56 - convention:** Style/PreferredHashMethods: Use `Hash#key?` instead of `Hash#has_key?`.

    ```rb
          return items unless params.has_key?(:description)
    ```

  * **Line # 62 - convention:** Style/PreferredHashMethods: Use `Hash#key?` instead of `Hash#has_key?`.

    ```rb
          return items unless params.has_key?(:status)
    ```

  * **Line # 68 - convention:** Style/PreferredHashMethods: Use `Hash#key?` instead of `Hash#has_key?`.

    ```rb
          return items unless params.has_key?(:query)
    ```

### app/interactions/menu/update_dishes_prices.rb - (6 offenses)
  * **Line # 6 - convention:** Layout/LineLength: Line is too long. [171/120]

    ```rb
      # - filters: key-value object with filters to search dishes. If not present, all dishes will be updated. Format of the object is the same as in GET /v1/admin/menu/dishes
    ```

  * **Line # 7 - convention:** Layout/LineLength: Line is too long. [130/120]

    ```rb
      # - percent: float, percentage to increase/decrease the price. If positive, the price will be increased, if negative, decreased.
    ```

  * **Line # 8 - convention:** Layout/LineLength: Line is too long. [125/120]

    ```rb
      # - amount: float, amount to increase/decrease the price. If positive, the price will be increased, if negative, decreased.
    ```

  * **Line # 23 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<3, 25, 9> 26.74/17]

    ```rb
        def execute ...
    ```

  * **Line # 23 - convention:** Metrics/CyclomaticComplexity: Cyclomatic complexity for execute is too high. [8/7]

    ```rb
        def execute ...
    ```

  * **Line # 23 - convention:** Metrics/MethodLength: Method has too many lines. [11/10]

    ```rb
        def execute ...
    ```

### app/interactions/nexi/client.rb - (10 offenses)
  * **Line # 8 - convention:** Metrics/ClassLength: Class has too many lines. [123/100]

    ```rb
      class Client < ActiveInteraction::Base ...
    ```

  * **Line # 23 - convention:** Layout/LineLength: Line is too long. [131/120]

    ```rb
                                           Config.nexi_alias_merchant || raise("missing nexi_alias_merchant. update your credentials.")
    ```

  * **Line # 89 - convention:** Metrics/MethodLength: Method has too many lines. [11/10]

    ```rb
        def send_request ...
    ```

  * **Line # 118 - convention:** Metrics/AbcSize: Assignment Branch Condition size for validate_response is too high. [<6, 35, 9> 36.63/17]

    ```rb
        def validate_response ...
    ```

  * **Line # 118 - convention:** Metrics/CyclomaticComplexity: Cyclomatic complexity for validate_response is too high. [9/7]

    ```rb
        def validate_response ...
    ```

  * **Line # 118 - convention:** Metrics/MethodLength: Method has too many lines. [18/10]

    ```rb
        def validate_response ...
    ```

  * **Line # 118 - convention:** Metrics/PerceivedComplexity: Perceived complexity for validate_response is too high. [9/8]

    ```rb
        def validate_response ...
    ```

  * **Line # 134 - convention:** Performance/CollectionLiteralInLoop: Avoid immutable Array literals in loops. It is better to extract it into a local variable or a constant.

    ```rb
            ["", "-", ".", "_"].each do |separator|
    ```

  * **Line # 135 - convention:** Performance/CollectionLiteralInLoop: Avoid immutable Array literals in loops. It is better to extract it into a local variable or a constant.

    ```rb
              ["", "msg", "message", "spec", "code"].each do |spec|
    ```

  * **Line # 153 - convention:** Metrics/MethodLength: Method has too many lines. [14/10]

    ```rb
        def create_http_request ...
    ```

### app/interactions/nexi/create_reservation_payment.rb - (3 offenses)
  * **Line # 17 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<1, 28, 4> 28.3/17]

    ```rb
        def execute ...
    ```

  * **Line # 17 - convention:** Metrics/MethodLength: Method has too many lines. [15/10]

    ```rb
        def execute ...
    ```

  * **Line # 52 - convention:** Metrics/MethodLength: Method has too many lines. [13/10]

    ```rb
        def create_payment ...
    ```

### app/interactions/nexi/get_order_status.rb - (4 offenses)
  * **Line # 21 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<1, 20, 3> 20.25/17]

    ```rb
        def execute ...
    ```

  * **Line # 21 - convention:** Metrics/MethodLength: Method has too many lines. [12/10]

    ```rb
        def execute ...
    ```

  * **Line # 28 - convention:** Layout/LineLength: Line is too long. [144/120]

    ```rb
            mac_part: "apiKey=#{Config.nexi_alias_merchant}codiceTransazione=#{params.dig!(:codiceTransazione)}timeStamp=#{params.dig!(:timeStamp)}"
    ```

  * **Line # 47 - convention:** Metrics/AbcSize: Assignment Branch Condition size for validate_response is too high. [<1, 20, 5> 20.64/17]

    ```rb
        def validate_response ...
    ```

### app/interactions/nexi/receive_order_outcome.rb - (4 offenses)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class Nexi::ReceiveOrderOutcome`.

    ```rb
      class ReceiveOrderOutcome < ActiveInteraction::Base
    ```

  * **Line # 7 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<0, 31, 3> 31.14/17]

    ```rb
        def execute ...
    ```

  * **Line # 7 - convention:** Metrics/MethodLength: Method has too many lines. [12/10]

    ```rb
        def execute ...
    ```

  * **Line # 23 - convention:** Layout/LineLength: Line is too long. [134/120]

    ```rb
          Rails.logger.warn "Nexi::ReceiveOrderOutcome: Don't know what to do with params: #{params.inspect}, headers: #{headers.inspect}"
    ```

### app/interactions/nexi/refund_payment.rb - (7 offenses)
  * **Line # 24 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<1, 25, 3> 25.2/17]

    ```rb
        def execute ...
    ```

  * **Line # 24 - convention:** Metrics/MethodLength: Method has too many lines. [12/10]

    ```rb
        def execute ...
    ```

  * **Line # 31 - convention:** Layout/LineLength: Line is too long. [206/120]

    ```rb
            mac_part: "apiKey=#{Config.nexi_alias_merchant}codiceTransazione=#{params.dig!(:codiceTransazione)}divisa=#{params.dig!(:divisa)}importo=#{params.dig!(:importo)}timeStamp=#{params.dig!(:timeStamp)}"
    ```

  * **Line # 52 - convention:** Metrics/AbcSize: Assignment Branch Condition size for validate_response is too high. [<1, 27, 8> 28.18/17]

    ```rb
        def validate_response ...
    ```

  * **Line # 52 - convention:** Metrics/CyclomaticComplexity: Cyclomatic complexity for validate_response is too high. [8/7]

    ```rb
        def validate_response ...
    ```

  * **Line # 56 - convention:** Performance/Casecmp: Use `!client.json.dig("esito").to_s.casecmp("ok").zero?` instead of `client.json.dig("esito").to_s.downcase != "ok"`.

    ```rb
          e << "field 'esito' is not 'ok'" if e.empty? && client.json.dig("esito").to_s.downcase != "ok"
    ```

  * **Line # 56 - convention:** Style/SingleArgumentDig: Use `client.json["esito"]` instead of `client.json.dig("esito")`.

    ```rb
          e << "field 'esito' is not 'ok'" if e.empty? && client.json.dig("esito").to_s.downcase != "ok"
    ```

### app/interactions/nexi/simple_payment.rb - (4 offenses)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class Nexi::SimplePayment`.

    ```rb
      class SimplePayment < ActiveInteraction::Base
    ```

  * **Line # 18 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<1, 22, 3> 22.23/17]

    ```rb
        def execute ...
    ```

  * **Line # 18 - convention:** Metrics/MethodLength: Method has too many lines. [11/10]

    ```rb
        def execute ...
    ```

  * **Line # 51 - convention:** Metrics/AbcSize: Assignment Branch Condition size for validate_response is too high. [<1, 20, 5> 20.64/17]

    ```rb
        def validate_response ...
    ```

### app/interactions/profile/change_email.rb - (1 offense)
  * **Line # 25 - convention:** Layout/LineLength: Line is too long. [122/120]

    ```rb
          # user.events << User::Event.new(event_type: :email_changed, data: { old_email: @old_email, new_email: user.email })
    ```

### app/interactions/public_cancel_reservation.rb - (1 offense)
  * **Line # 14 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<0, 18, 3> 18.25/17]

    ```rb
      def execute ...
    ```

### app/interactions/public_create_reservation.rb - (6 offenses)
  * **Line # 3 - convention:** Metrics/ClassLength: Class has too many lines. [193/100]

    ```rb
    class PublicCreateReservation < ActiveInteraction::Base ...
    ```

  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class PublicCreateReservation`.

    ```rb
    class PublicCreateReservation < ActiveInteraction::Base
    ```

  * **Line # 36 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<2, 34, 6> 34.58/17]

    ```rb
      def execute ...
    ```

  * **Line # 36 - convention:** Metrics/MethodLength: Method has too many lines. [27/10]

    ```rb
      def execute ...
    ```

  * **Line # 212 - convention:** Metrics/AbcSize: Assignment Branch Condition size for datetime_format_is_valid is too high. [<0, 17, 3> 17.26/17]

    ```rb
      def datetime_format_is_valid ...
    ```

  * **Line # 264 - convention:** Style/NumericPredicate: Use `(datetime.to_i % reservation_turn.step).zero?` instead of `datetime.to_i % reservation_turn.step == 0`.

    ```rb
        return if datetime.to_i % reservation_turn.step == 0
    ```

### app/interactions/refund_reservation_payment.rb - (4 offenses)
  * **Line # 9 - convention:** Rails/Blank: Use `if reservation.payment.blank?` instead of `unless reservation.payment.present?`.

    ```rb
        errors.add(:reservation, "does not have a payment") unless reservation.payment.present?
    ```

  * **Line # 20 - convention:** Layout/LineLength: Line is too long. [199/120]

    ```rb
                     "too much time has passed. Reservation date was more than 10 days ago. You'll need to refund the payment by Nexi graphical interface. OrderID is #{reservation.payment&.external_id}")
    ```

  * **Line # 29 - convention:** Metrics/AbcSize: Assignment Branch Condition size for do_refund is too high. [<1, 22, 2> 22.11/17]

    ```rb
      def do_refund ...
    ```

  * **Line # 29 - convention:** Metrics/MethodLength: Method has too many lines. [12/10]

    ```rb
      def do_refund ...
    ```

### app/interactions/remind_reservations_mail.rb - (2 offenses)
  * **Line # 15 - convention:** Metrics/AbcSize: Assignment Branch Condition size for elegible is too high. [<2, 17, 1> 17.15/17]

    ```rb
      def elegible ...
    ```

  * **Line # 15 - convention:** Metrics/MethodLength: Method has too many lines. [13/10]

    ```rb
      def elegible ...
    ```

### app/interactions/reservation_ics.rb - (4 offenses)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class ReservationIcs`.

    ```rb
    class ReservationIcs < ActiveInteraction::Base
    ```

  * **Line # 6 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<12, 33, 2> 35.17/17]

    ```rb
      def execute ...
    ```

  * **Line # 6 - convention:** Metrics/MethodLength: Method has too many lines. [17/10]

    ```rb
      def execute ...
    ```

  * **Line # 17 - convention:** Layout/LineLength: Line is too long. [124/120]

    ```rb
          e.attendee = ["mailto:#{organization_email}", "mailto:#{reservation.email}"] # one or more email recipients (required)
    ```

### app/interactions/reservation_requires_payment.rb - (4 offenses)
  * **Line # 11 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<0, 33, 8> 33.96/17]

    ```rb
      def execute ...
    ```

  * **Line # 11 - convention:** Metrics/MethodLength: Method has too many lines. [14/10]

    ```rb
      def execute ...
    ```

  * **Line # 17 - convention:** Layout/LineLength: Line is too long. [124/120]

    ```rb
            raise "matching more than one turn. Reservation #{reservation.inspect} is matching turns: #{matching_turns.as_json}"
    ```

  * **Line # 21 - convention:** Layout/LineLength: Line is too long. [135/120]

    ```rb
            raise "Expected one group for turn #{matching_turns.first.id}, got #{matching_turns.first.preorder_reservation_groups.as_json}"
    ```

### app/interactions/reservation_turn_valid_times.rb - (2 offenses)
  * **Line # 11 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<14, 36, 9> 39.66/17]

    ```rb
      def execute ...
    ```

  * **Line # 11 - convention:** Metrics/MethodLength: Method has too many lines. [18/10]

    ```rb
      def execute ...
    ```

### app/interactions/search_holidays.rb - (2 offenses)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class SearchHolidays`.

    ```rb
    class SearchHolidays < ActiveInteraction::Base
    ```

  * **Line # 6 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<4, 20, 3> 20.62/17]

    ```rb
      def execute ...
    ```

### app/interactions/search_images.rb - (2 offenses)
  * **Line # 7 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<5, 26, 5> 26.94/17]

    ```rb
      def execute ...
    ```

  * **Line # 7 - convention:** Metrics/MethodLength: Method has too many lines. [12/10]

    ```rb
      def execute ...
    ```

### app/interactions/search_reservation_turn_messages.rb - (1 offense)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class SearchReservationTurnMessages`.

    ```rb
    class SearchReservationTurnMessages < ActiveInteraction::Base
    ```

### app/interactions/search_reservations.rb - (18 offenses)
  * **Line # 3 - convention:** Metrics/ClassLength: Class has too many lines. [140/100]

    ```rb
    class SearchReservations < ActiveInteraction::Base ...
    ```

  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class SearchReservations`.

    ```rb
    class SearchReservations < ActiveInteraction::Base
    ```

  * **Line # 17 - convention:** Metrics/MethodLength: Method has too many lines. [15/10]

    ```rb
      def execute ...
    ```

  * **Line # 37 - convention:** Metrics/AbcSize: Assignment Branch Condition size for filter_by_people is too high. [<3, 18, 3> 18.49/17]

    ```rb
      def filter_by_people(items) ...
    ```

  * **Line # 45 - convention:** Metrics/AbcSize: Assignment Branch Condition size for order is too high. [<10, 43, 23> 49.78/17]

    ```rb
      def order(items) ...
    ```

  * **Line # 45 - convention:** Metrics/CyclomaticComplexity: Cyclomatic complexity for order is too high. [23/7]

    ```rb
      def order(items) ...
    ```

  * **Line # 45 - convention:** Metrics/MethodLength: Method has too many lines. [25/10]

    ```rb
      def order(items) ...
    ```

  * **Line # 45 - convention:** Metrics/PerceivedComplexity: Perceived complexity for order is too high. [23/8]

    ```rb
      def order(items) ...
    ```

  * **Line # 65 - convention:** Style/RedundantArgument: Argument " " is redundant because it is implied by default.

    ```rb
        if order_by.is_a?(String) && order_by.present? && items.column_names.include?(order_by.split(" ").first)
    ```

  * **Line # 75 - convention:** Performance/Casecmp: Use `direction.to_s.casecmp("desc").zero?` instead of `direction.to_s.downcase == "desc"`.

    ```rb
            return items.order(attribute => direction.to_s.downcase == "desc" ? :desc : :asc)
    ```

  * **Line # 87 - convention:** Metrics/AbcSize: Assignment Branch Condition size for filter_by_time is too high. [<2, 20, 5> 20.71/17]

    ```rb
      def filter_by_time(items) ...
    ```

  * **Line # 87 - convention:** Metrics/MethodLength: Method has too many lines. [17/10]

    ```rb
      def filter_by_time(items) ...
    ```

  * **Line # 135 - convention:** Metrics/AbcSize: Assignment Branch Condition size for datetime_range is too high. [<7, 32, 6> 33.3/17]

    ```rb
      def datetime_range(options = params) ...
    ```

  * **Line # 135 - convention:** Metrics/MethodLength: Method has too many lines. [12/10]

    ```rb
      def datetime_range(options = params) ...
    ```

  * **Line # 155 - convention:** Naming/PredicateName: Rename `is_true?` to `true?`.

    ```rb
      def is_true?(value)
    ```

  * **Line # 173 - convention:** Layout/LineLength: Line is too long. [253/120]

    ```rb
          "lower(#{Reservation.table_name}.fullname) ILIKE ? OR lower(#{Reservation.table_name}.notes) ILIKE ? or lower(#{Reservation.table_name}.email) ILIKE ?", "%#{params[:query].downcase}%", "%#{params[:query].downcase}%", "%#{params[:query].downcase}%"
    ```

  * **Line # 178 - convention:** Performance/MapMethodChain: Use `map { |x| x.downcase.strip }` instead of `map` method chain.

    ```rb
        statuses = status_params.map(&:downcase).map(&:strip).uniq.filter { |status| Reservation.statuses.key?(status) }
    ```

  * **Line # 186 - convention:** Metrics/AbcSize: Assignment Branch Condition size for status_params is too high. [<0, 24, 4> 24.33/17]

    ```rb
      def status_params ...
    ```

### app/interactions/search_users.rb - (2 offenses)
  * **Line # 8 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<6, 28, 6> 29.26/17]

    ```rb
      def execute ...
    ```

  * **Line # 8 - convention:** Metrics/MethodLength: Method has too many lines. [13/10]

    ```rb
      def execute ...
    ```

### app/interactions/stats/all.rb - (3 offenses)
  * **Line # 17 - convention:** Metrics/AbcSize: Assignment Branch Condition size for keys is too high. [<5, 17, 7> 19.05/17]

    ```rb
        def keys ...
    ```

  * **Line # 17 - convention:** Metrics/CyclomaticComplexity: Cyclomatic complexity for keys is too high. [8/7]

    ```rb
        def keys ...
    ```

  * **Line # 36 - convention:** Style/ReturnNilInPredicateMethodDefinition: Return `false` instead of `nil` in predicate methods.

    ```rb
          return if keys.all? { |key| VALID_KEYS.include?(key.to_s) }
    ```

### app/interactions/stats/reservations_by_hour.rb - (4 offenses)
  * **Line # 11 - convention:** Style/MultilineBlockChain: Avoid multi-line chains of blocks.

    ```rb
          end.transform_values { |rs| rs.map { |r| r.people }.sum }
    ```

  * **Line # 11 - convention:** Performance/Sum: Use `sum { ... }` instead of `map { ... }.sum`.

    ```rb
          end.transform_values { |rs| rs.map { |r| r.people }.sum }
    ```

  * **Line # 11 - convention:** Style/SymbolProc: Pass `&:people` as an argument to `map` instead of a block.

    ```rb
          end.transform_values { |rs| rs.map { |r| r.people }.sum }
    ```

  * **Line # 31 - convention:** Style/MapToHash: Pass a block to `to_h` instead of calling `map.to_h`.

    ```rb
          @reservation_filters ||= params.keys.filter { |key| key.start_with?("reservation") }.map do |key|
    ```

### app/interactions/string_to_duration.rb - (5 offenses)
  * **Line # 22 - convention:** Style/RedundantArgument: Argument " " is redundant because it is implied by default.

    ```rb
        clean_string.split(" ").second&.gsub(/\d/, "")
    ```

  * **Line # 26 - convention:** Style/RedundantArgument: Argument " " is redundant because it is implied by default.

    ```rb
        clean_string.split(" ").first&.gsub(/\D/, "")
    ```

  * **Line # 33 - convention:** Metrics/AbcSize: Assignment Branch Condition size for validate! is too high. [<0, 25, 8> 26.25/17]

    ```rb
      def validate! ...
    ```

  * **Line # 33 - convention:** Metrics/CyclomaticComplexity: Cyclomatic complexity for validate! is too high. [8/7]

    ```rb
      def validate! ...
    ```

  * **Line # 38 - convention:** Style/RedundantArgument: Argument " " is redundant because it is implied by default.

    ```rb
        errors.add(:string, "should respect the format: 1 day") if clean_string.split(" ").count != 2
    ```

### app/interactions/tables_summary.rb - (1 offense)
  * **Line # 48 - convention:** Style/MultilineBlockChain: Avoid multi-line chains of blocks.

    ```rb
        end.transform_values { |j| j["count"] }
    ```

### app/interactions/update_preorder_group.rb - (7 offenses)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class UpdatePreorderGroup`.

    ```rb
    class UpdatePreorderGroup < ActiveInteraction::Base
    ```

  * **Line # 25 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<0, 19, 5> 19.65/17]

    ```rb
      def execute ...
    ```

  * **Line # 40 - convention:** Metrics/AbcSize: Assignment Branch Condition size for update_group is too high. [<2, 24, 3> 24.27/17]

    ```rb
      def update_group ...
    ```

  * **Line # 40 - convention:** Metrics/MethodLength: Method has too many lines. [11/10]

    ```rb
      def update_group ...
    ```

  * **Line # 60 - convention:** Style/PreferredHashMethods: Use `Hash#key?` instead of `Hash#has_key?`.

    ```rb
        return [] unless params.has_key?(:dates)
    ```

  * **Line # 70 - convention:** Metrics/AbcSize: Assignment Branch Condition size for update_turns is too high. [<4, 17, 5> 18.17/17]

    ```rb
      def update_turns ...
    ```

  * **Line # 71 - convention:** Style/PreferredHashMethods: Use `Hash#key?` instead of `Hash#has_key?`.

    ```rb
        return true unless params.has_key?(:turns)
    ```

### app/interactions/valid_times_group_by_turn.rb - (2 offenses)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class ValidTimesGroupByTurn`.

    ```rb
    class ValidTimesGroupByTurn < ActiveInteraction::Base
    ```

  * **Line # 18 - convention:** Metrics/MethodLength: Method has too many lines. [11/10]

    ```rb
      def process_turn(turn) ...
    ```

### app/jobs/application_job.rb - (1 offense)
  * **Line # 1 - convention:** Style/FrozenStringLiteralComment: Missing frozen string literal comment.

    ```rb
    class ApplicationJob < ActiveJob::Base
    ```

### app/mailers/application_mailer.rb - (4 offenses)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class ApplicationMailer`.

    ```rb
    class ApplicationMailer < ActionMailer::Base
    ```

  * **Line # 12 - convention:** Style/MapToHash: Pass a block to `to_h` instead of calling `map.to_h`.

    ```rb
        @images = Image.where("key ILIKE 'email_images_%'").all.map do |image|
    ```

  * **Line # 29 - convention:** Layout/LineLength: Line is too long. [141/120]

    ```rb
        delivered_email = params[:delivered_email] || Log::DeliveredEmail.find_by(id: params[:delivered_email_id]) || Log::DeliveredEmail.create!
    ```

  * **Line # 38 - convention:** Style/MapToHash: Pass a block to `to_h` instead of calling `map.to_h`.

    ```rb
            headers: mail.header.fields.map { |field| [field.name, field.value] }.to_h,
    ```

### app/mailers/reservation_mailer.rb - (1 offense)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class ReservationMailer`.

    ```rb
    class ReservationMailer < ApplicationMailer
    ```

### app/mailers/user_mailer.rb - (1 offense)
  * **Line # 50 - convention:** Metrics/AbcSize: Assignment Branch Condition size for set_user is too high. [<2, 17, 5> 17.83/17]

    ```rb
      def set_user ...
    ```

### app/models/application_record.rb - (2 offenses)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class ApplicationRecord`.

    ```rb
    class ApplicationRecord < ActiveRecord::Base
    ```

  * **Line # 8 - convention:** Rails/Output: Do not write to stdout. Use Rails's logger if you want to log.

    ```rb
          puts Dev::TableInfo.run!(args.merge(model: self))
    ```

### app/models/concerns/has_image_attached.rb - (1 offense)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `module HasImageAttached`.

    ```rb
    module HasImageAttached
    ```

### app/models/concerns/has_images_attached.rb - (2 offenses)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `module HasImagesAttached`.

    ```rb
    module HasImagesAttached
    ```

  * **Line # 7 - convention:** Rails/InverseOf: Specify an `:inverse_of` option.

    ```rb
        has_many :image_to_records, -> { order(:position) }, class_name: "ImageToRecord", as: :record, dependent: :destroy
    ```

### app/models/concerns/track_model_changes.rb - (1 offense)
  * **Line # 68 - convention:** Style/GlobalVars: Do not introduce global variables.

    ```rb
          user_id: $current_user_id,
    ```

### app/models/contact/DEFAULTS.rb - (1 offense)
  * **Line # 1 - convention:** Naming/FileName: The name of this source file (`DEFAULTS.rb`) should use snake_case.

    ```rb
    # frozen_string_literal: true
    ```

### app/models/contact/key_value_validator.rb - (6 offenses)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class Contact::KeyValueValidator`.

    ```rb
      class KeyValueValidator < ActiveModel::Validator
    ```

  * **Line # 7 - convention:** Metrics/AbcSize: Assignment Branch Condition size for validate is too high. [<1, 16, 9> 18.38/17]

    ```rb
        def validate(record) ...
    ```

  * **Line # 7 - convention:** Metrics/CyclomaticComplexity: Cyclomatic complexity for validate is too high. [10/7]

    ```rb
        def validate(record) ...
    ```

  * **Line # 7 - convention:** Metrics/MethodLength: Method has too many lines. [14/10]

    ```rb
        def validate(record) ...
    ```

  * **Line # 14 - warning:** Lint/DuplicateBranch: Duplicate branch body detected.

    ```rb
          when :whatsapp_number then validate_phone
    ```

  * **Line # 27 - convention:** Metrics/AbcSize: Assignment Branch Condition size for can_run? is too high. [<0, 18, 3> 18.25/17]

    ```rb
        def can_run? ...
    ```

### app/models/holiday.rb - (2 offenses)
  * **Line # 17 - convention:** Layout/LineLength: Line is too long. [127/120]

    ```rb
    # So, if one of `weekly_from`, `weekly_to` and `weekday` is specified, all are required. If none is specified, they can be nil.
    ```

  * **Line # 56 - convention:** Layout/LineLength: Line is too long. [136/120]

    ```rb
          base.where("weekly_from <= :hour AND weekly_to >= :hour AND weekday = :weekday", hour: time.strftime("%k:%M"), weekday: time.wday)
    ```

### app/models/image.rb - (8 offenses)
  * **Line # 3 - convention:** Metrics/ClassLength: Class has too many lines. [112/100]

    ```rb
    class Image < ApplicationRecord ...
    ```

  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class Image`.

    ```rb
    class Image < ApplicationRecord
    ```

  * **Line # 17 - convention:** Style/MapToHash: Pass a block to `to_h` instead of calling `map.to_h`.

    ```rb
      enum status: VALID_STATUSES.map { |s| [s, s] }.to_h
    ```

  * **Line # 18 - convention:** Style/MapToHash: Pass a block to `to_h` instead of calling `map.to_h`.

    ```rb
      enum tag: VALID_TAGS.map { |t| [t, t] }.to_h
    ```

  * **Line # 26 - convention:** Rails/InverseOf: Specify an `:inverse_of` option.

    ```rb
      has_many :children, class_name: "Image", foreign_key: :original_id, dependent: :destroy
    ```

  * **Line # 53 - convention:** Metrics/AbcSize: Assignment Branch Condition size for create_from_url is too high. [<3, 19, 3> 19.47/17]

    ```rb
        def create_from_url(data) ...
    ```

  * **Line # 134 - convention:** Naming/PredicateName: Rename `has_original?` to `original?`.

    ```rb
      def has_original?
    ```

  * **Line # 160 - convention:** Naming/PredicateName: Rename `is_original?` to `original?`.

    ```rb
      def is_original?
    ```

### app/models/image_to_record.rb - (4 offenses)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class ImageToRecord`.

    ```rb
    class ImageToRecord < ApplicationRecord
    ```

  * **Line # 27 - convention:** Metrics/AbcSize: Assignment Branch Condition size for move is too high. [<7, 22, 7> 24.12/17]

    ```rb
        def move(record, from_index, to_index) ...
    ```

  * **Line # 27 - convention:** Metrics/MethodLength: Method has too many lines. [12/10]

    ```rb
        def move(record, from_index, to_index) ...
    ```

  * **Line # 33 - convention:** Rails/SkipsModelValidations: Avoid using `update_all` because it skips validations.

    ```rb
            where(record:).update_all("position = position + 100000")
    ```

### app/models/log.rb - (1 offense)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `module Log`.

    ```rb
    module Log
    ```

### app/models/log/delivered_email.rb - (2 offenses)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class Log::DeliveredEmail`.

    ```rb
      class DeliveredEmail < ApplicationRecord
    ```

  * **Line # 8 - convention:** Rails/HasManyOrHasOneDependent: Specify a `:dependent` option.

    ```rb
        has_many :image_pixels, class_name: "Log::ImagePixel"
    ```

### app/models/log/image_pixel.rb - (1 offense)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class Log::ImagePixel`.

    ```rb
      class ImagePixel < ApplicationRecord
    ```

### app/models/log/image_pixel_event.rb - (1 offense)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class Log::ImagePixelEvent`.

    ```rb
      class ImagePixelEvent < ApplicationRecord
    ```

### app/models/log/model_change.rb - (6 offenses)
  * **Line # 27 - convention:** Rails/UniqueValidationWithoutIndex: Uniqueness validation should have a unique index on the database column.

    ```rb
        validates :version, uniqueness: { scope: %i[record_id record_type] }
    ```

  * **Line # 85 - convention:** Style/GlobalVars: Do not introduce global variables.

    ```rb
              user: args[:user] || $current_user
    ```

  * **Line # 90 - convention:** Style/GlobalVars: Do not introduce global variables.

    ```rb
            old_current_user_id = $current_user_id
    ```

  * **Line # 91 - convention:** Style/GlobalVars: Do not introduce global variables.

    ```rb
            $current_user_id = user.id
    ```

  * **Line # 94 - convention:** Style/GlobalVars: Do not introduce global variables.

    ```rb
            $current_user_id = old_current_user_id
    ```

  * **Line # 153 - convention:** Rails/Blank: Use `changed_fields.blank?` instead of `changed_fields.nil? || changed_fields.empty?`.

    ```rb
          return if changed_fields.nil? || changed_fields.empty? || record.nil?
    ```

### app/models/menu.rb - (2 offenses)
  * **Line # 1 - convention:** Style/Documentation: Missing top-level documentation comment for `module Menu`.

    ```rb
    module Menu
    ```

  * **Line # 1 - convention:** Style/FrozenStringLiteralComment: Missing frozen string literal comment.

    ```rb
    module Menu
    ```

### app/models/menu/allergen.rb - (7 offenses)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class Menu::Allergen`.

    ```rb
      class Allergen < ApplicationRecord
    ```

  * **Line # 16 - convention:** Style/MapToHash: Pass a block to `to_h` instead of calling `map.to_h`.

    ```rb
        enum status: VALID_STATUSES.map { |s| [s, s] }.to_h
    ```

  * **Line # 21 - convention:** Rails/InverseOf: Specify an `:inverse_of` option.

    ```rb
        has_many :menu_allergens_in_dishes, class_name: "Menu::AllergensInDish", foreign_key: :menu_allergen_id,
    ```

  * **Line # 47 - convention:** Rails/Blank: Use `if query.blank?` instead of `unless query.present?`.

    ```rb
            return all unless query.present?
    ```

  * **Line # 53 - convention:** Rails/Blank: Use `if query.blank?` instead of `unless query.present?`.

    ```rb
            return all unless query.present?
    ```

  * **Line # 59 - convention:** Rails/Blank: Use `if query.blank?` instead of `unless query.present?`.

    ```rb
            return all unless query.present?
    ```

  * **Line # 65 - convention:** Layout/LineLength: Line is too long. [141/120]

    ```rb
            items = Menu::Allergen.where(id: Menu::AllergensInDish.where(menu_dish_id: dish_id).order(:index).select(:menu_allergen_id).limit(1))
    ```

### app/models/menu/allergens_in_dish.rb - (1 offense)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class Menu::AllergensInDish`.

    ```rb
      class AllergensInDish < ApplicationRecord
    ```

### app/models/menu/category.rb - (15 offenses)
  * **Line # 4 - convention:** Metrics/ClassLength: Class has too many lines. [190/100]

    ```rb
      class Category < ApplicationRecord ...
    ```

  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class Menu::Category`.

    ```rb
      class Category < ApplicationRecord
    ```

  * **Line # 17 - convention:** Style/MapToHash: Pass a block to `to_h` instead of calling `map.to_h`.

    ```rb
        enum status: VALID_STATUSES.map { |s| [s, s] }.to_h
    ```

  * **Line # 28 - convention:** Rails/HasManyOrHasOneDependent: Specify a `:dependent` option.

    ```rb
        has_many :children, class_name: "Menu::Category", foreign_key: :parent_id # , dependent: :destroy
    ```

  * **Line # 28 - convention:** Rails/InverseOf: Specify an `:inverse_of` option.

    ```rb
        has_many :children, class_name: "Menu::Category", foreign_key: :parent_id # , dependent: :destroy
    ```

  * **Line # 30 - convention:** Rails/HasManyOrHasOneDependent: Specify a `:dependent` option.

    ```rb
        has_many :menu_dishes_in_categories, class_name: "Menu::DishesInCategory", foreign_key: :menu_category_id
    ```

  * **Line # 30 - convention:** Rails/InverseOf: Specify an `:inverse_of` option.

    ```rb
        has_many :menu_dishes_in_categories, class_name: "Menu::DishesInCategory", foreign_key: :menu_category_id
    ```

  * **Line # 40 - convention:** Rails/UniqueValidationWithoutIndex: Uniqueness validation should have a unique index on the database column.

    ```rb
        validates :secret, presence: true, length: { minimum: SECRET_MIN_LENGTH }, uniqueness: { case_sensitive: false }, ...
    ```

  * **Line # 114 - convention:** Rails/Blank: Use `if query.blank?` instead of `unless query.present?`.

    ```rb
            return all unless query.present?
    ```

  * **Line # 116 - convention:** Layout/LineLength: Line is too long. [130/120]

    ```rb
            where(id: ransack(name_cont: query).result.select(:id)).or(where(id: ransack(description_cont: query).result.select(:id)))
    ```

  * **Line # 173 - convention:** Rails/Blank: Use `if Category.where(parent_id:, index:).blank?` instead of `unless Category.where(parent_id:, index:).present?`.

    ```rb
          return unless Category.where(parent_id:, index:).present?
    ```

  * **Line # 186 - convention:** Naming/PredicateName: Rename `has_children?` to `children?`.

    ```rb
        def has_children?
    ```

  * **Line # 196 - convention:** Metrics/AbcSize: Assignment Branch Condition size for move is too high. [<8, 36, 11> 38.48/17]

    ```rb
        def move(to_index) ...
    ```

  * **Line # 196 - convention:** Metrics/MethodLength: Method has too many lines. [14/10]

    ```rb
        def move(to_index) ...
    ```

  * **Line # 204 - convention:** Rails/SkipsModelValidations: Avoid using `update_all` because it skips validations.

    ```rb
            self.class.where(parent_id:).update_all("index = index + 100000")
    ```

### app/models/menu/dish.rb - (24 offenses)
  * **Line # 4 - convention:** Metrics/ClassLength: Class has too many lines. [126/100]

    ```rb
      class Dish < ApplicationRecord ...
    ```

  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class Menu::Dish`.

    ```rb
      class Dish < ApplicationRecord
    ```

  * **Line # 16 - convention:** Style/MapToHash: Pass a block to `to_h` instead of calling `map.to_h`.

    ```rb
        enum status: VALID_STATUSES.map { |s| [s, s] }.to_h
    ```

  * **Line # 21 - convention:** Rails/InverseOf: Specify an `:inverse_of` option.

    ```rb
        has_many :menu_dishes_in_categories, class_name: "Menu::DishesInCategory", foreign_key: :menu_dish_id,
    ```

  * **Line # 24 - convention:** Rails/InverseOf: Specify an `:inverse_of` option.

    ```rb
        has_many :menu_ingredients_in_dishes, class_name: "Menu::IngredientsInDish", foreign_key: :menu_dish_id,
    ```

  * **Line # 28 - convention:** Rails/InverseOf: Specify an `:inverse_of` option.

    ```rb
        has_many :menu_allergens_in_dishes, class_name: "Menu::AllergensInDish", foreign_key: :menu_dish_id,
    ```

  * **Line # 32 - convention:** Rails/InverseOf: Specify an `:inverse_of` option.

    ```rb
        has_many :menu_tags_in_dishes, class_name: "Menu::TagsInDish", foreign_key: :menu_dish_id, dependent: :destroy
    ```

  * **Line # 65 - convention:** Rails/Blank: Use `if query.blank?` instead of `unless query.present?`.

    ```rb
            return all unless query.present?
    ```

  * **Line # 71 - convention:** Rails/Blank: Use `if query.blank?` instead of `unless query.present?`.

    ```rb
            return all unless query.present?
    ```

  * **Line # 77 - convention:** Rails/Blank: Use `if query.blank?` instead of `unless query.present?`.

    ```rb
            return all unless query.present?
    ```

  * **Line # 83 - convention:** Layout/LineLength: Line is too long. [142/120]

    ```rb
            items = Menu::Dish.where(id: Menu::DishesInCategory.where(menu_category_id: category_id).order(:index).select(:menu_dish_id).limit(1))
    ```

  * **Line # 89 - convention:** Metrics/AbcSize: Assignment Branch Condition size for public_json is too high. [<2, 16, 9> 18.47/17]

    ```rb
          def public_json(options = {}) ...
    ```

  * **Line # 89 - convention:** Metrics/CyclomaticComplexity: Cyclomatic complexity for public_json is too high. [10/7]

    ```rb
          def public_json(options = {}) ...
    ```

  * **Line # 89 - convention:** Metrics/MethodLength: Method has too many lines. [15/10]

    ```rb
          def public_json(options = {}) ...
    ```

  * **Line # 89 - convention:** Metrics/PerceivedComplexity: Perceived complexity for public_json is too high. [10/8]

    ```rb
          def public_json(options = {}) ...
    ```

  * **Line # 154 - convention:** Metrics/AbcSize: Assignment Branch Condition size for public_json is too high. [<10, 33, 13> 36.85/17]

    ```rb
        def public_json(options = {}) ...
    ```

  * **Line # 154 - convention:** Metrics/CyclomaticComplexity: Cyclomatic complexity for public_json is too high. [14/7]

    ```rb
        def public_json(options = {}) ...
    ```

  * **Line # 154 - convention:** Metrics/MethodLength: Method has too many lines. [17/10]

    ```rb
        def public_json(options = {}) ...
    ```

  * **Line # 154 - convention:** Metrics/PerceivedComplexity: Perceived complexity for public_json is too high. [14/8]

    ```rb
        def public_json(options = {}) ...
    ```

  * **Line # 157 - convention:** Style/SymbolProc: Pass `&:public_json` as an argument to `map` instead of a block.

    ```rb
            optional_data[:ingredients] = ingredients.map { |ingredient| ingredient.public_json }
    ```

  * **Line # 160 - convention:** Style/SymbolProc: Pass `&:public_json` as an argument to `map` instead of a block.

    ```rb
          optional_data[:tags] = tags.map { |tag| tag.public_json } if options[:include_tags] || options[:include_all]
    ```

  * **Line # 163 - convention:** Style/SymbolProc: Pass `&:public_json` as an argument to `map` instead of a block.

    ```rb
            optional_data[:allergens] = allergens.map { |allergen| allergen.public_json }
    ```

  * **Line # 167 - convention:** Style/SymbolProc: Pass `&:public_json` as an argument to `map` instead of a block.

    ```rb
            optional_data[:suggestions] = suggestions.map { |suggestion| suggestion.public_json }
    ```

  * **Line # 173 - convention:** Style/SymbolProc: Pass `&:public_json` as an argument to `map` instead of a block.

    ```rb
            images: images.map { |image| image.public_json },
    ```

### app/models/menu/ingredient.rb - (7 offenses)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class Menu::Ingredient`.

    ```rb
      class Ingredient < ApplicationRecord
    ```

  * **Line # 16 - convention:** Style/MapToHash: Pass a block to `to_h` instead of calling `map.to_h`.

    ```rb
        enum status: VALID_STATUSES.map { |s| [s, s] }.to_h
    ```

  * **Line # 21 - convention:** Rails/InverseOf: Specify an `:inverse_of` option.

    ```rb
        has_many :menu_ingredients_in_dishes, class_name: "Menu::IngredientsInDish", foreign_key: :menu_ingredient_id,
    ```

  * **Line # 47 - convention:** Rails/Blank: Use `if query.blank?` instead of `unless query.present?`.

    ```rb
            return all unless query.present?
    ```

  * **Line # 53 - convention:** Rails/Blank: Use `if query.blank?` instead of `unless query.present?`.

    ```rb
            return all unless query.present?
    ```

  * **Line # 59 - convention:** Rails/Blank: Use `if query.blank?` instead of `unless query.present?`.

    ```rb
            return all unless query.present?
    ```

  * **Line # 65 - convention:** Layout/LineLength: Line is too long. [147/120]

    ```rb
            items = Menu::Ingredient.where(id: Menu::IngredientsInDish.where(menu_dish_id: dish_id).order(:index).select(:menu_ingredient_id).limit(1))
    ```

### app/models/menu/ingredients_in_dish.rb - (1 offense)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class Menu::IngredientsInDish`.

    ```rb
      class IngredientsInDish < ApplicationRecord
    ```

### app/models/menu/tag.rb - (7 offenses)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class Menu::Tag`.

    ```rb
      class Tag < ApplicationRecord
    ```

  * **Line # 17 - convention:** Style/MapToHash: Pass a block to `to_h` instead of calling `map.to_h`.

    ```rb
        enum status: VALID_STATUSES.map { |s| [s, s] }.to_h
    ```

  * **Line # 22 - convention:** Rails/InverseOf: Specify an `:inverse_of` option.

    ```rb
        has_many :menu_tags_in_dishes, class_name: "Menu::TagsInDish", foreign_key: :menu_tag_id, dependent: :destroy
    ```

  * **Line # 49 - convention:** Rails/Blank: Use `if query.blank?` instead of `unless query.present?`.

    ```rb
            return all unless query.present?
    ```

  * **Line # 55 - convention:** Rails/Blank: Use `if query.blank?` instead of `unless query.present?`.

    ```rb
            return all unless query.present?
    ```

  * **Line # 61 - convention:** Rails/Blank: Use `if query.blank?` instead of `unless query.present?`.

    ```rb
            return all unless query.present?
    ```

  * **Line # 67 - convention:** Layout/LineLength: Line is too long. [126/120]

    ```rb
            items = Menu::Tag.where(id: Menu::TagsInDish.where(menu_dish_id: dish_id).order(:index).select(:menu_tag_id).limit(1))
    ```

### app/models/menu/tags_in_dish.rb - (1 offense)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class Menu::TagsInDish`.

    ```rb
      class TagsInDish < ApplicationRecord
    ```

### app/models/menu/visibility.rb - (3 offenses)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class Menu::Visibility`.

    ```rb
      class Visibility < ApplicationRecord
    ```

  * **Line # 39 - convention:** Metrics/AbcSize: Assignment Branch Condition size for public_from_should_be_before_public_to is too high. [<0, 18, 4> 18.44/17]

    ```rb
        def public_from_should_be_before_public_to ...
    ```

  * **Line # 50 - convention:** Metrics/AbcSize: Assignment Branch Condition size for private_from_should_be_before_private_to is too high. [<0, 18, 4> 18.44/17]

    ```rb
        def private_from_should_be_before_private_to ...
    ```

### app/models/nexi.rb - (1 offense)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `module Nexi`.

    ```rb
    module Nexi
    ```

### app/models/preference/DEFAULTS.rb - (1 offense)
  * **Line # 1 - convention:** Naming/FileName: The name of this source file (`DEFAULTS.rb`) should use snake_case.

    ```rb
    # frozen_string_literal: true
    ```

### app/models/preference/key_value_validator.rb - (3 offenses)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class Preference::KeyValueValidator`.

    ```rb
      class KeyValueValidator < ActiveModel::Validator
    ```

  * **Line # 22 - convention:** Metrics/AbcSize: Assignment Branch Condition size for can_run? is too high. [<0, 18, 3> 18.25/17]

    ```rb
        def can_run? ...
    ```

  * **Line # 41 - convention:** Performance/MapMethodChain: Use `map { |x| x.strip.to_sym }` instead of `map` method chain.

    ```rb
          array = record.value.to_s.split(",").map(&:strip).map(&:to_sym)
    ```

### app/models/preorder_reservation_group.rb - (5 offenses)
  * **Line # 8 - convention:** Layout/LineLength: Line is too long. [129/120]

    ```rb
      # From active_from to active_to time window, theese settings will be applied. Outside of this window, they will not be applied.
    ```

  * **Line # 14 - convention:** Layout/LineLength: Line is too long. [152/120]

    ```rb
      # - If a turn is associated to a group, cannot create dates with the same turn. In this way you can specify multiple dates for turns that you want to.
    ```

  * **Line # 45 - convention:** Layout/LineLength: Line is too long. [133/120]

    ```rb
                                                                      PAYMENT_VALUE_MANDATORY_PREORDER_TYPES.include?(preorder_type.to_s)
    ```

  * **Line # 62 - convention:** Rails/InverseOf: Specify an `:inverse_of` option.

    ```rb
      has_many :dates, class_name: "PreorderReservationDate", foreign_key: :group_id, dependent: :destroy
    ```

  * **Line # 68 - convention:** Layout/LineLength: Line is too long. [151/120]

    ```rb
                           active.where("active_from IS NULL or active_from < ?", Time.zone.now).where("active_to IS NULL or active_to > ?", Time.zone.now)
    ```

### app/models/refresh_token.rb - (2 offenses)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class RefreshToken`.

    ```rb
    class RefreshToken < ApplicationRecord
    ```

  * **Line # 17 - convention:** Rails/UniqueValidationWithoutIndex: Uniqueness validation should have a unique index on the database column.

    ```rb
      validates :secret, presence: true, uniqueness: true
    ```

### app/models/reservation.rb - (4 offenses)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class Reservation`.

    ```rb
    class Reservation < ApplicationRecord
    ```

  * **Line # 35 - convention:** Rails/HasManyOrHasOneDependent: Specify a `:dependent` option.

    ```rb
      has_many :delivered_emails, class_name: "Log::DeliveredEmail", as: :record
    ```

  * **Line # 38 - convention:** Rails/HasManyOrHasOneDependent: Specify a `:dependent` option.

    ```rb
      has_one :payment, class_name: "ReservationPayment"
    ```

  * **Line # 56 - convention:** Rails/UniqueValidationWithoutIndex: Uniqueness validation should have a unique index on the database column.

    ```rb
      validates :secret, uniqueness: { case_sensitive: false }
    ```

### app/models/reservation_tag.rb - (1 offense)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class ReservationTag`.

    ```rb
    class ReservationTag < ApplicationRecord
    ```

### app/models/reservation_turn.rb - (9 offenses)
  * **Line # 62 - convention:** Metrics/MethodLength: Method has too many lines. [12/10]

    ```rb
      def preorder_reservation_groups ...
    ```

  * **Line # 101 - convention:** Metrics/AbcSize: Assignment Branch Condition size for starts_at_overlaps_other_turn is too high. [<2, 17, 4> 17.58/17]

    ```rb
      def starts_at_overlaps_other_turn ...
    ```

  * **Line # 111 - convention:** Metrics/AbcSize: Assignment Branch Condition size for ends_at_overlaps_other_turn is too high. [<2, 17, 4> 17.58/17]

    ```rb
      def ends_at_overlaps_other_turn ...
    ```

  * **Line # 121 - convention:** Metrics/AbcSize: Assignment Branch Condition size for other_starts_at_overlaps is too high. [<2, 23, 5> 23.62/17]

    ```rb
      def other_starts_at_overlaps ...
    ```

  * **Line # 132 - convention:** Metrics/AbcSize: Assignment Branch Condition size for other_ends_at_overlaps is too high. [<2, 23, 5> 23.62/17]

    ```rb
      def other_ends_at_overlaps ...
    ```

  * **Line # 148 - convention:** Layout/LineLength: Line is too long. [179/120]

    ```rb
      #   overlapping = self.class.where('? BETWEEN starts_at AND ends_at', starts_at).where(weekday:).or(self.class.where(weekday:).where('? BETWEEN starts_at AND ends_at', ends_at))
    ```

  * **Line # 153 - convention:** Layout/LineLength: Line is too long. [156/120]

    ```rb
      #     but #{overlapping.map { |ot| "turn ##{ot.id} starts at #{ot.starts_at.strftime('%k:%M')} and ends at #{ot.ends_at.strftime('%k:%M')}" }.join(", ") }
    ```

  * **Line # 156 - convention:** Layout/LineLength: Line is too long. [134/120]

    ```rb
      #   errors.add(:starts_at, 'should not overlap with other turns' + full_message, overlapping: overlapping.pluck(:id), full_message:)
    ```

  * **Line # 157 - convention:** Layout/LineLength: Line is too long. [132/120]

    ```rb
      #   errors.add(:ends_at, 'should not overlap with other turns' + full_message, overlapping: overlapping.pluck(:id), full_message:)
    ```

### app/models/reservation_turn_to_message.rb - (1 offense)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class ReservationTurnToMessage`.

    ```rb
    class ReservationTurnToMessage < ApplicationRecord
    ```

### app/models/setting.rb - (1 offense)
  * **Line # 70 - convention:** Rails/Output: Do not write to stdout. Use Rails's logger if you want to log.

    ```rb
        puts msg
    ```

### app/models/setting/DEFAULTS.rb - (1 offense)
  * **Line # 1 - convention:** Naming/FileName: The name of this source file (`DEFAULTS.rb`) should use snake_case.

    ```rb
    # frozen_string_literal: true
    ```

### app/models/setting/key_value_validator.rb - (9 offenses)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class Setting::KeyValueValidator`.

    ```rb
      class KeyValueValidator < ActiveModel::Validator
    ```

  * **Line # 7 - convention:** Metrics/AbcSize: Assignment Branch Condition size for validate is too high. [<1, 18, 11> 21.12/17]

    ```rb
        def validate(record) ...
    ```

  * **Line # 7 - convention:** Metrics/CyclomaticComplexity: Cyclomatic complexity for validate is too high. [12/7]

    ```rb
        def validate(record) ...
    ```

  * **Line # 7 - convention:** Metrics/MethodLength: Method has too many lines. [16/10]

    ```rb
        def validate(record) ...
    ```

  * **Line # 35 - convention:** Metrics/AbcSize: Assignment Branch Condition size for can_run? is too high. [<0, 18, 3> 18.25/17]

    ```rb
        def can_run? ...
    ```

  * **Line # 72 - convention:** Layout/LineLength: Line is too long. [121/120]

    ```rb
                            "reservation_min_hours_advance_cancel should be a positive integer, got #{record.value.inspect}")
    ```

  * **Line # 75 - convention:** Metrics/AbcSize: Assignment Branch Condition size for validate_email_images is too high. [<1, 19, 4> 19.44/17]

    ```rb
        def validate_email_images ...
    ```

  * **Line # 120 - convention:** Metrics/AbcSize: Assignment Branch Condition size for validate_instagram_landing_page_url is too high. [<0, 22, 5> 22.56/17]

    ```rb
        def validate_instagram_landing_page_url ...
    ```

  * **Line # 128 - convention:** Layout/LineLength: Line is too long. [121/120]

    ```rb
                            "should be an instagram url, like 'https://www.instagram.com/....', got #{record.value.inspect}")
    ```

### app/models/tag_in_reservation.rb - (1 offense)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class TagInReservation`.

    ```rb
    class TagInReservation < ApplicationRecord
    ```

### app/models/user.rb - (2 offenses)
  * **Line # 22 - convention:** Layout/LineLength: Line is too long. [143/120]

    ```rb
      validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: I18n.t("activerecord.errors.messages.not_a_valid_email") },
    ```

  * **Line # 103 - convention:** Rails/TimeZone: Do not use `Time.now` without zone. Use one of `Time.zone.now`, `Time.current`, `Time.now.in_time_zone`, `Time.now.utc`, `Time.now.getlocal`, `Time.now.xmlschema`, `Time.now.iso8601`, `Time.now.jisx0301`, `Time.now.rfc3339`, `Time.now.httpdate`, `Time.now.to_i`, `Time.now.to_f` instead.

    ```rb
        update!(locked_at: Time.now)
    ```

### config.ru - (1 offense)
  * **Line # 1 - convention:** Style/FrozenStringLiteralComment: Missing frozen string literal comment.

    ```rb
    # This file is used by Rack-based servers to start the application.
    ```

### config/application.rb - (2 offenses)
  * **Line # 1 - convention:** Style/FrozenStringLiteralComment: Missing frozen string literal comment.

    ```rb
    require_relative "boot"
    ```

  * **Line # 10 - convention:** Style/Documentation: Missing top-level documentation comment for `class Lpda2::Application`.

    ```rb
      class Application < Rails::Application
    ```

### config/boot.rb - (1 offense)
  * **Line # 1 - convention:** Style/FrozenStringLiteralComment: Missing frozen string literal comment.

    ```rb
    ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)
    ```

### config/environment.rb - (1 offense)
  * **Line # 1 - convention:** Style/FrozenStringLiteralComment: Missing frozen string literal comment.

    ```rb
    # Load the Rails application.
    ```

### config/environments/development.rb - (1 offense)
  * **Line # 1 - convention:** Style/FrozenStringLiteralComment: Missing frozen string literal comment.

    ```rb
    require "active_support/core_ext/integer/time"
    ```

### config/environments/production.rb - (2 offenses)
  * **Line # 1 - convention:** Style/FrozenStringLiteralComment: Missing frozen string literal comment.

    ```rb
    require "active_support/core_ext/integer/time"
    ```

  * **Line # 79 - convention:** Style/GlobalStdStream: Use `$stdout` instead of `STDOUT`.

    ```rb
        logger           = ActiveSupport::Logger.new(STDOUT)
    ```

### config/environments/test.rb - (1 offense)
  * **Line # 1 - convention:** Style/FrozenStringLiteralComment: Missing frozen string literal comment.

    ```rb
    require "active_support/core_ext/integer/time"
    ```

### config/initializers/active_model/errors.rb - (1 offense)
  * **Line # 7 - convention:** Style/MapToHash: Pass a block to `to_h` instead of calling `map.to_h`.

    ```rb
          result = errors.map { |er| [er.attribute, []] }.to_h
    ```

### config/initializers/cors.rb - (1 offense)
  * **Line # 1 - convention:** Style/FrozenStringLiteralComment: Missing frozen string literal comment.

    ```rb
    # Be sure to restart your server when you modify this file.
    ```

### config/initializers/exception_notification.rb - (2 offenses)
  * **Line # 6 - convention:** Style/SingleArgumentDig: Use `Config.app[:exceptions_recipients]` instead of `Config.app.dig(:exceptions_recipients)`.

    ```rb
    recipients     = Config.app.dig(:exceptions_recipients) || []
    ```

  * **Line # 16 - convention:** Layout/LineLength: Line is too long. [157/120]

    ```rb
      # ActiveRecord::RecordNotFound, Mongoid::Errors::DocumentNotFound, AbstractController::ActionNotFound and ActionController::RoutingError are already added.
    ```

### config/initializers/filter_parameter_logging.rb - (1 offense)
  * **Line # 1 - convention:** Style/FrozenStringLiteralComment: Missing frozen string literal comment.

    ```rb
    # Be sure to restart your server when you modify this file.
    ```

### config/initializers/hash.rb - (2 offenses)
  * **Line # 1 - convention:** Style/Documentation: Missing top-level documentation comment for `class Hash`.

    ```rb
    class Hash
    ```

  * **Line # 1 - convention:** Style/FrozenStringLiteralComment: Missing frozen string literal comment.

    ```rb
    class Hash
    ```

### config/initializers/health_check.rb - (4 offenses)
  * **Line # 45 - convention:** Layout/LineLength: Line is too long. [121/120]

    ```rb
      # config.full_checks = ['database', 'migrations', 'custom', 'email', 'cache', 'redis', 'resque-redis', 'sidekiq-redis']
    ```

  * **Line # 71 - convention:** Layout/LineLength: Line is too long. [123/120]

    ```rb
      # Whitelist requesting IPs by a list of IP and/or CIDR ranges, either IPv4 or IPv6 (uses IPAddr.include? method to check)
    ```

  * **Line # 75 - convention:** Layout/LineLength: Line is too long. [130/120]

    ```rb
      # Use ActionDispatch::Request's remote_ip method when behind a proxy to pick up the real remote IP for origin_ip_whitelist check
    ```

  * **Line # 76 - convention:** Layout/LineLength: Line is too long. [128/120]

    ```rb
      # Otherwise uses Rack::Request's ip method (the default, and always used by Middleware), which is more susceptable to spoofing
    ```

### config/initializers/inflections.rb - (1 offense)
  * **Line # 1 - convention:** Style/FrozenStringLiteralComment: Missing frozen string literal comment.

    ```rb
    # Be sure to restart your server when you modify this file.
    ```

### config/initializers/mobility.rb - (1 offense)
  * **Line # 1 - convention:** Style/FrozenStringLiteralComment: Missing frozen string literal comment.

    ```rb
    Mobility.configure do
    ```

### config/initializers/required_configs_check.rb - (2 offenses)
  * **Line # 24 - convention:** Style/MultilineBlockChain: Avoid multi-line chains of blocks.

    ```rb
    end.join(", ").tap do |required_configs|
    ```

  * **Line # 25 - convention:** Rails/Blank: Use `if required_configs.blank?` instead of `unless required_configs.present?`.

    ```rb
      next unless required_configs.present?
    ```

### config/initializers/string.rb - (2 offenses)
  * **Line # 34 - convention:** Style/StringChars: Use `chars` instead of `split("")`.

    ```rb
        other.split("").inject(0) do |sum, char|
    ```

  * **Line # 41 - convention:** Naming/VariableNumber: Use normalcase for method name numbers.

    ```rb
      def lang_to_iso639_2
    ```

### config/puma.rb - (3 offenses)
  * **Line # 1 - convention:** Style/FrozenStringLiteralComment: Missing frozen string literal comment.

    ```rb
    # Puma can serve each request in a thread from an internal thread pool.
    ```

  * **Line # 7 - convention:** Style/RedundantFetchBlock: Use `fetch("RAILS_MAX_THREADS", 16)` instead of `fetch("RAILS_MAX_THREADS") { 16 }`.

    ```rb
    max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 16 }
    ```

  * **Line # 18 - convention:** Style/RedundantFetchBlock: Use `fetch("PORT", 3050)` instead of `fetch("PORT") { 3050 }`.

    ```rb
    port ENV.fetch("PORT") { 3050 }
    ```

### config/routes.rb - (5 offenses)
  * **Line # 6 - convention:** Metrics/BlockLength: Block has too many lines. [167/25]

    ```rb
    Rails.application.routes.draw do ...
    ```

  * **Line # 11 - convention:** Metrics/BlockLength: Block has too many lines. [159/25]

    ```rb
      defaults format: :json do ...
    ```

  * **Line # 20 - convention:** Metrics/BlockLength: Block has too many lines. [150/25]

    ```rb
        scope module: :v1, path: "v1" do ...
    ```

  * **Line # 89 - convention:** Metrics/BlockLength: Block has too many lines. [100/25]

    ```rb
          scope module: :admin, path: "admin" do ...
    ```

  * **Line # 141 - convention:** Metrics/BlockLength: Block has too many lines. [54/25]

    ```rb
            scope module: :menu, path: "menu" do ...
    ```

### db/migrate/002_create_settings.rb - (1 offense)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class CreateSettings`.

    ```rb
    class CreateSettings < ActiveRecord::Migration[7.0]
    ```

### db/migrate/003_create_preferences.rb - (1 offense)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class CreatePreferences`.

    ```rb
    class CreatePreferences < ActiveRecord::Migration[7.0]
    ```

### db/migrate/004_create_menu_visibilities.rb - (1 offense)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class CreateMenuVisibilities`.

    ```rb
    class CreateMenuVisibilities < ActiveRecord::Migration[7.0]
    ```

### db/migrate/005_create_menu_categories.rb - (2 offenses)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class CreateMenuCategories`.

    ```rb
    class CreateMenuCategories < ActiveRecord::Migration[7.0]
    ```

  * **Line # 13 - convention:** Layout/LineLength: Line is too long. [124/120]

    ```rb
                                  foreign_key: { to_table: :menu_categories, on_delete: :cascade }, class_name: "Menu::Category"
    ```

### db/migrate/006_create_menu_dishes.rb - (2 offenses)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class CreateMenuDishes`.

    ```rb
    class CreateMenuDishes < ActiveRecord::Migration[7.0]
    ```

  * **Line # 8 - convention:** Layout/LineLength: Line is too long. [155/120]

    ```rb
                             comment: %(The price of the dish. Can be null or 0 some cases, for example when the dish is inside a category with a fixed price.)
    ```

### db/migrate/007_create_menu_dishes_in_categories.rb - (1 offense)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class CreateMenuDishesInCategories`.

    ```rb
    class CreateMenuDishesInCategories < ActiveRecord::Migration[7.0]
    ```

### db/migrate/008_create_text_translations.rb - (2 offenses)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class CreateTextTranslations`.

    ```rb
    class CreateTextTranslations < ActiveRecord::Migration[7.0]
    ```

  * **Line # 14 - convention:** Layout/LineLength: Line is too long. [140/120]

    ```rb
                                                                                                 name: :index_mobility_text_translations_on_keys
    ```

### db/migrate/009_create_string_translations.rb - (2 offenses)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class CreateStringTranslations`.

    ```rb
    class CreateStringTranslations < ActiveRecord::Migration[7.0]
    ```

  * **Line # 14 - convention:** Layout/LineLength: Line is too long. [144/120]

    ```rb
                                                                                                   name: :index_mobility_string_translations_on_keys
    ```

### db/migrate/010_create_menu_ingredients.rb - (1 offense)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class CreateMenuIngredients`.

    ```rb
    class CreateMenuIngredients < ActiveRecord::Migration[7.0]
    ```

### db/migrate/011_create_menu_ingredients_in_dishes.rb - (1 offense)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class CreateMenuIngredientsInDishes`.

    ```rb
    class CreateMenuIngredientsInDishes < ActiveRecord::Migration[7.0]
    ```

### db/migrate/012_create_menu_tags.rb - (1 offense)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class CreateMenuTags`.

    ```rb
    class CreateMenuTags < ActiveRecord::Migration[7.0]
    ```

### db/migrate/013_create_menu_tags_in_dishes.rb - (1 offense)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class CreateMenuTagsInDishes`.

    ```rb
    class CreateMenuTagsInDishes < ActiveRecord::Migration[7.0]
    ```

### db/migrate/014_create_menu_allergens.rb - (1 offense)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class CreateMenuAllergens`.

    ```rb
    class CreateMenuAllergens < ActiveRecord::Migration[7.0]
    ```

### db/migrate/015_create_menu_allergens_in_dishes.rb - (2 offenses)
  * **Line # 1 - convention:** Style/Documentation: Missing top-level documentation comment for `class CreateMenuAllergensInDishes`.

    ```rb
    class CreateMenuAllergensInDishes < ActiveRecord::Migration[7.0]
    ```

  * **Line # 1 - convention:** Style/FrozenStringLiteralComment: Missing frozen string literal comment.

    ```rb
    class CreateMenuAllergensInDishes < ActiveRecord::Migration[7.0]
    ```

### db/migrate/016_create_active_storage_tables.active_storage.rb - (2 offenses)
  * **Line # 1 - convention:** Style/FrozenStringLiteralComment: Missing frozen string literal comment.

    ```rb
    # This migration comes from active_storage (originally 20170806125915)
    ```

  * **Line # 3 - convention:** Metrics/AbcSize: Assignment Branch Condition size for change is too high. [<5, 29, 4> 29.7/17]

    ```rb
      def change ...
    ```

### db/migrate/017_create_images.rb - (2 offenses)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class CreateImages`.

    ```rb
    class CreateImages < ActiveRecord::Migration[7.0]
    ```

  * **Line # 9 - convention:** Layout/LineLength: Line is too long. [136/120]

    ```rb
                                comment: %(Internal tag for image. A tag may be 'blur', 'thumbnail', ... May be nil when is original image.)
    ```

### db/migrate/018_create_image_to_records.rb - (1 offense)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class CreateImageToRecords`.

    ```rb
    class CreateImageToRecords < ActiveRecord::Migration[7.0]
    ```

### db/migrate/019_create_refresh_tokens.rb - (1 offense)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class CreateRefreshTokens`.

    ```rb
    class CreateRefreshTokens < ActiveRecord::Migration[7.0]
    ```

### db/migrate/021_create_reservation_turns.rb - (2 offenses)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class CreateReservationTurns`.

    ```rb
    class CreateReservationTurns < ActiveRecord::Migration[7.0]
    ```

  * **Line # 11 - convention:** Layout/LineLength: Line is too long. [130/120]

    ```rb
                                 comment: "minutes between one valid reservation time and the next one. Set to 1 to allow any minute."
    ```

### db/migrate/022_create_reservations.rb - (1 offense)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class CreateReservations`.

    ```rb
    class CreateReservations < ActiveRecord::Migration[7.0]
    ```

### db/migrate/023_create_reservation_tags.rb - (1 offense)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class CreateReservationTags`.

    ```rb
    class CreateReservationTags < ActiveRecord::Migration[7.0]
    ```

### db/migrate/024_create_tag_in_reservations.rb - (1 offense)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class CreateTagInReservations`.

    ```rb
    class CreateTagInReservations < ActiveRecord::Migration[7.0]
    ```

### db/migrate/025_create_log_delivered_emails.rb - (1 offense)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class CreateLogDeliveredEmails`.

    ```rb
    class CreateLogDeliveredEmails < ActiveRecord::Migration[7.0]
    ```

### db/migrate/026_create_log_image_pixels.rb - (1 offense)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class CreateLogImagePixels`.

    ```rb
    class CreateLogImagePixels < ActiveRecord::Migration[7.0]
    ```

### db/migrate/027_create_log_image_pixel_events.rb - (2 offenses)
  * **Line # 1 - convention:** Style/Documentation: Missing top-level documentation comment for `class CreateLogImagePixelEvents`.

    ```rb
    class CreateLogImagePixelEvents < ActiveRecord::Migration[7.0]
    ```

  * **Line # 1 - convention:** Style/FrozenStringLiteralComment: Missing frozen string literal comment.

    ```rb
    class CreateLogImagePixelEvents < ActiveRecord::Migration[7.0]
    ```

### db/migrate/028_create_menu_dish_suggestions.rb - (1 offense)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class CreateMenuDishSuggestions`.

    ```rb
    class CreateMenuDishSuggestions < ActiveRecord::Migration[7.0]
    ```

### db/migrate/029_create_reset_password_secrets.rb - (1 offense)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class CreateResetPasswordSecrets`.

    ```rb
    class CreateResetPasswordSecrets < ActiveRecord::Migration[7.0]
    ```

### db/migrate/030_create_public_messages.rb - (1 offense)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class CreatePublicMessages`.

    ```rb
    class CreatePublicMessages < ActiveRecord::Migration[7.0]
    ```

### db/migrate/032_create_preorder_reservation_groups.rb - (3 offenses)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class CreatePreorderReservationGroups`.

    ```rb
    class CreatePreorderReservationGroups < ActiveRecord::Migration[7.0]
    ```

  * **Line # 12 - convention:** Layout/LineLength: Line is too long. [163/120]

    ```rb
                                 comment: %(What should ask the user to do. Will include provider name. May be something like 'paypal_payment', or 'nexi_card_hold'...)
    ```

  * **Line # 14 - convention:** Layout/LineLength: Line is too long. [149/120]

    ```rb
                                  comment: %(How much should people be required to pay if it's a payment. Since may be card hold, this field can be nil.)
    ```

### db/migrate/033_create_preorder_reservation_dates.rb - (1 offense)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class CreatePreorderReservationDates`.

    ```rb
    class CreatePreorderReservationDates < ActiveRecord::Migration[7.0]
    ```

### db/migrate/034_create_reservation_payments.rb - (3 offenses)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class CreateReservationPayments`.

    ```rb
    class CreateReservationPayments < ActiveRecord::Migration[7.0]
    ```

  * **Line # 6 - convention:** Layout/LineLength: Line is too long. [152/120]

    ```rb
          # when - and if - you'll need to support different payment types from hpp_url, create a migration removing presence constraint, but create checks.
    ```

  * **Line # 13 - convention:** Layout/LineLength: Line is too long. [163/120]

    ```rb
                                 comment: %(What should ask the user to do. Will include provider name. May be something like 'paypal_payment', or 'nexi_card_hold'...)
    ```

### db/migrate/035_create_preorder_reservation_groups_to_turns.rb - (1 offense)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class CreatePreorderReservationGroupsToTurns`.

    ```rb
    class CreatePreorderReservationGroupsToTurns < ActiveRecord::Migration[7.0]
    ```

### db/migrate/20241009161438_add_lang_to_reservations.rb - (1 offense)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class AddLangToReservations`.

    ```rb
    class AddLangToReservations < ActiveRecord::Migration[7.0]
    ```

### db/migrate/20241020145928_create_holidays.rb - (1 offense)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class CreateHolidays`.

    ```rb
    class CreateHolidays < ActiveRecord::Migration[7.0]
    ```

### db/migrate/20241031152941_add_controller_path_and_action_name_to_log_delivered_emails.rb - (2 offenses)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class AddControllerPathAndActionNameToLogDeliveredEmails`.

    ```rb
    class AddControllerPathAndActionNameToLogDeliveredEmails < ActiveRecord::Migration[7.0]
    ```

  * **Line # 5 - convention:** Rails/BulkChangeTable: You can use `change_table :log_delivered_emails, bulk: true` to combine alter queries.

    ```rb
        add_column :log_delivered_emails, :controller_path, :text
    ```

### db/migrate/20241101135528_create_contacts.rb - (1 offense)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class CreateContacts`.

    ```rb
    class CreateContacts < ActiveRecord::Migration[7.0]
    ```

### db/migrate/20241103094436_remove_require_root_from_settings.rb - (1 offense)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class RemoveRequireRootFromSettings`.

    ```rb
    class RemoveRequireRootFromSettings < ActiveRecord::Migration[7.0]
    ```

### db/migrate/20241103100539_remove_require_root_from_preferences.rb - (1 offense)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class RemoveRequireRootFromPreferences`.

    ```rb
    class RemoveRequireRootFromPreferences < ActiveRecord::Migration[7.0]
    ```

### db/migrate/20241106202604_remove_not_null_constraint_from_nexi_http_requests.rb - (1 offense)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class RemoveNotNullConstraintFromNexiHttpRequests`.

    ```rb
    class RemoveNotNullConstraintFromNexiHttpRequests < ActiveRecord::Migration[7.0]
    ```

### db/migrate/20241106215259_add_html_response_to_nexi_http_requests.rb - (1 offense)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class AddHtmlResponseToNexiHttpRequests`.

    ```rb
    class AddHtmlResponseToNexiHttpRequests < ActiveRecord::Migration[7.0]
    ```

### db/migrate/20241106221052_add_html_to_reservation_payments.rb - (1 offense)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class AddHtmlToReservationPayments`.

    ```rb
    class AddHtmlToReservationPayments < ActiveRecord::Migration[7.0]
    ```

### db/migrate/20241106223642_add_external_id_to_reservation_payment.rb - (1 offense)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class AddExternalIdToReservationPayment`.

    ```rb
    class AddExternalIdToReservationPayment < ActiveRecord::Migration[7.0]
    ```

### db/migrate/20241107182952_add_redirect_urls_to_reservation_payment.rb - (2 offenses)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class AddRedirectUrlsToReservationPayment`.

    ```rb
    class AddRedirectUrlsToReservationPayment < ActiveRecord::Migration[7.0]
    ```

  * **Line # 5 - convention:** Rails/BulkChangeTable: You can use `change_table :reservation_payments, bulk: true` to combine alter queries.

    ```rb
        add_column :reservation_payments, :success_url, :text
    ```

### db/migrate/20241111143438_create_log_reservation_events.rb - (1 offense)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class CreateLogReservationEvents`.

    ```rb
    class CreateLogReservationEvents < ActiveRecord::Migration[7.0]
    ```

### db/migrate/20241111163423_create_nexi_order_outcome_requests.rb - (2 offenses)
  * **Line # 1 - convention:** Style/Documentation: Missing top-level documentation comment for `class CreateNexiOrderOutcomeRequests`.

    ```rb
    class CreateNexiOrderOutcomeRequests < ActiveRecord::Migration[7.0]
    ```

  * **Line # 1 - convention:** Style/FrozenStringLiteralComment: Missing frozen string literal comment.

    ```rb
    class CreateNexiOrderOutcomeRequests < ActiveRecord::Migration[7.0]
    ```

### db/migrate/20241112182756_add_root_id_to_menu_categories.rb - (1 offense)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class AddRootIdToMenuCategories`.

    ```rb
    class AddRootIdToMenuCategories < ActiveRecord::Migration[7.0]
    ```

### db/migrate/20241112183540_assign_root_to_menu_categories.rb - (3 offenses)
  * **Line # 1 - convention:** Style/Documentation: Missing top-level documentation comment for `class AssignRootToMenuCategories`.

    ```rb
    class AssignRootToMenuCategories < ActiveRecord::Migration[7.0]
    ```

  * **Line # 1 - convention:** Style/FrozenStringLiteralComment: Missing frozen string literal comment.

    ```rb
    class AssignRootToMenuCategories < ActiveRecord::Migration[7.0]
    ```

  * **Line # 10 - convention:** Rails/SkipsModelValidations: Avoid using `update_all` because it skips validations.

    ```rb
        Menu::Category.update_all(root_id: nil)
    ```

### db/migrate/20241202215307_create_reservation_turn_messages.rb - (3 offenses)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class CreateReservationTurnMessages`.

    ```rb
    class CreateReservationTurnMessages < ActiveRecord::Migration[7.0]
    ```

  * **Line # 7 - convention:** Layout/LineLength: Line is too long. [188/120]

    ```rb
                 comment: %(When user tries to reserve for the associated reservation turn after this date, the message will be shown. If date is nil, the message will be shown for all dates.)
    ```

  * **Line # 9 - convention:** Layout/LineLength: Line is too long. [272/120]

    ```rb
                 comment: %(When user tries to reserve for the associated reservation turn before this date, the message will be shown. If date is nil, the message will be shown for all dates. To set a message for exactly one date, set from_date and to_date to the same date.)
    ```

### db/migrate/20241203180109_create_reservation_turn_to_messages.rb - (1 offense)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class CreateReservationTurnToMessages`.

    ```rb
    class CreateReservationTurnToMessages < ActiveRecord::Migration[7.0]
    ```

### db/seeds.rb - (5 offenses)
  * **Line # 1 - convention:** Style/FrozenStringLiteralComment: Missing frozen string literal comment.

    ```rb
    def debug(message)
    ```

  * **Line # 3 - convention:** Rails/Output: Do not write to stdout. Use Rails's logger if you want to log.

    ```rb
      puts message
    ```

  * **Line # 107 - convention:** Performance/CollectionLiteralInLoop: Avoid immutable Array literals in loops. It is better to extract it into a local variable or a constant.

    ```rb
        Reservation.create!(adults: [2, 2, 2, 3, 4, 5, 6, 7, 8, 9, 10].sample, fullname: Faker::Name.first_name,
    ```

  * **Line # 108 - convention:** Performance/CollectionLiteralInLoop: Avoid immutable Array literals in loops. It is better to extract it into a local variable or a constant.

    ```rb
                            email: "sasha+#{SecureRandom.hex}@opinioni.net", datetime: day_ago.days.ago.beginning_of_day + [10, 11, 12, 18, 19, 20].sample.hours)
    ```

  * **Line # 108 - convention:** Layout/LineLength: Line is too long. [157/120]

    ```rb
                            email: "sasha+#{SecureRandom.hex}@opinioni.net", datetime: day_ago.days.ago.beginning_of_day + [10, 11, 12, 18, 19, 20].sample.hours)
    ```

### lib/sidekiq_admin_constraint.rb - (2 offenses)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class SidekiqAdminConstraint`.

    ```rb
    class SidekiqAdminConstraint
    ```

  * **Line # 5 - warning:** Lint/UselessAssignment: Useless assignment to variable - `cookies`.

    ```rb
        cookies = ActionDispatch::Cookies::CookieJar.build(request, request.cookies)
    ```

### lib/tasks/dbreboot.rake - (1 offense)
  * **Line # 5 - convention:** Rails/RakeEnvironment: Include `:environment` task as a dependency for all Rake tasks.

    ```rb
      task :reboot, [:seed] do |_, args|
    ```

### spec/contexts/controller_authentication_context.rb - (2 offenses)
  * **Line # 13 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
        @request.headers["Authorization"] = "Bearer #{Auth::JsonWebToken.encode_refresh_token_data(@refresh_token)}"
    ```

  * **Line # 13 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
        @request.headers["Authorization"] = "Bearer #{Auth::JsonWebToken.encode_refresh_token_data(@refresh_token)}"
    ```

### spec/contexts/controller_utils_context.rb - (7 offenses)
  * **Line # 18 - convention:** Metrics/AbcSize: Assignment Branch Condition size for find_error is too high. [<9, 20, 12> 25/17]

    ```rb
      def find_error(params = {}) ...
    ```

  * **Line # 18 - convention:** Metrics/CyclomaticComplexity: Cyclomatic complexity for find_error is too high. [11/7]

    ```rb
      def find_error(params = {}) ...
    ```

  * **Line # 18 - convention:** Metrics/PerceivedComplexity: Perceived complexity for find_error is too high. [11/8]

    ```rb
      def find_error(params = {}) ...
    ```

  * **Line # 22 - convention:** Performance/RedundantEqualityComparisonBlock: Use `all?(Hash)` instead of block.

    ```rb
        return errors if !errors.is_a?(Array) || !errors.all? { |e| e.is_a?(Hash) }
    ```

  * **Line # 51 - convention:** Metrics/CyclomaticComplexity: Cyclomatic complexity for errors is too high. [8/7]

    ```rb
      def errors(field = nil, params = {}) ...
    ```

  * **Line # 70 - convention:** Style/RedundantArgument: Argument " " is redundant because it is implied by default.

    ```rb
        "#{date.split(" ").first}T#{date.split(" ").last}:00.000Z"
    ```

  * **Line # 70 - convention:** Style/RedundantArgument: Argument " " is redundant because it is implied by default.

    ```rb
        "#{date.split(" ").first}T#{date.split(" ").last}:00.000Z"
    ```

### spec/contexts/request_authentication_context.rb - (1 offense)
  * **Line # 12 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
      let(:current_refresh_token) { @current_refresh_token || create(:refresh_token, user: current_user) }
    ```

### spec/controllers/v1/admin/menu/allergens_controller_spec.rb - (156 offenses)
  * **Line # 8 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
        expect(subject).to include(
    ```

  * **Line # 17 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to include(
    ```

  * **Line # 23 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to include(
    ```

  * **Line # 31 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to include(
    ```

  * **Line # 37 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to include(
    ```

  * **Line # 45 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject[:image]).to be_a(Hash)
    ```

  * **Line # 50 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to include(image: nil)
    ```

  * **Line # 55 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe V1::Admin::Menu::AllergensController, type: :controller do
    ```

  * **Line # 64 - convention:** Performance/TimesMap: Use `Array.new(count)` with a block instead of `.times.map` only if `count` is always 0 or more.

    ```rb
        items = count.times.map do |_i| ...
    ```

  * **Line # 123 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:items].size).to eq 10 }
    ```

  * **Line # 124 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:total_count]).to eq 30 }
    ```

  * **Line # 125 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:current_page]).to eq 1 }
    ```

  * **Line # 126 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:per_page]).to eq 10 }
    ```

  * **Line # 134 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:items].size).to eq 3 }
    ```

  * **Line # 135 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:total_count]).to eq 10 }
    ```

  * **Line # 136 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:current_page]).to eq 1 }
    ```

  * **Line # 137 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:per_page]).to eq 3 }
    ```

  * **Line # 145 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:items].size).to eq 3 }
    ```

  * **Line # 146 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:total_count]).to eq 10 }
    ```

  * **Line # 147 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:current_page]).to eq 2 }
    ```

  * **Line # 148 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:per_page]).to eq 3 }
    ```

  * **Line # 157 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              it { expect(@page1).to eq @offset0 }
    ```

  * **Line # 157 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              it { expect(@page1).to eq @offset0 }
    ```

  * **Line # 166 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:items].size).to eq 1 }
    ```

  * **Line # 167 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:total_count]).to eq 10 }
    ```

  * **Line # 168 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:current_page]).to eq 4 }
    ```

  * **Line # 169 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:per_page]).to eq 3 }
    ```

  * **Line # 177 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:items].size).to eq 0 }
    ```

  * **Line # 178 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:total_count]).to eq 10 }
    ```

  * **Line # 179 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:current_page]).to eq 10 }
    ```

  * **Line # 180 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:per_page]).to eq 3 }
    ```

  * **Line # 191 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              @items
    ```

  * **Line # 194 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.length).to eq 10 }
    ```

  * **Line # 195 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject).to all(be_a(Hash)) }
    ```

  * **Line # 196 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.pluck(:id).uniq.count).to eq 10 }
    ```

  * **Line # 218 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject).to be_a(Hash) }
    ```

  * **Line # 219 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(Menu::Allergen.find(subject[:id])).to be_a(Menu::Allergen) }
    ```

  * **Line # 248 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.count).to eq 5 }
    ```

  * **Line # 249 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.pluck(:id).uniq.count).to eq 5 }
    ```

  * **Line # 258 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.count).to eq 5 }
    ```

  * **Line # 259 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.pluck(:id).uniq.count).to eq 5 }
    ```

  * **Line # 268 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.count).to eq 1 }
    ```

  * **Line # 269 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.pluck(:id).uniq.count).to eq 1 }
    ```

  * **Line # 270 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.first[:name]).to eq "Allergen #1!!!" }
    ```

  * **Line # 279 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.count).to eq 1 }
    ```

  * **Line # 280 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.pluck(:id).uniq.count).to eq 1 }
    ```

  * **Line # 281 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.first[:name]).to eq "Allergen #1!!!" }
    ```

  * **Line # 282 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.first[:description]).to eq "Description for #1!!!" }
    ```

  * **Line # 291 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.count).to eq 1 }
    ```

  * **Line # 292 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.pluck(:id).uniq.count).to eq 1 }
    ```

  * **Line # 293 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.first[:name]).to eq "Allergen #5!!!" }
    ```

  * **Line # 294 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.first[:description]).to eq "Description for #5!!!" }
    ```

  * **Line # 311 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject).to all(include(status: "active")) }
    ```

  * **Line # 312 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.size).to eq 1 }
    ```

  * **Line # 383 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [391]

    ```rb
          context "when passing a invalid id" do ...
    ```

  * **Line # 391 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [383]

    ```rb
          context "when passing a invalid id" do ...
    ```

  * **Line # 434 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:translations]).to include(name: Hash) }
    ```

  * **Line # 435 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.dig(:translations, :name)).to include(en: "test") }
    ```

  * **Line # 443 - convention:** Rails/I18nLocaleAssignment: Use `I18n.with_locale` with block instead of `I18n.locale=`.

    ```rb
              I18n.locale = (I18n.available_locales - [I18n.default_locale]).sample
    ```

  * **Line # 450 - convention:** Rails/I18nLocaleAssignment: Use `I18n.with_locale` with block instead of `I18n.locale=`.

    ```rb
              I18n.locale = @initial_lang
    ```

  * **Line # 450 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              I18n.locale = @initial_lang
    ```

  * **Line # 502 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "request should create a allergen" do
    ```

  * **Line # 503 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.to change(Menu::Allergen, :count).by(1)
    ```

  * **Line # 525 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it do
    ```

  * **Line # 526 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to include(translations: Hash)
    ```

  * **Line # 527 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject[:translations]).to include(name: Hash)
    ```

  * **Line # 528 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject.dig(:translations, :name)).to include(en: "test")
    ```

  * **Line # 538 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "request should create a allergen" do
    ```

  * **Line # 539 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.to change(Menu::Allergen, :count).by(1)
    ```

  * **Line # 563 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "request should create a allergen" do
    ```

  * **Line # 564 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.to change(Menu::Allergen, :count).by(1)
    ```

  * **Line # 577 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "request should create a allergen" do
    ```

  * **Line # 578 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.to change(Menu::Allergen, :count).by(1)
    ```

  * **Line # 582 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Image.count }.by(1) }
    ```

  * **Line # 582 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
            it { expect { subject }.to change { Image.count }.by(1) }
    ```

  * **Line # 593 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "request should create a allergen" do
    ```

  * **Line # 594 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.to change(Menu::Allergen, :count).by(1)
    ```

  * **Line # 619 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "request should create a allergen" do
    ```

  * **Line # 620 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.to change(Menu::Allergen, :count).by(1)
    ```

  * **Line # 646 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "request should create a allergen" do
    ```

  * **Line # 647 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.to change(Menu::Allergen, :count).by(1)
    ```

  * **Line # 665 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                before { subject }
    ```

  * **Line # 671 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
                  it { Mobility.with_locale(locale) { expect(Menu::Allergen.first.description).to eq nil } }
    ```

  * **Line # 684 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "request should create a allergen" do
    ```

  * **Line # 685 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.to change(Menu::Allergen, :count).by(1)
    ```

  * **Line # 703 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                before { subject }
    ```

  * **Line # 709 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
                  it { Mobility.with_locale(locale) { expect(Menu::Allergen.first.name).to eq nil } }
    ```

  * **Line # 722 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 723 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.not_to change(Menu::Allergen, :count)
    ```

  * **Line # 761 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              before { subject }
    ```

  * **Line # 846 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { allergen.reload.image }.to(nil) }
    ```

  * **Line # 847 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 847 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
            it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 849 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "returns 200" do
    ```

  * **Line # 850 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              subject
    ```

  * **Line # 864 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { allergen.reload.image }.to(nil) }
    ```

  * **Line # 865 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 865 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
            it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 867 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "returns 200" do
    ```

  * **Line # 868 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              subject
    ```

  * **Line # 882 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Image.count }.by(1) }
    ```

  * **Line # 882 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
            it { expect { subject }.to change { Image.count }.by(1) }
    ```

  * **Line # 883 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { allergen.reload.image }.to(an_instance_of(Image)) }
    ```

  * **Line # 920 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { Mobility.with_locale(:it) { expect(subject.name).to eq "Ciao" } }
    ```

  * **Line # 921 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { Mobility.with_locale(:it) { expect(subject.description).to eq nil } }
    ```

  * **Line # 921 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
              it { Mobility.with_locale(:it) { expect(subject.description).to eq nil } }
    ```

  * **Line # 922 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { Mobility.with_locale(:en) { expect(subject.name).to eq "Hello" } }
    ```

  * **Line # 923 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { Mobility.with_locale(:en) { expect(subject.description).to eq nil } }
    ```

  * **Line # 923 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
              it { Mobility.with_locale(:en) { expect(subject.description).to eq nil } }
    ```

  * **Line # 924 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.name).to eq "Hello" }
    ```

  * **Line # 925 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.name_it).to eq "Ciao" }
    ```

  * **Line # 926 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.name_en).to eq "Hello" }
    ```

  * **Line # 950 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.description).to eq "Hello" }
    ```

  * **Line # 951 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.description_it).to eq "Ciao" }
    ```

  * **Line # 952 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.description_en).to eq "Hello" }
    ```

  * **Line # 965 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 966 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.not_to change(Menu::Allergen, :count)
    ```

  * **Line # 1038 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:name]).to eq nil }
    ```

  * **Line # 1038 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
            it { expect(subject[:name]).to eq nil }
    ```

  * **Line # 1045 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.name).to eq nil }
    ```

  * **Line # 1045 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
              it { expect(subject.name).to eq nil }
    ```

  * **Line # 1046 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.name_en).to eq nil }
    ```

  * **Line # 1046 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
              it { expect(subject.name_en).to eq nil }
    ```

  * **Line # 1047 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.name_it).to eq "test-it" }
    ```

  * **Line # 1073 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:name]).to eq nil }
    ```

  * **Line # 1073 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
            it { expect(subject[:name]).to eq nil }
    ```

  * **Line # 1080 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.name).to eq nil }
    ```

  * **Line # 1080 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
              it { expect(subject.name).to eq nil }
    ```

  * **Line # 1081 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.name_en).to eq nil }
    ```

  * **Line # 1081 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
              it { expect(subject.name_en).to eq nil }
    ```

  * **Line # 1082 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.name_it).to eq nil }
    ```

  * **Line # 1082 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
              it { expect(subject.name_it).to eq nil }
    ```

  * **Line # 1139 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Menu::Allergen.visible.count }.by(-1) }
    ```

  * **Line # 1152 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
            before { allow_any_instance_of(Menu::Allergen).to receive(:deleted!).and_return(false) }
    ```

  * **Line # 1154 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Menu::Allergen.visible.count }) }
    ```

  * **Line # 1167 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
            before { allow_any_instance_of(Menu::Allergen).to receive(:deleted!).and_raise(ActiveRecord::RecordInvalid) }
    ```

  * **Line # 1169 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Menu::Allergen.visible.count }) }
    ```

  * **Line # 1192 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:post, "/v1/admin/menu/allergens/22/copy").to(format: :json, action: :copy,
    ```

  * **Line # 1193 - convention:** Layout/LineLength: Line is too long. [123/120]

    ```rb
                                                                                 controller: "v1/admin/menu/allergens", id: 22)
    ```

  * **Line # 1214 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { Menu::Allergen.count }.by(1) }
    ```

  * **Line # 1214 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Allergen, :count)`.

    ```rb
          it { expect { subject }.to change { Menu::Allergen.count }.by(1) }
    ```

  * **Line # 1238 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change { Image.count }.by(1) }
    ```

  * **Line # 1238 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
              it { expect { subject }.to change { Image.count }.by(1) }
    ```

  * **Line # 1239 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change { ImageToRecord.count }.by(1) }
    ```

  * **Line # 1239 - convention:** RSpec/ExpectChange: Prefer `change(ImageToRecord, :count)`.

    ```rb
              it { expect { subject }.to change { ImageToRecord.count }.by(1) }
    ```

  * **Line # 1242 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                before { subject }
    ```

  * **Line # 1255 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 1255 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
              it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 1256 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change { ImageToRecord.count }.by(1) }
    ```

  * **Line # 1256 - convention:** RSpec/ExpectChange: Prefer `change(ImageToRecord, :count)`.

    ```rb
              it { expect { subject }.to change { ImageToRecord.count }.by(1) }
    ```

  * **Line # 1259 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                before { subject }
    ```

  * **Line # 1272 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 1272 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
              it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 1273 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { ImageToRecord.count }) }
    ```

  * **Line # 1273 - convention:** RSpec/ExpectChange: Prefer `change(ImageToRecord, :count)`.

    ```rb
              it { expect { subject }.not_to(change { ImageToRecord.count }) }
    ```

  * **Line # 1276 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                before { subject }
    ```

### spec/controllers/v1/admin/menu/categories_controller_spec.rb - (467 offenses)
  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe V1::Admin::Menu::CategoriesController, type: :controller do
    ```

  * **Line # 75 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:items].size).to eq 10 }
    ```

  * **Line # 76 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:total_count]).to eq 30 }
    ```

  * **Line # 77 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:current_page]).to eq 1 }
    ```

  * **Line # 78 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:per_page]).to eq 10 }
    ```

  * **Line # 86 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:items].size).to eq 3 }
    ```

  * **Line # 87 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:total_count]).to eq 10 }
    ```

  * **Line # 88 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:current_page]).to eq 1 }
    ```

  * **Line # 89 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:per_page]).to eq 3 }
    ```

  * **Line # 97 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:items].size).to eq 3 }
    ```

  * **Line # 98 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:total_count]).to eq 10 }
    ```

  * **Line # 99 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:current_page]).to eq 2 }
    ```

  * **Line # 100 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:per_page]).to eq 3 }
    ```

  * **Line # 109 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              it { expect(@page1).to eq @offset0 }
    ```

  * **Line # 109 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              it { expect(@page1).to eq @offset0 }
    ```

  * **Line # 118 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:items].size).to eq 1 }
    ```

  * **Line # 119 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:total_count]).to eq 10 }
    ```

  * **Line # 120 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:current_page]).to eq 4 }
    ```

  * **Line # 121 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:per_page]).to eq 3 }
    ```

  * **Line # 129 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:items].size).to eq 0 }
    ```

  * **Line # 130 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:total_count]).to eq 10 }
    ```

  * **Line # 131 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:current_page]).to eq 10 }
    ```

  * **Line # 132 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:per_page]).to eq 3 }
    ```

  * **Line # 143 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              @items
    ```

  * **Line # 146 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.length).to eq 10 }
    ```

  * **Line # 147 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject).to all(be_a(Hash)) }
    ```

  * **Line # 148 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.pluck(:id).uniq.count).to eq 10 }
    ```

  * **Line # 167 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject).to be_a(Array) }
    ```

  * **Line # 168 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.count).to eq 2 }
    ```

  * **Line # 169 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject[0][:index]).to eq 0 }
    ```

  * **Line # 170 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject[1][:index]).to eq 1 }
    ```

  * **Line # 190 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject).to be_a(Array) }
    ```

  * **Line # 191 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.pluck(:id)).to eq Menu::Category.order(:index).pluck(:id) }
    ```

  * **Line # 201 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              req(except: @excluded.id)
    ```

  * **Line # 207 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.count).to eq 1 }
    ```

  * **Line # 208 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.pluck(:id).uniq.count).to eq 1 }
    ```

  * **Line # 209 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.first[:id]).to eq Menu::Category.last.id }
    ```

  * **Line # 227 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject).to be_a(Hash) }
    ```

  * **Line # 228 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(Menu::Category.find(subject[:id])).to be_a(Menu::Category) }
    ```

  * **Line # 235 - convention:** RSpec/ExampleLength: Example has too many lines. [6/5]

    ```rb
            it { ...
    ```

  * **Line # 236 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to include(
    ```

  * **Line # 244 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:images].count).to eq 2 }
    ```

  * **Line # 250 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              create_list(:menu_category, 2, visibility: nil, parent: @parent)
    ```

  * **Line # 261 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              before { req(parent_id: @parent.id) }
    ```

  * **Line # 266 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                it { expect(subject.count).to eq 2 }
    ```

  * **Line # 267 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                it { expect(subject.pluck(:id).uniq.count).to eq 2 }
    ```

  * **Line # 270 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                  expect(Menu::Category.where(id: subject.pluck(:id).uniq).pluck(:id)).to match_array(Menu::Category.where(parent: @parent).pluck(:id))
    ```

  * **Line # 270 - convention:** Layout/LineLength: Line is too long. [147/120]

    ```rb
                  expect(Menu::Category.where(id: subject.pluck(:id).uniq).pluck(:id)).to match_array(Menu::Category.where(parent: @parent).pluck(:id))
    ```

  * **Line # 270 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
                  expect(Menu::Category.where(id: subject.pluck(:id).uniq).pluck(:id)).to match_array(Menu::Category.where(parent: @parent).pluck(:id))
    ```

  * **Line # 277 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                it { expect(subject[:total_count]).to eq 2 }
    ```

  * **Line # 278 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                it { expect(subject[:current_page]).to eq 1 }
    ```

  * **Line # 279 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                it { expect(subject[:per_page]).to eq 10 }
    ```

  * **Line # 280 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                it { expect(subject[:params]).to be_a(Hash) }
    ```

  * **Line # 281 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                it { expect(subject[:params]).to include("parent_id" => @parent.id) }
    ```

  * **Line # 281 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
                it { expect(subject[:params]).to include("parent_id" => @parent.id) }
    ```

  * **Line # 291 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                it { expect(subject.count).to eq 3 }
    ```

  * **Line # 292 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                it { expect(subject.pluck(:id).uniq.count).to eq 3 }
    ```

  * **Line # 295 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                  expect(Menu::Category.where(id: subject.pluck(:id).uniq).pluck(:id)).to match_array(Menu::Category.where(parent_id: nil).pluck(:id))
    ```

  * **Line # 295 - convention:** Layout/LineLength: Line is too long. [146/120]

    ```rb
                  expect(Menu::Category.where(id: subject.pluck(:id).uniq).pluck(:id)).to match_array(Menu::Category.where(parent_id: nil).pluck(:id))
    ```

  * **Line # 302 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                it { expect(subject[:total_count]).to eq 3 }
    ```

  * **Line # 303 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                it { expect(subject[:current_page]).to eq 1 }
    ```

  * **Line # 304 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                it { expect(subject[:per_page]).to eq 10 }
    ```

  * **Line # 305 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                it { expect(subject[:params]).to be_a(Hash) }
    ```

  * **Line # 306 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                it { expect(subject[:params]).to include("parent_id" => "") }
    ```

  * **Line # 314 - warning:** Lint/UselessAssignment: Useless assignment to variable - `items`.

    ```rb
              items = 5.times.map do |i|
    ```

  * **Line # 314 - convention:** Performance/TimesMap: Use `Array.new(5)` with a block instead of `.times.map`.

    ```rb
              items = 5.times.map do |i| ...
    ```

  * **Line # 336 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.count).to eq 5 }
    ```

  * **Line # 337 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.pluck(:id).uniq.count).to eq 5 }
    ```

  * **Line # 346 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.count).to eq 5 }
    ```

  * **Line # 347 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.pluck(:id).uniq.count).to eq 5 }
    ```

  * **Line # 356 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.count).to eq 1 }
    ```

  * **Line # 357 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.pluck(:id).uniq.count).to eq 1 }
    ```

  * **Line # 358 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.first[:name]).to eq "Category #1!!!" }
    ```

  * **Line # 367 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.count).to eq 1 }
    ```

  * **Line # 368 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.pluck(:id).uniq.count).to eq 1 }
    ```

  * **Line # 369 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.first[:name]).to eq "Category #1!!!" }
    ```

  * **Line # 370 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.first[:description]).to eq "Description for #1!!!" }
    ```

  * **Line # 379 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.count).to eq 1 }
    ```

  * **Line # 380 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.pluck(:id).uniq.count).to eq 1 }
    ```

  * **Line # 381 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.first[:name]).to eq "Category #5!!!" }
    ```

  * **Line # 382 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.first[:description]).to eq "Description for #5!!!" }
    ```

  * **Line # 389 - warning:** Lint/UselessAssignment: Useless assignment to variable - `items`.

    ```rb
              items = 5.times.map do |i|
    ```

  * **Line # 389 - convention:** Performance/TimesMap: Use `Array.new(5)` with a block instead of `.times.map`.

    ```rb
              items = 5.times.map do |i| ...
    ```

  * **Line # 401 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
              it do
    ```

  * **Line # 402 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject.map(&:price).uniq).to contain_exactly(nil, 10, 20, 30, 40, 50)
    ```

  * **Line # 403 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject.map(&:price?)).to match_array(([false] * 5) + ([true] * 5))
    ```

  * **Line # 404 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject.count).to eq 10
    ```

  * **Line # 414 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                it { expect(subject.count).to eq 5 }
    ```

  * **Line # 415 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                it { expect(subject.pluck(:id).uniq.count).to eq 5 }
    ```

  * **Line # 416 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                it { expect(subject.pluck(:price).uniq).to all(be_positive) }
    ```

  * **Line # 417 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                it { expect(subject.pluck(:price).uniq).to all(be_a(Numeric)) }
    ```

  * **Line # 432 - warning:** Lint/UselessAssignment: Useless assignment to variable - `items`.

    ```rb
              items = 5.times.map do |i|
    ```

  * **Line # 432 - convention:** Performance/TimesMap: Use `Array.new(5)` with a block instead of `.times.map`.

    ```rb
              items = 5.times.map do |i| ...
    ```

  * **Line # 444 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
              it do
    ```

  * **Line # 445 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject.map(&:price).uniq).to contain_exactly(nil, 10, 20, 30, 40, 50)
    ```

  * **Line # 446 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject.map(&:price?)).to match_array(([false] * 5) + ([true] * 5))
    ```

  * **Line # 447 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject.count).to eq 10
    ```

  * **Line # 457 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                it { expect(subject.count).to eq 5 }
    ```

  * **Line # 458 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                it { expect(subject.pluck(:id).uniq.count).to eq 5 }
    ```

  * **Line # 459 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                it { expect(subject.pluck(:price).uniq).to eq [nil] }
    ```

  * **Line # 484 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject).to all(include(status: "active")) }
    ```

  * **Line # 485 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.size).to eq 1 }
    ```

  * **Line # 522 - convention:** RSpec/ExampleLength: Example has too many lines. [6/5]

    ```rb
            it { ...
    ```

  * **Line # 523 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to include(
    ```

  * **Line # 531 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:images].count).to eq 0 }
    ```

  * **Line # 544 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
            it do
    ```

  * **Line # 545 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to include(translations: Hash)
    ```

  * **Line # 546 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject[:translations]).to include(name: Hash)
    ```

  * **Line # 547 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject.dig(:translations, :name)).to include(en: "test-en")
    ```

  * **Line # 548 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject.dig(:translations, :name)).to include(it: "test-it")
    ```

  * **Line # 552 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [560]

    ```rb
          context "when passing a invalid id" do ...
    ```

  * **Line # 560 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [552]

    ```rb
          context "when passing a invalid id" do ...
    ```

  * **Line # 580 - convention:** RSpec/ExampleLength: Example has too many lines. [6/5]

    ```rb
            it { ...
    ```

  * **Line # 581 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to include(
    ```

  * **Line # 589 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:images].count).to eq 2 }
    ```

  * **Line # 606 - convention:** RSpec/ExampleLength: Example has too many lines. [7/5]

    ```rb
            it { ...
    ```

  * **Line # 607 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to include(
    ```

  * **Line # 639 - convention:** Rails/I18nLocaleAssignment: Use `I18n.with_locale` with block instead of `I18n.locale=`.

    ```rb
              I18n.locale = (I18n.available_locales - [I18n.default_locale]).sample
    ```

  * **Line # 645 - convention:** Rails/I18nLocaleAssignment: Use `I18n.with_locale` with block instead of `I18n.locale=`.

    ```rb
            after { I18n.locale = I18n.default_locale }
    ```

  * **Line # 688 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [696]

    ```rb
          context "when passing a invalid id" do ...
    ```

  * **Line # 696 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [688]

    ```rb
          context "when passing a invalid id" do ...
    ```

  * **Line # 709 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              create_list(:menu_category, 2, visibility: nil, parent: @grandparent)
    ```

  * **Line # 711 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              @parent = create(:menu_category, visibility: nil, parent: @grandparent)
    ```

  * **Line # 712 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              create_list(:menu_category, 2, visibility: nil, parent: @parent)
    ```

  * **Line # 714 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              @child = create(:menu_category, visibility: nil, parent: @parent)
    ```

  * **Line # 715 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              create_list(:menu_category, 2, visibility: nil, parent: @child)
    ```

  * **Line # 716 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              req(id: @child.id)
    ```

  * **Line # 720 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject).not_to include(message: String) }
    ```

  * **Line # 722 - convention:** RSpec/ExampleLength: Example has too many lines. [7/5]

    ```rb
            it do ...
    ```

  * **Line # 722 - convention:** RSpec/MultipleExpectations: Example has too many expectations [7/1].

    ```rb
            it do
    ```

  * **Line # 723 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to include(breadcrumbs: Array)
    ```

  * **Line # 724 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject[:breadcrumbs]).not_to be_empty
    ```

  * **Line # 725 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject[:breadcrumbs].count).to eq 3
    ```

  * **Line # 726 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject[:breadcrumbs].first).to be_a(Hash)
    ```

  * **Line # 727 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject[:breadcrumbs].last).to include(id: @child.id)
    ```

  * **Line # 727 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              expect(subject[:breadcrumbs].last).to include(id: @child.id)
    ```

  * **Line # 728 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject[:breadcrumbs].second).to include(id: @parent.id)
    ```

  * **Line # 728 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              expect(subject[:breadcrumbs].second).to include(id: @parent.id)
    ```

  * **Line # 729 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject[:breadcrumbs].first).to include(id: @grandparent.id)
    ```

  * **Line # 729 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              expect(subject[:breadcrumbs].first).to include(id: @grandparent.id)
    ```

  * **Line # 764 - convention:** RSpec/ExampleLength: Example has too many lines. [6/5]

    ```rb
            it { ...
    ```

  * **Line # 765 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to include(
    ```

  * **Line # 773 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:images].count).to eq 0 }
    ```

  * **Line # 784 - convention:** RSpec/MultipleExpectations: Example has too many expectations [5/1].

    ```rb
            it "request should create a category child" do
    ```

  * **Line # 785 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.to change(Menu::Category, :count).by(1)
    ```

  * **Line # 803 - convention:** RSpec/ExampleLength: Example has too many lines. [6/5]

    ```rb
              it { ...
    ```

  * **Line # 804 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject).to include(
    ```

  * **Line # 812 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject[:images].count).to eq 0 }
    ```

  * **Line # 822 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
            it "request should create a category" do
    ```

  * **Line # 823 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.to change(Menu::Category, :count).by(1)
    ```

  * **Line # 840 - convention:** RSpec/ExampleLength: Example has too many lines. [6/5]

    ```rb
              it { ...
    ```

  * **Line # 841 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject).to include(
    ```

  * **Line # 849 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject[:images].count).to eq 0 }
    ```

  * **Line # 859 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
            it "request should create a category" do
    ```

  * **Line # 860 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.to change(Menu::Category, :count).by(1)
    ```

  * **Line # 877 - convention:** RSpec/ExampleLength: Example has too many lines. [6/5]

    ```rb
              it { ...
    ```

  * **Line # 878 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject).to include(
    ```

  * **Line # 886 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject[:images].count).to eq 0 }
    ```

  * **Line # 896 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
            it "request should create a category" do
    ```

  * **Line # 897 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.to change(Menu::Category, :count).by(1)
    ```

  * **Line # 914 - convention:** RSpec/ExampleLength: Example has too many lines. [6/5]

    ```rb
              it { ...
    ```

  * **Line # 915 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject).to include(
    ```

  * **Line # 923 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject[:images].count).to eq 0 }
    ```

  * **Line # 935 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
            it "request should create a category" do
    ```

  * **Line # 936 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.to change(Menu::Category, :count).by(1)
    ```

  * **Line # 953 - convention:** RSpec/ExampleLength: Example has too many lines. [6/5]

    ```rb
              it { ...
    ```

  * **Line # 954 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject).to include(
    ```

  * **Line # 962 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject[:images].count).to eq 0 }
    ```

  * **Line # 972 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
            it "request should create a category" do
    ```

  * **Line # 973 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.to change(Menu::Category, :count).by(1)
    ```

  * **Line # 990 - convention:** RSpec/ExampleLength: Example has too many lines. [6/5]

    ```rb
              it { ...
    ```

  * **Line # 991 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject).to include(
    ```

  * **Line # 999 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject[:images].count).to eq 0 }
    ```

  * **Line # 1009 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
            it "request should create a category" do
    ```

  * **Line # 1010 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.to change(Menu::Category, :count).by(1)
    ```

  * **Line # 1027 - convention:** RSpec/ExampleLength: Example has too many lines. [6/5]

    ```rb
              it { ...
    ```

  * **Line # 1028 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject).to include(
    ```

  * **Line # 1036 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject[:images].count).to eq 0 }
    ```

  * **Line # 1046 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 1047 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.not_to change(Menu::Category, :count)
    ```

  * **Line # 1132 - convention:** RSpec/ExampleLength: Example has too many lines. [7/5]

    ```rb
            it { ...
    ```

  * **Line # 1133 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to include(
    ```

  * **Line # 1163 - convention:** RSpec/ExampleLength: Example has too many lines. [7/5]

    ```rb
            it { ...
    ```

  * **Line # 1164 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to include(
    ```

  * **Line # 1186 - convention:** RSpec/ExampleLength: Example has too many lines. [7/5]

    ```rb
            it { ...
    ```

  * **Line # 1187 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to include(
    ```

  * **Line # 1205 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 1206 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              subject
    ```

  * **Line # 1212 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to include(price: 15.2)
    ```

  * **Line # 1215 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { category.reload.price }.to(15.2) }
    ```

  * **Line # 1230 - convention:** RSpec/ExampleLength: Example has too many lines. [7/5]

    ```rb
            it { ...
    ```

  * **Line # 1231 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to include(
    ```

  * **Line # 1253 - convention:** RSpec/ExampleLength: Example has too many lines. [7/5]

    ```rb
            it { ...
    ```

  * **Line # 1254 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to include(
    ```

  * **Line # 1276 - convention:** RSpec/ExampleLength: Example has too many lines. [7/5]

    ```rb
            it { ...
    ```

  * **Line # 1277 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to include(
    ```

  * **Line # 1291 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.name).to eq "Hello" }
    ```

  * **Line # 1292 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.name_it).to eq "Ciao" }
    ```

  * **Line # 1293 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.name_en).to eq "Hello" }
    ```

  * **Line # 1309 - convention:** RSpec/ExampleLength: Example has too many lines. [7/5]

    ```rb
            it { ...
    ```

  * **Line # 1310 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to include(
    ```

  * **Line # 1324 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.description).to eq "Hello" }
    ```

  * **Line # 1325 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.description_it).to eq "Ciao" }
    ```

  * **Line # 1326 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.description_en).to eq "Hello" }
    ```

  * **Line # 1339 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to change(Menu::Category, :count) }
    ```

  * **Line # 1340 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { category.reload.parent }.from(nil).to(parent) }
    ```

  * **Line # 1341 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { category.reload.visibility_id }.from(category.visibility_id).to(nil) }
    ```

  * **Line # 1353 - convention:** RSpec/ExampleLength: Example has too many lines. [7/5]

    ```rb
              it { ...
    ```

  * **Line # 1354 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject).to include(
    ```

  * **Line # 1369 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.parent).to eq parent }
    ```

  * **Line # 1382 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to change(Menu::Category, :count) }
    ```

  * **Line # 1383 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { category.reload.parent }.from(parent).to(nil) }
    ```

  * **Line # 1388 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              subject
    ```

  * **Line # 1400 - convention:** RSpec/ExampleLength: Example has too many lines. [7/5]

    ```rb
              it { ...
    ```

  * **Line # 1401 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject).to include(
    ```

  * **Line # 1416 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.parent).to eq nil }
    ```

  * **Line # 1416 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
              it { expect(subject.parent).to eq nil }
    ```

  * **Line # 1429 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 1430 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.not_to change(Menu::Category, :count)
    ```

  * **Line # 1496 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "checking mock data" do
    ```

  * **Line # 1497 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
              expect(category.secret_desc).to eq nil
    ```

  * **Line # 1498 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
              expect(category.description).to eq nil
    ```

  * **Line # 1591 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:name]).to eq nil }
    ```

  * **Line # 1591 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
            it { expect(subject[:name]).to eq nil }
    ```

  * **Line # 1598 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.name).to eq nil }
    ```

  * **Line # 1598 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
              it { expect(subject.name).to eq nil }
    ```

  * **Line # 1599 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.name_en).to eq nil }
    ```

  * **Line # 1599 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
              it { expect(subject.name_en).to eq nil }
    ```

  * **Line # 1600 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.name_it).to eq "test-it" }
    ```

  * **Line # 1657 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Menu::Category.visible.count }.by(-1) }
    ```

  * **Line # 1670 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
            before { allow_any_instance_of(Menu::Category).to receive(:deleted!).and_return(false) }
    ```

  * **Line # 1672 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Menu::Category.visible.count }) }
    ```

  * **Line # 1685 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
            before { allow_any_instance_of(Menu::Category).to receive(:deleted!).and_raise(ActiveRecord::RecordInvalid) }
    ```

  * **Line # 1687 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Menu::Category.visible.count }) }
    ```

  * **Line # 1734 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
            it { expect(category.visibility.public_visible).to eq false }
    ```

  * **Line # 1735 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
            it { expect(category.visibility.private_visible).to eq false }
    ```

  * **Line # 1747 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to(change { category.reload.visibility.daily_from }) }
    ```

  * **Line # 1748 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to(change { category.reload.visibility.daily_to }) }
    ```

  * **Line # 1751 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              before { subject }
    ```

  * **Line # 1771 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to(change { category.reload.visibility.daily_from }) }
    ```

  * **Line # 1772 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { category.reload.visibility.daily_to }) }
    ```

  * **Line # 1783 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { category.reload.visibility.daily_from }) }
    ```

  * **Line # 1784 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to(change { category.reload.visibility.daily_to }) }
    ```

  * **Line # 1787 - convention:** Layout/LineLength: Line is too long. [156/120]

    ```rb
          context "when category was already public should not stop from updating any other field: should check if can publish only if publishing right now." do
    ```

  * **Line # 1795 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { category.reload.visibility.public_visible }) }
    ```

  * **Line # 1798 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.to change {
    ```

  * **Line # 1803 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "updates public_from and return 200" do
    ```

  * **Line # 1804 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to have_http_status(:ok)
    ```

  * **Line # 1805 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to be_successful
    ```

  * **Line # 1815 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "does not update public_visible to true" do
    ```

  * **Line # 1816 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.not_to(change { category.reload.visibility.public_visible })
    ```

  * **Line # 1817 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to have_http_status(:unprocessable_entity)
    ```

  * **Line # 1818 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).not_to be_successful
    ```

  * **Line # 1821 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 1822 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              subject
    ```

  * **Line # 1834 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "is able to update public_visible to true" do
    ```

  * **Line # 1835 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.to change { category.reload.visibility.public_visible }.from(false).to(true)
    ```

  * **Line # 1836 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to have_http_status(:ok)
    ```

  * **Line # 1837 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to be_successful
    ```

  * **Line # 1847 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "is able to update public_visible to true" do
    ```

  * **Line # 1848 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.to change { category.reload.visibility.public_visible }.from(false).to(true)
    ```

  * **Line # 1849 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to have_http_status(:ok)
    ```

  * **Line # 1850 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to be_successful
    ```

  * **Line # 1860 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "does not update public_visible to true" do
    ```

  * **Line # 1861 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.not_to(change { category.reload.visibility.public_visible })
    ```

  * **Line # 1862 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to have_http_status(:unprocessable_entity)
    ```

  * **Line # 1863 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).not_to be_successful
    ```

  * **Line # 1873 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "does not update public_visible to true" do
    ```

  * **Line # 1874 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.not_to(change { category.reload.visibility.public_visible })
    ```

  * **Line # 1875 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to have_http_status(:unprocessable_entity)
    ```

  * **Line # 1876 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).not_to be_successful
    ```

  * **Line # 1880 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [1893]

    ```rb
          context "when category hasnt any dish" do ...
    ```

  * **Line # 1886 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "updates private_visible to true" do
    ```

  * **Line # 1887 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.to change { category.reload.visibility.private_visible }.from(false).to(true)
    ```

  * **Line # 1888 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to have_http_status(:ok)
    ```

  * **Line # 1889 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to be_successful
    ```

  * **Line # 1893 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [1880]

    ```rb
          context "when category hasnt any dish" do ...
    ```

  * **Line # 1899 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "is not able to update private_visible or public_visible to true" do
    ```

  * **Line # 1900 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.not_to(change { category.reload.visibility.private_visible })
    ```

  * **Line # 1901 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to have_http_status(:unprocessable_entity)
    ```

  * **Line # 1902 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).not_to be_successful
    ```

  * **Line # 1913 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.to change {
    ```

  * **Line # 1919 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.to change {
    ```

  * **Line # 1924 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "is able to update public_from or private_to and return 200" do
    ```

  * **Line # 1925 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to have_http_status(:ok)
    ```

  * **Line # 1926 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to be_successful
    ```

  * **Line # 1930 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              before { subject }
    ```

  * **Line # 1942 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { category.reload.visibility.public_from }) }
    ```

  * **Line # 1944 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { category.reload.visibility.public_to }) }
    ```

  * **Line # 1946 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "is not able to update public_from or public_to and return 422" do
    ```

  * **Line # 1947 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to have_http_status(:unprocessable_entity)
    ```

  * **Line # 1948 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).not_to be_successful
    ```

  * **Line # 1952 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              before { subject }
    ```

  * **Line # 1964 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { category.reload.visibility.private_from }) }
    ```

  * **Line # 1966 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { category.reload.visibility.private_to }) }
    ```

  * **Line # 1968 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "is not able to update private_from or private_to and return 422" do
    ```

  * **Line # 1969 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to have_http_status(:unprocessable_entity)
    ```

  * **Line # 1970 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).not_to be_successful
    ```

  * **Line # 1974 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              before { subject }
    ```

  * **Line # 1986 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { category.reload.visibility.public_from }) }
    ```

  * **Line # 1988 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { category.reload.visibility.public_to }) }
    ```

  * **Line # 1990 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "is not able to update public_from or public_to and return 422" do
    ```

  * **Line # 1991 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to have_http_status(:unprocessable_entity)
    ```

  * **Line # 1992 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).not_to be_successful
    ```

  * **Line # 1996 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              before { subject }
    ```

  * **Line # 2008 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { category.reload.visibility.private_from }) }
    ```

  * **Line # 2010 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { category.reload.visibility.private_to }) }
    ```

  * **Line # 2012 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "is not able to update private_from or public_to and return 422" do
    ```

  * **Line # 2013 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to have_http_status(:unprocessable_entity)
    ```

  * **Line # 2014 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).not_to be_successful
    ```

  * **Line # 2018 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              before { subject }
    ```

  * **Line # 2031 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
              it "updates public_from correctly" do
    ```

  * **Line # 2032 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect { subject }.to change {
    ```

  * **Line # 2035 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject).to have_http_status(:ok)
    ```

  * **Line # 2036 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject).to be_successful
    ```

  * **Line # 2046 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
              it "updates public_to correctly" do
    ```

  * **Line # 2047 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect { subject }.to change {
    ```

  * **Line # 2050 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject).to have_http_status(:ok)
    ```

  * **Line # 2051 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject).to be_successful
    ```

  * **Line # 2061 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
              it "updates private_from correctly" do
    ```

  * **Line # 2062 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect { subject }.to change {
    ```

  * **Line # 2065 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject).to have_http_status(:ok)
    ```

  * **Line # 2066 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject).to be_successful
    ```

  * **Line # 2076 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
              it "updates private_to correctly" do
    ```

  * **Line # 2077 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect { subject }.to change {
    ```

  * **Line # 2080 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject).to have_http_status(:ok)
    ```

  * **Line # 2081 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject).to be_successful
    ```

  * **Line # 2097 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:post, "/v1/admin/menu/categories/22/dishes/55").to(format: :json, action: :add_dish,
    ```

  * **Line # 2098 - convention:** Layout/LineLength: Line is too long. [143/120]

    ```rb
                                                                                       controller: "v1/admin/menu/categories", id: 22, dish_id: 55)
    ```

  * **Line # 2117 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { category.reload.dishes.count }.by(1) }
    ```

  * **Line # 2118 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { Menu::DishesInCategory.count }.by(1) }
    ```

  * **Line # 2118 - convention:** RSpec/ExpectChange: Prefer `change(Menu::DishesInCategory, :count)`.

    ```rb
          it { expect { subject }.to change { Menu::DishesInCategory.count }.by(1) }
    ```

  * **Line # 2119 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { Menu::Dish.count }) }
    ```

  * **Line # 2119 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Dish, :count)`.

    ```rb
          it { expect { subject }.not_to(change { Menu::Dish.count }) }
    ```

  * **Line # 2120 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { Menu::Category.count }) }
    ```

  * **Line # 2120 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Category, :count)`.

    ```rb
          it { expect { subject }.not_to(change { Menu::Category.count }) }
    ```

  * **Line # 2126 - convention:** RSpec/ExpectChange: Prefer `change(Menu::DishesInCategory, :count)`.

    ```rb
            it { expect { req }.not_to(change { Menu::DishesInCategory.count }) }
    ```

  * **Line # 2169 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { category.reload.dishes.count }.by(1) }
    ```

  * **Line # 2170 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Menu::DishesInCategory.count }.by(1) }
    ```

  * **Line # 2170 - convention:** RSpec/ExpectChange: Prefer `change(Menu::DishesInCategory, :count)`.

    ```rb
            it { expect { subject }.to change { Menu::DishesInCategory.count }.by(1) }
    ```

  * **Line # 2171 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Menu::Dish.count }.by(1) }
    ```

  * **Line # 2171 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Dish, :count)`.

    ```rb
            it { expect { subject }.to change { Menu::Dish.count }.by(1) }
    ```

  * **Line # 2172 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Menu::Category.count }) }
    ```

  * **Line # 2172 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Category, :count)`.

    ```rb
            it { expect { subject }.not_to(change { Menu::Category.count }) }
    ```

  * **Line # 2175 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              before { subject }
    ```

  * **Line # 2185 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
                allow_any_instance_of(Menu::DishesInCategory).to receive(:valid?).and_return(false)
    ```

  * **Line # 2191 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { category.reload.dishes.count }) }
    ```

  * **Line # 2192 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { Menu::DishesInCategory.count }) }
    ```

  * **Line # 2192 - convention:** RSpec/ExpectChange: Prefer `change(Menu::DishesInCategory, :count)`.

    ```rb
              it { expect { subject }.not_to(change { Menu::DishesInCategory.count }) }
    ```

  * **Line # 2193 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { Menu::Dish.count }) }
    ```

  * **Line # 2193 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Dish, :count)`.

    ```rb
              it { expect { subject }.not_to(change { Menu::Dish.count }) }
    ```

  * **Line # 2202 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
        let!(:dish0) { create(:menu_dish).tap { |d| d.update!(name: "Dish0") } }
    ```

  * **Line # 2203 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
        let!(:dish1) { create(:menu_dish).tap { |d| d.update!(name: "Dish1") } }
    ```

  * **Line # 2204 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
        let!(:dish2) { create(:menu_dish).tap { |d| d.update!(name: "Dish2") } }
    ```

  * **Line # 2218 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:patch, "/v1/admin/menu/categories/22/order_dishes").to(format: :json, action: :order_dishes,
    ```

  * **Line # 2218 - convention:** Layout/LineLength: Line is too long. [124/120]

    ```rb
          expect(subject).to route(:patch, "/v1/admin/menu/categories/22/order_dishes").to(format: :json, action: :order_dishes,
    ```

  * **Line # 2219 - convention:** Layout/LineLength: Line is too long. [134/120]

    ```rb
                                                                                           controller: "v1/admin/menu/categories", id: 22)
    ```

  * **Line # 2240 - convention:** RSpec/ExampleLength: Example has too many lines. [9/5]

    ```rb
            it do ...
    ```

  * **Line # 2240 - convention:** RSpec/MultipleExpectations: Example has too many expectations [6/1].

    ```rb
            it do
    ```

  * **Line # 2253 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 2270 - convention:** RSpec/ExampleLength: Example has too many lines. [9/5]

    ```rb
            it do ...
    ```

  * **Line # 2270 - convention:** RSpec/MultipleExpectations: Example has too many expectations [6/1].

    ```rb
            it do
    ```

  * **Line # 2283 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 2303 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:delete, "/v1/admin/menu/categories/22/dishes/55").to(format: :json, action: :remove_dish,
    ```

  * **Line # 2303 - convention:** Layout/LineLength: Line is too long. [121/120]

    ```rb
          expect(subject).to route(:delete, "/v1/admin/menu/categories/22/dishes/55").to(format: :json, action: :remove_dish,
    ```

  * **Line # 2304 - convention:** Layout/LineLength: Line is too long. [145/120]

    ```rb
                                                                                         controller: "v1/admin/menu/categories", id: 22, dish_id: 55)
    ```

  * **Line # 2332 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { category.reload.dishes.count }.by(-1) }
    ```

  * **Line # 2333 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { Menu::DishesInCategory.count }.by(-1) }
    ```

  * **Line # 2333 - convention:** RSpec/ExpectChange: Prefer `change(Menu::DishesInCategory, :count)`.

    ```rb
          it { expect { subject }.to change { Menu::DishesInCategory.count }.by(-1) }
    ```

  * **Line # 2362 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:post, "/v1/admin/menu/categories/22/add_category/55").to(format: :json, action: :add_category,
    ```

  * **Line # 2362 - convention:** Layout/LineLength: Line is too long. [126/120]

    ```rb
          expect(subject).to route(:post, "/v1/admin/menu/categories/22/add_category/55").to(format: :json, action: :add_category,
    ```

  * **Line # 2363 - convention:** Layout/LineLength: Line is too long. [159/120]

    ```rb
                                                                                             controller: "v1/admin/menu/categories", id: 22, category_child_id: 55)
    ```

  * **Line # 2382 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { category.reload.children.count }.by(1) }
    ```

  * **Line # 2383 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { Menu::Category.count }.by(1) }
    ```

  * **Line # 2383 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Category, :count)`.

    ```rb
          it { expect { subject }.to change { Menu::Category.count }.by(1) }
    ```

  * **Line # 2427 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:post, "/v1/admin/menu/categories/22/copy").to(format: :json, action: :copy,
    ```

  * **Line # 2428 - convention:** Layout/LineLength: Line is too long. [125/120]

    ```rb
                                                                                  controller: "v1/admin/menu/categories", id: 22)
    ```

  * **Line # 2447 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { Menu::Category.count }.by(1) }
    ```

  * **Line # 2447 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Category, :count)`.

    ```rb
          it { expect { subject }.to change { Menu::Category.count }.by(1) }
    ```

  * **Line # 2450 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            subject
    ```

  * **Line # 2466 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change { Menu::Category.count }.by(1) }
    ```

  * **Line # 2466 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Category, :count)`.

    ```rb
              it { expect { subject }.to change { Menu::Category.count }.by(1) }
    ```

  * **Line # 2467 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { category.reload.parent }) }
    ```

  * **Line # 2468 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { category.reload.parent.children.count }) }
    ```

  * **Line # 2471 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                subject
    ```

  * **Line # 2475 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
              it "returns 200" do
    ```

  * **Line # 2476 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                subject
    ```

  * **Line # 2494 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change { Menu::Category.count }.by(1) }
    ```

  * **Line # 2494 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Category, :count)`.

    ```rb
              it { expect { subject }.to change { Menu::Category.count }.by(1) }
    ```

  * **Line # 2495 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { category.reload.parent }) }
    ```

  * **Line # 2496 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { category.reload.parent.children.count }) }
    ```

  * **Line # 2497 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change { parent.reload.children.count }.by(1) }
    ```

  * **Line # 2500 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                subject
    ```

  * **Line # 2504 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
              it "returns 200" do
    ```

  * **Line # 2505 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                subject
    ```

  * **Line # 2523 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 2523 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
            it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 2524 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { ImageToRecord.count }) }
    ```

  * **Line # 2524 - convention:** RSpec/ExpectChange: Prefer `change(ImageToRecord, :count)`.

    ```rb
            it { expect { subject }.not_to(change { ImageToRecord.count }) }
    ```

  * **Line # 2526 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 2527 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              subject
    ```

  * **Line # 2544 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 2544 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
            it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 2545 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { category.reload.images.count }) }
    ```

  * **Line # 2546 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { ImageToRecord.count }.by(1) }
    ```

  * **Line # 2546 - convention:** RSpec/ExpectChange: Prefer `change(ImageToRecord, :count)`.

    ```rb
            it { expect { subject }.to change { ImageToRecord.count }.by(1) }
    ```

  * **Line # 2548 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 2549 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              subject
    ```

  * **Line # 2566 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Image.count }.by(1) }
    ```

  * **Line # 2566 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
            it { expect { subject }.to change { Image.count }.by(1) }
    ```

  * **Line # 2567 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { ImageToRecord.count }.by(1) }
    ```

  * **Line # 2567 - convention:** RSpec/ExpectChange: Prefer `change(ImageToRecord, :count)`.

    ```rb
            it { expect { subject }.to change { ImageToRecord.count }.by(1) }
    ```

  * **Line # 2569 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 2570 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              subject
    ```

  * **Line # 2587 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Menu::Dish.count }) }
    ```

  * **Line # 2587 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Dish, :count)`.

    ```rb
            it { expect { subject }.not_to(change { Menu::Dish.count }) }
    ```

  * **Line # 2588 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Menu::DishesInCategory.count }) }
    ```

  * **Line # 2588 - convention:** RSpec/ExpectChange: Prefer `change(Menu::DishesInCategory, :count)`.

    ```rb
            it { expect { subject }.not_to(change { Menu::DishesInCategory.count }) }
    ```

  * **Line # 2590 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 2591 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              subject
    ```

  * **Line # 2608 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Menu::Dish.count }) }
    ```

  * **Line # 2608 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Dish, :count)`.

    ```rb
            it { expect { subject }.not_to(change { Menu::Dish.count }) }
    ```

  * **Line # 2609 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { category.reload.dishes.count }) }
    ```

  * **Line # 2610 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Menu::DishesInCategory.count }.by(3) }
    ```

  * **Line # 2610 - convention:** RSpec/ExpectChange: Prefer `change(Menu::DishesInCategory, :count)`.

    ```rb
            it { expect { subject }.to change { Menu::DishesInCategory.count }.by(3) }
    ```

  * **Line # 2612 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 2613 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              subject
    ```

  * **Line # 2630 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Menu::Dish.count }.by(3) }
    ```

  * **Line # 2630 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Dish, :count)`.

    ```rb
            it { expect { subject }.to change { Menu::Dish.count }.by(3) }
    ```

  * **Line # 2631 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { category.reload.dishes.count }) }
    ```

  * **Line # 2632 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Menu::DishesInCategory.count }.by(3) }
    ```

  * **Line # 2632 - convention:** RSpec/ExpectChange: Prefer `change(Menu::DishesInCategory, :count)`.

    ```rb
            it { expect { subject }.to change { Menu::DishesInCategory.count }.by(3) }
    ```

  * **Line # 2634 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 2635 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              subject
    ```

  * **Line # 2652 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Menu::Category.count }.by(1) }
    ```

  * **Line # 2652 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Category, :count)`.

    ```rb
            it { expect { subject }.to change { Menu::Category.count }.by(1) }
    ```

  * **Line # 2653 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { category.reload.children.count }) }
    ```

  * **Line # 2655 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 2656 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              subject
    ```

  * **Line # 2673 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Menu::Category.count }.by(3 + 1) }
    ```

  * **Line # 2673 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Category, :count)`.

    ```rb
            it { expect { subject }.to change { Menu::Category.count }.by(3 + 1) }
    ```

  * **Line # 2674 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { category.reload.children.count }) }
    ```

  * **Line # 2676 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 2677 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              subject
    ```

  * **Line # 2711 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [2721]

    ```rb
          context "when passing a invalid id" do ...
    ```

  * **Line # 2721 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [2711]

    ```rb
          context "when passing a invalid id" do ...
    ```

  * **Line # 2738 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:category0) { create(:menu_category, index: 0) }
    ```

  * **Line # 2739 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:category1) { create(:menu_category, index: 1) }
    ```

  * **Line # 2740 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:category2) { create(:menu_category, index: 2) }
    ```

  * **Line # 2742 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it do
    ```

  * **Line # 2743 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.to change { category.reload.index }.from(0).to(1)
    ```

  * **Line # 2751 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
              it do
    ```

  * **Line # 2752 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect { subject }.to change { category.reload.index }.from(0).to(2)
    ```

  * **Line # 2758 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect { subject }.to change { category1.reload.index }.from(1).to(0)
    ```

  * **Line # 2762 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect { subject }.to change { category2.reload.index }.from(2).to(1)
    ```

  * **Line # 2766 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                subject
    ```

  * **Line # 2775 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change { category0.reload.index }.from(0).to(1) }
    ```

  * **Line # 2776 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change { category1.reload.index }.from(1).to(2) }
    ```

  * **Line # 2777 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change { category2.reload.index }.from(2).to(0) }
    ```

  * **Line # 2780 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                subject
    ```

  * **Line # 2789 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { category0.reload.index }) }
    ```

  * **Line # 2791 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change { category1.reload.index }.from(1).to(2) }
    ```

  * **Line # 2792 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to(change { category1.reload.updated_at }) }
    ```

  * **Line # 2793 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change { category2.reload.index }.from(2).to(1) }
    ```

  * **Line # 2794 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to(change { category2.reload.updated_at }) }
    ```

  * **Line # 2801 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { Menu::Category.order(:id).pluck(:updated_at) }) }
    ```

  * **Line # 2802 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { Menu::Category.order(:id).pluck(:index) }) }
    ```

### spec/controllers/v1/admin/menu/dishes_controller/add_allergen_spec.rb - (26 offenses)
  * **Line # 5 - convention:** RSpec/FilePath: Spec path should end with `v1/admin/menu/dishes_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::Menu::DishesController do
    ```

  * **Line # 5 - convention:** RSpec/SpecFilePathFormat: Spec path should end with `v1/admin/menu/dishes_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::Menu::DishesController do
    ```

  * **Line # 21 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:post, "/v1/admin/menu/dishes/22/allergens/55").to(format: :json, action: :add_allergen,
    ```

  * **Line # 22 - convention:** Layout/LineLength: Line is too long. [142/120]

    ```rb
                                                                                      controller: "v1/admin/menu/dishes", id: 22, allergen_id: 55)
    ```

  * **Line # 41 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { dish.reload.allergens.count }.by(1) }
    ```

  * **Line # 42 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { Menu::AllergensInDish.count }.by(1) }
    ```

  * **Line # 42 - convention:** RSpec/ExpectChange: Prefer `change(Menu::AllergensInDish, :count)`.

    ```rb
          it { expect { subject }.to change { Menu::AllergensInDish.count }.by(1) }
    ```

  * **Line # 43 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { Menu::Dish.count }) }
    ```

  * **Line # 43 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Dish, :count)`.

    ```rb
          it { expect { subject }.not_to(change { Menu::Dish.count }) }
    ```

  * **Line # 44 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { Menu::Allergen.count }) }
    ```

  * **Line # 44 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Allergen, :count)`.

    ```rb
          it { expect { subject }.not_to(change { Menu::Allergen.count }) }
    ```

  * **Line # 50 - convention:** RSpec/ExpectChange: Prefer `change(Menu::AllergensInDish, :count)`.

    ```rb
            it { expect { req }.not_to(change { Menu::AllergensInDish.count }) }
    ```

  * **Line # 93 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { dish.reload.allergens.count }.by(1) }
    ```

  * **Line # 94 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Menu::AllergensInDish.count }.by(1) }
    ```

  * **Line # 94 - convention:** RSpec/ExpectChange: Prefer `change(Menu::AllergensInDish, :count)`.

    ```rb
            it { expect { subject }.to change { Menu::AllergensInDish.count }.by(1) }
    ```

  * **Line # 95 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Menu::Allergen.count }.by(1) }
    ```

  * **Line # 95 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Allergen, :count)`.

    ```rb
            it { expect { subject }.to change { Menu::Allergen.count }.by(1) }
    ```

  * **Line # 96 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Menu::Dish.count }) }
    ```

  * **Line # 96 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Dish, :count)`.

    ```rb
            it { expect { subject }.not_to(change { Menu::Dish.count }) }
    ```

  * **Line # 99 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              before { subject }
    ```

  * **Line # 109 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
                allow_any_instance_of(Menu::AllergensInDish).to receive(:valid?).and_return(false)
    ```

  * **Line # 115 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { dish.reload.allergens.count }) }
    ```

  * **Line # 116 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { Menu::AllergensInDish.count }) }
    ```

  * **Line # 116 - convention:** RSpec/ExpectChange: Prefer `change(Menu::AllergensInDish, :count)`.

    ```rb
              it { expect { subject }.not_to(change { Menu::AllergensInDish.count }) }
    ```

  * **Line # 117 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { Menu::Allergen.count }) }
    ```

  * **Line # 117 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Allergen, :count)`.

    ```rb
              it { expect { subject }.not_to(change { Menu::Allergen.count }) }
    ```

### spec/controllers/v1/admin/menu/dishes_controller/add_image_spec.rb - (26 offenses)
  * **Line # 5 - convention:** RSpec/FilePath: Spec path should end with `v1/admin/menu/dishes_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::Menu::DishesController do
    ```

  * **Line # 5 - convention:** RSpec/SpecFilePathFormat: Spec path should end with `v1/admin/menu/dishes_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::Menu::DishesController do
    ```

  * **Line # 21 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:post, "/v1/admin/menu/dishes/22/images/55").to(format: :json, action: :add_image,
    ```

  * **Line # 22 - convention:** Layout/LineLength: Line is too long. [136/120]

    ```rb
                                                                                   controller: "v1/admin/menu/dishes", id: 22, image_id: 55)
    ```

  * **Line # 41 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { dish.reload.images.count }.by(1) }
    ```

  * **Line # 42 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { ImageToRecord.count }.by(1) }
    ```

  * **Line # 42 - convention:** RSpec/ExpectChange: Prefer `change(ImageToRecord, :count)`.

    ```rb
          it { expect { subject }.to change { ImageToRecord.count }.by(1) }
    ```

  * **Line # 43 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { Menu::Dish.count }) }
    ```

  * **Line # 43 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Dish, :count)`.

    ```rb
          it { expect { subject }.not_to(change { Menu::Dish.count }) }
    ```

  * **Line # 44 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 44 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
          it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 50 - convention:** RSpec/ExpectChange: Prefer `change(ImageToRecord, :count)`.

    ```rb
            it { expect { req }.not_to(change { ImageToRecord.count }) }
    ```

  * **Line # 93 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { dish.reload.images.count }.by(1) }
    ```

  * **Line # 94 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { ImageToRecord.count }.by(1) }
    ```

  * **Line # 94 - convention:** RSpec/ExpectChange: Prefer `change(ImageToRecord, :count)`.

    ```rb
            it { expect { subject }.to change { ImageToRecord.count }.by(1) }
    ```

  * **Line # 95 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Image.count }.by(1) }
    ```

  * **Line # 95 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
            it { expect { subject }.to change { Image.count }.by(1) }
    ```

  * **Line # 96 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Menu::Dish.count }) }
    ```

  * **Line # 96 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Dish, :count)`.

    ```rb
            it { expect { subject }.not_to(change { Menu::Dish.count }) }
    ```

  * **Line # 99 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              before { subject }
    ```

  * **Line # 109 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
                allow_any_instance_of(ImageToRecord).to receive(:valid?).and_return(false)
    ```

  * **Line # 115 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { dish.reload.images.count }) }
    ```

  * **Line # 116 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { ImageToRecord.count }) }
    ```

  * **Line # 116 - convention:** RSpec/ExpectChange: Prefer `change(ImageToRecord, :count)`.

    ```rb
              it { expect { subject }.not_to(change { ImageToRecord.count }) }
    ```

  * **Line # 117 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 117 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
              it { expect { subject }.not_to(change { Image.count }) }
    ```

### spec/controllers/v1/admin/menu/dishes_controller/add_ingredient_spec.rb - (27 offenses)
  * **Line # 5 - convention:** RSpec/FilePath: Spec path should end with `v1/admin/menu/dishes_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::Menu::DishesController do
    ```

  * **Line # 5 - convention:** RSpec/SpecFilePathFormat: Spec path should end with `v1/admin/menu/dishes_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::Menu::DishesController do
    ```

  * **Line # 21 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:post, "/v1/admin/menu/dishes/22/ingredients/55").to(format: :json, action: :add_ingredient,
    ```

  * **Line # 21 - convention:** Layout/LineLength: Line is too long. [123/120]

    ```rb
          expect(subject).to route(:post, "/v1/admin/menu/dishes/22/ingredients/55").to(format: :json, action: :add_ingredient,
    ```

  * **Line # 22 - convention:** Layout/LineLength: Line is too long. [146/120]

    ```rb
                                                                                        controller: "v1/admin/menu/dishes", id: 22, ingredient_id: 55)
    ```

  * **Line # 41 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { dish.reload.ingredients.count }.by(1) }
    ```

  * **Line # 42 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { Menu::IngredientsInDish.count }.by(1) }
    ```

  * **Line # 42 - convention:** RSpec/ExpectChange: Prefer `change(Menu::IngredientsInDish, :count)`.

    ```rb
          it { expect { subject }.to change { Menu::IngredientsInDish.count }.by(1) }
    ```

  * **Line # 43 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { Menu::Dish.count }) }
    ```

  * **Line # 43 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Dish, :count)`.

    ```rb
          it { expect { subject }.not_to(change { Menu::Dish.count }) }
    ```

  * **Line # 44 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { Menu::Ingredient.count }) }
    ```

  * **Line # 44 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Ingredient, :count)`.

    ```rb
          it { expect { subject }.not_to(change { Menu::Ingredient.count }) }
    ```

  * **Line # 50 - convention:** RSpec/ExpectChange: Prefer `change(Menu::IngredientsInDish, :count)`.

    ```rb
            it { expect { req }.not_to(change { Menu::IngredientsInDish.count }) }
    ```

  * **Line # 93 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { dish.reload.ingredients.count }.by(1) }
    ```

  * **Line # 94 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Menu::IngredientsInDish.count }.by(1) }
    ```

  * **Line # 94 - convention:** RSpec/ExpectChange: Prefer `change(Menu::IngredientsInDish, :count)`.

    ```rb
            it { expect { subject }.to change { Menu::IngredientsInDish.count }.by(1) }
    ```

  * **Line # 95 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Menu::Ingredient.count }.by(1) }
    ```

  * **Line # 95 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Ingredient, :count)`.

    ```rb
            it { expect { subject }.to change { Menu::Ingredient.count }.by(1) }
    ```

  * **Line # 96 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Menu::Dish.count }) }
    ```

  * **Line # 96 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Dish, :count)`.

    ```rb
            it { expect { subject }.not_to(change { Menu::Dish.count }) }
    ```

  * **Line # 99 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              before { subject }
    ```

  * **Line # 109 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
                allow_any_instance_of(Menu::IngredientsInDish).to receive(:valid?).and_return(false)
    ```

  * **Line # 115 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { dish.reload.ingredients.count }) }
    ```

  * **Line # 116 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { Menu::IngredientsInDish.count }) }
    ```

  * **Line # 116 - convention:** RSpec/ExpectChange: Prefer `change(Menu::IngredientsInDish, :count)`.

    ```rb
              it { expect { subject }.not_to(change { Menu::IngredientsInDish.count }) }
    ```

  * **Line # 117 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { Menu::Ingredient.count }) }
    ```

  * **Line # 117 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Ingredient, :count)`.

    ```rb
              it { expect { subject }.not_to(change { Menu::Ingredient.count }) }
    ```

### spec/controllers/v1/admin/menu/dishes_controller/add_suggestion_spec.rb - (10 offenses)
  * **Line # 5 - convention:** RSpec/FilePath: Spec path should end with `v1/admin/menu/dishes_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::Menu::DishesController do
    ```

  * **Line # 5 - convention:** RSpec/SpecFilePathFormat: Spec path should end with `v1/admin/menu/dishes_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::Menu::DishesController do
    ```

  * **Line # 21 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:post, "/v1/admin/menu/dishes/22/suggestions/55").to(format: :json, action: :add_suggestion,
    ```

  * **Line # 21 - convention:** Layout/LineLength: Line is too long. [123/120]

    ```rb
          expect(subject).to route(:post, "/v1/admin/menu/dishes/22/suggestions/55").to(format: :json, action: :add_suggestion,
    ```

  * **Line # 22 - convention:** Layout/LineLength: Line is too long. [146/120]

    ```rb
                                                                                        controller: "v1/admin/menu/dishes", id: 22, suggestion_id: 55)
    ```

  * **Line # 41 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { dish.reload.suggestions.count }.by(1) }
    ```

  * **Line # 42 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { Menu::DishSuggestion.count }.by(1) }
    ```

  * **Line # 42 - convention:** RSpec/ExpectChange: Prefer `change(Menu::DishSuggestion, :count)`.

    ```rb
          it { expect { subject }.to change { Menu::DishSuggestion.count }.by(1) }
    ```

  * **Line # 43 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { Menu::Dish.count }) }
    ```

  * **Line # 43 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Dish, :count)`.

    ```rb
          it { expect { subject }.not_to(change { Menu::Dish.count }) }
    ```

### spec/controllers/v1/admin/menu/dishes_controller/add_tag_spec.rb - (26 offenses)
  * **Line # 5 - convention:** RSpec/FilePath: Spec path should end with `v1/admin/menu/dishes_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::Menu::DishesController do
    ```

  * **Line # 5 - convention:** RSpec/SpecFilePathFormat: Spec path should end with `v1/admin/menu/dishes_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::Menu::DishesController do
    ```

  * **Line # 21 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:post, "/v1/admin/menu/dishes/22/tags/55").to(format: :json, action: :add_tag,
    ```

  * **Line # 22 - convention:** Layout/LineLength: Line is too long. [132/120]

    ```rb
                                                                                 controller: "v1/admin/menu/dishes", id: 22, tag_id: 55)
    ```

  * **Line # 41 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { dish.reload.tags.count }.by(1) }
    ```

  * **Line # 42 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { Menu::TagsInDish.count }.by(1) }
    ```

  * **Line # 42 - convention:** RSpec/ExpectChange: Prefer `change(Menu::TagsInDish, :count)`.

    ```rb
          it { expect { subject }.to change { Menu::TagsInDish.count }.by(1) }
    ```

  * **Line # 43 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { Menu::Dish.count }) }
    ```

  * **Line # 43 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Dish, :count)`.

    ```rb
          it { expect { subject }.not_to(change { Menu::Dish.count }) }
    ```

  * **Line # 44 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { Menu::Tag.count }) }
    ```

  * **Line # 44 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Tag, :count)`.

    ```rb
          it { expect { subject }.not_to(change { Menu::Tag.count }) }
    ```

  * **Line # 50 - convention:** RSpec/ExpectChange: Prefer `change(Menu::TagsInDish, :count)`.

    ```rb
            it { expect { req }.not_to(change { Menu::TagsInDish.count }) }
    ```

  * **Line # 93 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { dish.reload.tags.count }.by(1) }
    ```

  * **Line # 94 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Menu::TagsInDish.count }.by(1) }
    ```

  * **Line # 94 - convention:** RSpec/ExpectChange: Prefer `change(Menu::TagsInDish, :count)`.

    ```rb
            it { expect { subject }.to change { Menu::TagsInDish.count }.by(1) }
    ```

  * **Line # 95 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Menu::Tag.count }.by(1) }
    ```

  * **Line # 95 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Tag, :count)`.

    ```rb
            it { expect { subject }.to change { Menu::Tag.count }.by(1) }
    ```

  * **Line # 96 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Menu::Dish.count }) }
    ```

  * **Line # 96 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Dish, :count)`.

    ```rb
            it { expect { subject }.not_to(change { Menu::Dish.count }) }
    ```

  * **Line # 99 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              before { subject }
    ```

  * **Line # 109 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
                allow_any_instance_of(Menu::TagsInDish).to receive(:valid?).and_return(false)
    ```

  * **Line # 115 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { dish.reload.tags.count }) }
    ```

  * **Line # 116 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { Menu::TagsInDish.count }) }
    ```

  * **Line # 116 - convention:** RSpec/ExpectChange: Prefer `change(Menu::TagsInDish, :count)`.

    ```rb
              it { expect { subject }.not_to(change { Menu::TagsInDish.count }) }
    ```

  * **Line # 117 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { Menu::Tag.count }) }
    ```

  * **Line # 117 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Tag, :count)`.

    ```rb
              it { expect { subject }.not_to(change { Menu::Tag.count }) }
    ```

### spec/controllers/v1/admin/menu/dishes_controller/copy_spec.rb - (45 offenses)
  * **Line # 5 - convention:** RSpec/FilePath: Spec path should end with `v1/admin/menu/dishes_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::Menu::DishesController do
    ```

  * **Line # 5 - convention:** RSpec/SpecFilePathFormat: Spec path should end with `v1/admin/menu/dishes_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::Menu::DishesController do
    ```

  * **Line # 20 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:post, "/v1/admin/menu/dishes/22/copy").to(format: :json, action: :copy,
    ```

  * **Line # 41 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change(Menu::Dish, :count).by(1) }
    ```

  * **Line # 56 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change(Menu::DishesInCategory, :count).by(1) }
    ```

  * **Line # 57 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change(Menu::Dish, :count).by(1) }
    ```

  * **Line # 58 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to(change { category.reload.dishes.count }.by(1)) }
    ```

  * **Line # 61 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              subject
    ```

  * **Line # 66 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              subject
    ```

  * **Line # 85 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change(Image, :count).by(images.count) }
    ```

  * **Line # 86 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change(ImageToRecord, :count).by(images.count) }
    ```

  * **Line # 89 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                before { subject }
    ```

  * **Line # 102 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change(Image, :count)) }
    ```

  * **Line # 103 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change(ImageToRecord, :count).by(images.count) }
    ```

  * **Line # 106 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                before { subject }
    ```

  * **Line # 117 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change(Image, :count)) }
    ```

  * **Line # 118 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change(ImageToRecord, :count)) }
    ```

  * **Line # 121 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                before { subject }
    ```

  * **Line # 144 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change(Menu::Ingredient, :count).by(ingredients.count) }
    ```

  * **Line # 145 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change(Menu::IngredientsInDish, :count).by(ingredients.count) }
    ```

  * **Line # 148 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                before { subject }
    ```

  * **Line # 161 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change(Menu::Ingredient, :count)) }
    ```

  * **Line # 162 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change(Menu::IngredientsInDish, :count).by(ingredients.count) }
    ```

  * **Line # 165 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                before { subject }
    ```

  * **Line # 176 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change(Menu::Ingredient, :count)) }
    ```

  * **Line # 177 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change(Menu::IngredientsInDish, :count)) }
    ```

  * **Line # 180 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                before { subject }
    ```

  * **Line # 203 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change(Menu::Allergen, :count).by(allergens.count) }
    ```

  * **Line # 204 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change(Menu::AllergensInDish, :count).by(allergens.count) }
    ```

  * **Line # 207 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                before { subject }
    ```

  * **Line # 220 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change(Menu::Allergen, :count)) }
    ```

  * **Line # 221 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change(Menu::AllergensInDish, :count).by(allergens.count) }
    ```

  * **Line # 224 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                before { subject }
    ```

  * **Line # 235 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change(Menu::Allergen, :count)) }
    ```

  * **Line # 236 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change(Menu::AllergensInDish, :count)) }
    ```

  * **Line # 239 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                before { subject }
    ```

  * **Line # 262 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change(Menu::Tag, :count).by(tags.count) }
    ```

  * **Line # 263 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change(Menu::TagsInDish, :count).by(tags.count) }
    ```

  * **Line # 266 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                before { subject }
    ```

  * **Line # 279 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change(Menu::Tag, :count)) }
    ```

  * **Line # 280 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change(Menu::TagsInDish, :count).by(tags.count) }
    ```

  * **Line # 283 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                before { subject }
    ```

  * **Line # 294 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change(Menu::Tag, :count)) }
    ```

  * **Line # 295 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change(Menu::TagsInDish, :count)) }
    ```

  * **Line # 298 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                before { subject }
    ```

### spec/controllers/v1/admin/menu/dishes_controller/create_spec.rb - (20 offenses)
  * **Line # 5 - convention:** RSpec/FilePath: Spec path should end with `v1/admin/menu/dishes_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::Menu::DishesController do
    ```

  * **Line # 5 - convention:** RSpec/SpecFilePathFormat: Spec path should end with `v1/admin/menu/dishes_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::Menu::DishesController do
    ```

  * **Line # 16 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:post, "/v1/admin/menu/dishes").to(format: :json, action: :create,
    ```

  * **Line # 49 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              subject
    ```

  * **Line # 53 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Menu::Dish.count }.by(1) }
    ```

  * **Line # 53 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Dish, :count)`.

    ```rb
            it { expect { subject }.to change { Menu::Dish.count }.by(1) }
    ```

  * **Line # 54 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Menu::DishesInCategory.count }.by(1) }
    ```

  * **Line # 54 - convention:** RSpec/ExpectChange: Prefer `change(Menu::DishesInCategory, :count)`.

    ```rb
            it { expect { subject }.to change { Menu::DishesInCategory.count }.by(1) }
    ```

  * **Line # 55 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Menu::DishesInCategory.where(menu_category_id: nil).count }.by(1) }
    ```

  * **Line # 69 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Menu::Dish.count }.by(1) }
    ```

  * **Line # 69 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Dish, :count)`.

    ```rb
            it { expect { subject }.to change { Menu::Dish.count }.by(1) }
    ```

  * **Line # 70 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Menu::DishesInCategory.count }.by(1) }
    ```

  * **Line # 70 - convention:** RSpec/ExpectChange: Prefer `change(Menu::DishesInCategory, :count)`.

    ```rb
            it { expect { subject }.to change { Menu::DishesInCategory.count }.by(1) }
    ```

  * **Line # 71 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Menu::DishesInCategory.where(menu_category_id: category.id).count }.by(1) }
    ```

  * **Line # 166 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject).to include(translations: Hash) }
    ```

  * **Line # 167 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:translations]).to include(name: Hash) }
    ```

  * **Line # 168 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.dig(:translations, :name)).to include(en: "wassa-en") }
    ```

  * **Line # 169 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.dig(:translations, :name)).to include(it: "wassa-it") }
    ```

  * **Line # 170 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.dig(:translations, :description)).to include(it: "bratan-it") }
    ```

  * **Line # 171 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.dig(:translations, :description)).to include(en: "bratan-en") }
    ```

### spec/controllers/v1/admin/menu/dishes_controller/destroy_spec.rb - (9 offenses)
  * **Line # 5 - convention:** RSpec/FilePath: Spec path should end with `v1/admin/menu/dishes_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::Menu::DishesController do
    ```

  * **Line # 5 - convention:** RSpec/SpecFilePathFormat: Spec path should end with `v1/admin/menu/dishes_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::Menu::DishesController do
    ```

  * **Line # 18 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:delete, "/v1/admin/menu/dishes/22").to(format: :json, action: :destroy,
    ```

  * **Line # 47 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it "does not delete item from database but update its status" do
    ```

  * **Line # 50 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Dish, :count)`.

    ```rb
            expect { req(menu_dish.id) }.not_to(change { Menu::Dish.count })
    ```

  * **Line # 68 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
              allow_any_instance_of(Menu::Dish).to receive(:deleted!).and_return(false)
    ```

  * **Line # 71 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Menu::Dish.visible.count }) }
    ```

  * **Line # 84 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
              allow_any_instance_of(Menu::Dish).to receive(:deleted!).and_raise(ActiveRecord::RecordInvalid)
    ```

  * **Line # 87 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Menu::Dish.visible.count }) }
    ```

### spec/controllers/v1/admin/menu/dishes_controller/index_spec.rb - (103 offenses)
  * **Line # 5 - convention:** RSpec/FilePath: Spec path should end with `v1/admin/menu/dishes_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::Menu::DishesController do
    ```

  * **Line # 5 - convention:** RSpec/SpecFilePathFormat: Spec path should end with `v1/admin/menu/dishes_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::Menu::DishesController do
    ```

  * **Line # 16 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:get, "/v1/admin/menu/dishes").to(format: :json, action: :index,
    ```

  * **Line # 62 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject[:suggestions]).to all(be_a(Hash)) }
    ```

  * **Line # 63 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject[:suggestions]).to all(include(id: Integer, name: String)) }
    ```

  * **Line # 91 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
              it do
    ```

  * **Line # 92 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject).not_to include(message: String)
    ```

  * **Line # 93 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject).to include(items: Array)
    ```

  * **Line # 94 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject[:items].count).to eq 1
    ```

  * **Line # 134 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.size).to eq 1 }
    ```

  * **Line # 158 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.size).to eq 1 }
    ```

  * **Line # 176 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.size).to eq 1 }
    ```

  * **Line # 177 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.first[:status]).to eq "active" }
    ```

  * **Line # 211 - convention:** Rails/UniqBeforePluck: Use `distinct` before `pluck`.

    ```rb
            it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(15, 16) }
    ```

  * **Line # 212 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.size).to eq 2 }
    ```

  * **Line # 216 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [234]

    ```rb
          context 'when filtering by price {price: "15.5"}' do ...
    ```

  * **Line # 230 - convention:** Rails/UniqBeforePluck: Use `distinct` before `pluck`.

    ```rb
            it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(15, 16) }
    ```

  * **Line # 231 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.size).to eq 0 }
    ```

  * **Line # 234 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [216]

    ```rb
          context 'when filtering by price {price: "15.5"}' do ...
    ```

  * **Line # 248 - convention:** Rails/UniqBeforePluck: Use `distinct` before `pluck`.

    ```rb
            it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(15.5, 15, 16) }
    ```

  * **Line # 249 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.size).to eq 1 }
    ```

  * **Line # 267 - convention:** Rails/UniqBeforePluck: Use `distinct` before `pluck`.

    ```rb
            it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(15, 15.5, 16) }
    ```

  * **Line # 268 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.size).to eq 1 }
    ```

  * **Line # 286 - convention:** Rails/UniqBeforePluck: Use `distinct` before `pluck`.

    ```rb
            it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(8, 10, 12) }
    ```

  * **Line # 287 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.size).to eq 2 }
    ```

  * **Line # 289 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.pluck(:price)).to contain_exactly(8, 10) }
    ```

  * **Line # 306 - convention:** Rails/UniqBeforePluck: Use `distinct` before `pluck`.

    ```rb
            it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(8, 10, 12) }
    ```

  * **Line # 307 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.size).to eq 2 }
    ```

  * **Line # 309 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.pluck(:price)).to contain_exactly(10, 12) }
    ```

  * **Line # 326 - convention:** Rails/UniqBeforePluck: Use `distinct` before `pluck`.

    ```rb
            it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(8, 10, 12) }
    ```

  * **Line # 327 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.size).to eq 1 }
    ```

  * **Line # 345 - convention:** Rails/UniqBeforePluck: Use `distinct` before `pluck`.

    ```rb
            it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(8, 10, 12) }
    ```

  * **Line # 346 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.size).to eq 1 }
    ```

  * **Line # 365 - convention:** Rails/UniqBeforePluck: Use `distinct` before `pluck`.

    ```rb
            it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(8, 10, 12, 14) }
    ```

  * **Line # 366 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.size).to eq 2 }
    ```

  * **Line # 367 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.pluck(:price)).to contain_exactly(10, 12) }
    ```

  * **Line # 385 - convention:** Rails/UniqBeforePluck: Use `distinct` before `pluck`.

    ```rb
            it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(8, 10, 12, 14) }
    ```

  * **Line # 386 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.size).to eq 1 }
    ```

  * **Line # 387 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.pluck(:price)).to contain_exactly(10) }
    ```

  * **Line # 391 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let(:category0) { create(:menu_category) }
    ```

  * **Line # 392 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let(:category1) { create(:menu_category) }
    ```

  * **Line # 408 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 417 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let(:dish0) { create(:menu_dish) }
    ```

  * **Line # 418 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let(:dish1) { create(:menu_dish) }
    ```

  * **Line # 433 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 441 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:dish0) { create(:menu_dish, price: 15) }
    ```

  * **Line # 442 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:dish1) { create(:menu_dish, price: nil) }
    ```

  * **Line # 442 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:dish1) { create(:menu_dish, price: nil) }
    ```

  * **Line # 443 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:dish2) { create(:menu_dish, price: 0) }
    ```

  * **Line # 449 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 454 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 461 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:dish0) { create(:menu_dish, price: 15) }
    ```

  * **Line # 461 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:dish0) { create(:menu_dish, price: 15) }
    ```

  * **Line # 462 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:dish2) { create(:menu_dish, price: 0) }
    ```

  * **Line # 463 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:dish3) { create(:menu_dish, price: 25) }
    ```

  * **Line # 464 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:dish4) { create(:menu_dish, price: 14.9) }
    ```

  * **Line # 470 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 475 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 482 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:dish0) { create(:menu_dish, price: 15) }
    ```

  * **Line # 482 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:dish0) { create(:menu_dish, price: 15) }
    ```

  * **Line # 483 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:dish1) { create(:menu_dish, price: nil) }
    ```

  * **Line # 484 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:dish2) { create(:menu_dish, price: 0) }
    ```

  * **Line # 484 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:dish2) { create(:menu_dish, price: 0) }
    ```

  * **Line # 490 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 495 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 502 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:dish0) { create(:menu_dish, price: 15) }
    ```

  * **Line # 503 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:dish1) { create(:menu_dish, price: nil) }
    ```

  * **Line # 503 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:dish1) { create(:menu_dish, price: nil) }
    ```

  * **Line # 504 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:dish2) { create(:menu_dish, price: 0) }
    ```

  * **Line # 504 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:dish2) { create(:menu_dish, price: 0) }
    ```

  * **Line # 505 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:dish3) { create(:menu_dish, price: 25) }
    ```

  * **Line # 505 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:dish3) { create(:menu_dish, price: 25) }
    ```

  * **Line # 511 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 516 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 523 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:dish0) { create(:menu_dish, price: 15) }
    ```

  * **Line # 524 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:dish1) { create(:menu_dish, price: nil) }
    ```

  * **Line # 524 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:dish1) { create(:menu_dish, price: nil) }
    ```

  * **Line # 525 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:dish2) { create(:menu_dish, price: 0) }
    ```

  * **Line # 525 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:dish2) { create(:menu_dish, price: 0) }
    ```

  * **Line # 526 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:dish3) { create(:menu_dish, price: 25) }
    ```

  * **Line # 527 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:dish4) { create(:menu_dish, price: 14.9) }
    ```

  * **Line # 527 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:dish4) { create(:menu_dish, price: 14.9) }
    ```

  * **Line # 533 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 538 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 545 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:dish0) { create(:menu_dish, price: 15) }
    ```

  * **Line # 546 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:dish1) { create(:menu_dish, price: nil) }
    ```

  * **Line # 546 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:dish1) { create(:menu_dish, price: nil) }
    ```

  * **Line # 547 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:dish2) { create(:menu_dish, price: 0) }
    ```

  * **Line # 548 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:dish3) { create(:menu_dish, price: 25) }
    ```

  * **Line # 549 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:dish4) { create(:menu_dish, price: 100) }
    ```

  * **Line # 549 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:dish4) { create(:menu_dish, price: 100) }
    ```

  * **Line # 555 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 560 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 590 - convention:** Layout/LineLength: Line is too long. [147/120]

    ```rb
          context "when filtering by {can_suggest: <dish_id>} will return dishes that can be added as suggestions for the dish with the provided id" do
    ```

  * **Line # 593 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:deleted_dish) { create(:menu_dish, status: :deleted) }
    ```

  * **Line # 603 - convention:** Layout/LineLength: Line is too long. [153/120]

    ```rb
          context "when filtering by {except_in_category: <category_id>}, should return all items except those who are added in the provided category id." do
    ```

  * **Line # 604 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:dishes) { create_list(:menu_dish, 3) }
    ```

  * **Line # 617 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it do
    ```

  * **Line # 624 - convention:** Layout/LineLength: Line is too long. [171/120]

    ```rb
          context "when filtering by {except_in_category: \"<category_id>,<category_id>\"}, should return all items except those who are added in the provided category id." do
    ```

  * **Line # 625 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:dishes) { create_list(:menu_dish, 3) }
    ```

  * **Line # 627 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:category0) do ...
    ```

  * **Line # 634 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:category1) do ...
    ```

  * **Line # 645 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it do
    ```

### spec/controllers/v1/admin/menu/dishes_controller/move_allergen_spec.rb - (14 offenses)
  * **Line # 5 - convention:** RSpec/FilePath: Spec path should end with `v1/admin/menu/dishes_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::Menu::DishesController do
    ```

  * **Line # 5 - convention:** RSpec/SpecFilePathFormat: Spec path should end with `v1/admin/menu/dishes_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::Menu::DishesController do
    ```

  * **Line # 21 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
        let!(:allergen0) { create(:menu_allergen) }
    ```

  * **Line # 22 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
        let!(:allergen1) { create(:menu_allergen) }
    ```

  * **Line # 23 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
        let!(:allergen2) { create(:menu_allergen) }
    ```

  * **Line # 29 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:patch, "/v1/admin/menu/dishes/22/allergens/55/move").to(format: :json, action: :move_allergen,
    ```

  * **Line # 29 - convention:** Layout/LineLength: Line is too long. [126/120]

    ```rb
          expect(subject).to route(:patch, "/v1/admin/menu/dishes/22/allergens/55/move").to(format: :json, action: :move_allergen,
    ```

  * **Line # 30 - convention:** Layout/LineLength: Line is too long. [148/120]

    ```rb
                                                                                            controller: "v1/admin/menu/dishes", id: 22, allergen_id: 55)
    ```

  * **Line # 33 - convention:** Metrics/ParameterLists: Method has too many optional parameters. [4/3]

    ```rb
        def req(dish_id = dish.id, allergen_id = allergen1.id, to_index = 0, params = {}) ...
    ```

  * **Line # 53 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { dish.reload.allergens.count }) }
    ```

  * **Line # 72 - convention:** RSpec/ExampleLength: Example has too many lines. [9/5]

    ```rb
            it do ...
    ```

  * **Line # 78 - convention:** Layout/LineLength: Line is too long. [126/120]

    ```rb
                                                                                                                     allergen1.id,
    ```

  * **Line # 79 - convention:** Layout/LineLength: Line is too long. [126/120]

    ```rb
                                                                                                                     allergen0.id,
    ```

  * **Line # 80 - convention:** Layout/LineLength: Line is too long. [125/120]

    ```rb
                                                                                                                     allergen2.id
    ```

### spec/controllers/v1/admin/menu/dishes_controller/move_ingredient_spec.rb - (17 offenses)
  * **Line # 5 - convention:** RSpec/FilePath: Spec path should end with `v1/admin/menu/dishes_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::Menu::DishesController do
    ```

  * **Line # 5 - convention:** RSpec/SpecFilePathFormat: Spec path should end with `v1/admin/menu/dishes_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::Menu::DishesController do
    ```

  * **Line # 21 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
        let!(:ingredient0) { create(:menu_ingredient) }
    ```

  * **Line # 22 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
        let!(:ingredient1) { create(:menu_ingredient) }
    ```

  * **Line # 23 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
        let!(:ingredient2) { create(:menu_ingredient) }
    ```

  * **Line # 29 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:patch, "/v1/admin/menu/dishes/22/ingredients/55/move").to(format: :json, action: :move_ingredient,
    ```

  * **Line # 29 - convention:** Layout/LineLength: Line is too long. [130/120]

    ```rb
          expect(subject).to route(:patch, "/v1/admin/menu/dishes/22/ingredients/55/move").to(format: :json, action: :move_ingredient,
    ```

  * **Line # 30 - convention:** Layout/LineLength: Line is too long. [152/120]

    ```rb
                                                                                              controller: "v1/admin/menu/dishes", id: 22, ingredient_id: 55)
    ```

  * **Line # 33 - convention:** Metrics/ParameterLists: Method has too many optional parameters. [4/3]

    ```rb
        def req(dish_id = dish.id, ingredient_id = ingredient1.id, to_index = 0, params = {}) ...
    ```

  * **Line # 53 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { dish.reload.ingredients.count }) }
    ```

  * **Line # 72 - convention:** RSpec/ExampleLength: Example has too many lines. [9/5]

    ```rb
            it do ...
    ```

  * **Line # 74 - convention:** Layout/LineLength: Line is too long. [126/120]

    ```rb
                                                                                                                   ingredient0.id,
    ```

  * **Line # 75 - convention:** Layout/LineLength: Line is too long. [126/120]

    ```rb
                                                                                                                   ingredient1.id,
    ```

  * **Line # 76 - convention:** Layout/LineLength: Line is too long. [125/120]

    ```rb
                                                                                                                   ingredient2.id
    ```

  * **Line # 78 - convention:** Layout/LineLength: Line is too long. [132/120]

    ```rb
                                                                                                                         ingredient1.id,
    ```

  * **Line # 79 - convention:** Layout/LineLength: Line is too long. [132/120]

    ```rb
                                                                                                                         ingredient0.id,
    ```

  * **Line # 80 - convention:** Layout/LineLength: Line is too long. [131/120]

    ```rb
                                                                                                                         ingredient2.id
    ```

### spec/controllers/v1/admin/menu/dishes_controller/move_spec.rb - (21 offenses)
  * **Line # 5 - convention:** RSpec/FilePath: Spec path should end with `v1/admin/menu/dishes_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::Menu::DishesController do
    ```

  * **Line # 5 - convention:** RSpec/SpecFilePathFormat: Spec path should end with `v1/admin/menu/dishes_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::Menu::DishesController do
    ```

  * **Line # 35 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:patch, "/v1/admin/menu/dishes/22/move").to(format: :json, action: :move,
    ```

  * **Line # 74 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "returns 422" do
    ```

  * **Line # 86 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "returns 422" do
    ```

  * **Line # 93 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [182]

    ```rb
          context "when moving to position 0 from position 1" do ...
    ```

  * **Line # 101 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 107 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 123 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 129 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 145 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 151 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 168 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 174 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 182 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [93]

    ```rb
          context "when moving to position 0 from position 1" do ...
    ```

  * **Line # 191 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 197 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 214 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 220 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 237 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 243 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

### spec/controllers/v1/admin/menu/dishes_controller/move_tag_spec.rb - (10 offenses)
  * **Line # 5 - convention:** RSpec/FilePath: Spec path should end with `v1/admin/menu/dishes_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::Menu::DishesController do
    ```

  * **Line # 5 - convention:** RSpec/SpecFilePathFormat: Spec path should end with `v1/admin/menu/dishes_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::Menu::DishesController do
    ```

  * **Line # 21 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
        let!(:tag0) { create(:menu_tag) }
    ```

  * **Line # 22 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
        let!(:tag1) { create(:menu_tag) }
    ```

  * **Line # 23 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
        let!(:tag2) { create(:menu_tag) }
    ```

  * **Line # 29 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:patch, "/v1/admin/menu/dishes/22/tags/55/move").to(format: :json, action: :move_tag,
    ```

  * **Line # 30 - convention:** Layout/LineLength: Line is too long. [138/120]

    ```rb
                                                                                       controller: "v1/admin/menu/dishes", id: 22, tag_id: 55)
    ```

  * **Line # 33 - convention:** Metrics/ParameterLists: Method has too many optional parameters. [4/3]

    ```rb
        def req(dish_id = dish.id, tag_id = tag1.id, to_index = 0, params = {}) ...
    ```

  * **Line # 53 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { dish.reload.tags.count }) }
    ```

  * **Line # 72 - convention:** RSpec/ExampleLength: Example has too many lines. [9/5]

    ```rb
            it do ...
    ```

### spec/controllers/v1/admin/menu/dishes_controller/references_spec.rb - (8 offenses)
  * **Line # 5 - convention:** RSpec/FilePath: Spec path should end with `v1/admin/menu/dishes_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::Menu::DishesController do
    ```

  * **Line # 5 - convention:** RSpec/SpecFilePathFormat: Spec path should end with `v1/admin/menu/dishes_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::Menu::DishesController do
    ```

  * **Line # 41 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:get, "/v1/admin/menu/dishes/22/references").to(format: :json, action: :references,
    ```

  * **Line # 42 - convention:** Layout/LineLength: Line is too long. [122/120]

    ```rb
                                                                                   controller: "v1/admin/menu/dishes", id: 22)
    ```

  * **Line # 74 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            before { subject }
    ```

  * **Line # 76 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 83 - convention:** RSpec/ExampleLength: Example has too many lines. [8/5]

    ```rb
            it do ...
    ```

  * **Line # 83 - convention:** RSpec/MultipleExpectations: Example has too many expectations [7/1].

    ```rb
            it do
    ```

### spec/controllers/v1/admin/menu/dishes_controller/remove_allergen_spec.rb - (14 offenses)
  * **Line # 5 - convention:** RSpec/FilePath: Spec path should end with `v1/admin/menu/dishes_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::Menu::DishesController do
    ```

  * **Line # 5 - convention:** RSpec/SpecFilePathFormat: Spec path should end with `v1/admin/menu/dishes_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::Menu::DishesController do
    ```

  * **Line # 23 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:delete, "/v1/admin/menu/dishes/22/allergens/55").to(format: :json, action: :remove_allergen,
    ```

  * **Line # 23 - convention:** Layout/LineLength: Line is too long. [124/120]

    ```rb
          expect(subject).to route(:delete, "/v1/admin/menu/dishes/22/allergens/55").to(format: :json, action: :remove_allergen,
    ```

  * **Line # 24 - convention:** Layout/LineLength: Line is too long. [144/120]

    ```rb
                                                                                        controller: "v1/admin/menu/dishes", id: 22, allergen_id: 55)
    ```

  * **Line # 46 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { dish.reload.allergens.count }.by(-1) }
    ```

  * **Line # 47 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { Menu::AllergensInDish.count }.by(-1) }
    ```

  * **Line # 47 - convention:** RSpec/ExpectChange: Prefer `change(Menu::AllergensInDish, :count)`.

    ```rb
          it { expect { subject }.to change { Menu::AllergensInDish.count }.by(-1) }
    ```

  * **Line # 49 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it do
    ```

  * **Line # 72 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:allergen0) { allergen } # already added
    ```

  * **Line # 73 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:allergen1) { create(:menu_allergen) }
    ```

  * **Line # 74 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:allergen2) { create(:menu_allergen) }
    ```

  * **Line # 85 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 91 - convention:** RSpec/ExampleLength: Example has too many lines. [8/5]

    ```rb
            it do ...
    ```

### spec/controllers/v1/admin/menu/dishes_controller/remove_from_category_spec.rb - (12 offenses)
  * **Line # 5 - convention:** RSpec/FilePath: Spec path should end with `v1/admin/menu/dishes_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::Menu::DishesController do
    ```

  * **Line # 5 - convention:** RSpec/SpecFilePathFormat: Spec path should end with `v1/admin/menu/dishes_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::Menu::DishesController do
    ```

  * **Line # 23 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:delete, "/v1/admin/menu/dishes/22/remove_from_category").to(format: :json, action: :remove_from_category,
    ```

  * **Line # 23 - convention:** Layout/LineLength: Line is too long. [137/120]

    ```rb
          expect(subject).to route(:delete, "/v1/admin/menu/dishes/22/remove_from_category").to(format: :json, action: :remove_from_category,
    ```

  * **Line # 24 - convention:** Layout/LineLength: Line is too long. [135/120]

    ```rb
                                                                                                controller: "v1/admin/menu/dishes", id: 22)
    ```

  * **Line # 28 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:delete, "/v1/admin/menu/dishes/22/remove_from_category/7").to(format: :json, action: :remove_from_category,
    ```

  * **Line # 28 - convention:** Layout/LineLength: Line is too long. [139/120]

    ```rb
          expect(subject).to route(:delete, "/v1/admin/menu/dishes/22/remove_from_category/7").to(format: :json, action: :remove_from_category,
    ```

  * **Line # 29 - convention:** Layout/LineLength: Line is too long. [153/120]

    ```rb
                                                                                                  controller: "v1/admin/menu/dishes", id: 22, category_id: 7)
    ```

  * **Line # 60 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Dish, :count)`.

    ```rb
            it { expect { req }.not_to(change { Menu::Dish.count }) }
    ```

  * **Line # 64 - convention:** RSpec/ExpectChange: Prefer `change(Menu::DishesInCategory, :count)`.

    ```rb
            it { expect { req }.to change { Menu::DishesInCategory.count }.by(-1) }
    ```

  * **Line # 81 - convention:** RSpec/ExpectChange: Prefer `change(Menu::DishesInCategory, :count)`.

    ```rb
            it { expect { req(dish.id, nil) }.to change { Menu::DishesInCategory.count }.by(-1) }
    ```

  * **Line # 82 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Dish, :count)`.

    ```rb
            it { expect { req(dish.id, nil) }.not_to(change { Menu::Dish.count }) }
    ```

### spec/controllers/v1/admin/menu/dishes_controller/remove_image_spec.rb - (9 offenses)
  * **Line # 5 - convention:** RSpec/FilePath: Spec path should end with `v1/admin/menu/dishes_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::Menu::DishesController do
    ```

  * **Line # 5 - convention:** RSpec/SpecFilePathFormat: Spec path should end with `v1/admin/menu/dishes_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::Menu::DishesController do
    ```

  * **Line # 23 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:delete, "/v1/admin/menu/dishes/22/images/55").to(format: :json, action: :remove_image,
    ```

  * **Line # 24 - convention:** Layout/LineLength: Line is too long. [138/120]

    ```rb
                                                                                     controller: "v1/admin/menu/dishes", id: 22, image_id: 55)
    ```

  * **Line # 46 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { dish.reload.images.count }.by(-1) }
    ```

  * **Line # 47 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { ImageToRecord.count }.by(-1) }
    ```

  * **Line # 47 - convention:** RSpec/ExpectChange: Prefer `change(ImageToRecord, :count)`.

    ```rb
          it { expect { subject }.to change { ImageToRecord.count }.by(-1) }
    ```

  * **Line # 48 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 48 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
          it { expect { subject }.not_to(change { Image.count }) }
    ```

### spec/controllers/v1/admin/menu/dishes_controller/remove_ingredient_spec.rb - (13 offenses)
  * **Line # 5 - convention:** RSpec/FilePath: Spec path should end with `v1/admin/menu/dishes_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::Menu::DishesController do
    ```

  * **Line # 5 - convention:** RSpec/SpecFilePathFormat: Spec path should end with `v1/admin/menu/dishes_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::Menu::DishesController do
    ```

  * **Line # 23 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:delete, "/v1/admin/menu/dishes/22/ingredients/55").to(format: :json, action: :remove_ingredient,
    ```

  * **Line # 23 - convention:** Layout/LineLength: Line is too long. [128/120]

    ```rb
          expect(subject).to route(:delete, "/v1/admin/menu/dishes/22/ingredients/55").to(format: :json, action: :remove_ingredient,
    ```

  * **Line # 24 - convention:** Layout/LineLength: Line is too long. [148/120]

    ```rb
                                                                                          controller: "v1/admin/menu/dishes", id: 22, ingredient_id: 55)
    ```

  * **Line # 46 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { dish.reload.ingredients.count }.by(-1) }
    ```

  * **Line # 47 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { Menu::IngredientsInDish.count }.by(-1) }
    ```

  * **Line # 47 - convention:** RSpec/ExpectChange: Prefer `change(Menu::IngredientsInDish, :count)`.

    ```rb
          it { expect { subject }.to change { Menu::IngredientsInDish.count }.by(-1) }
    ```

  * **Line # 66 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:ingredient0) { ingredient } # already added
    ```

  * **Line # 67 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:ingredient1) { create(:menu_ingredient) }
    ```

  * **Line # 68 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:ingredient2) { create(:menu_ingredient) }
    ```

  * **Line # 79 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 85 - convention:** RSpec/ExampleLength: Example has too many lines. [10/5]

    ```rb
            it do ...
    ```

### spec/controllers/v1/admin/menu/dishes_controller/remove_suggestion_spec.rb - (10 offenses)
  * **Line # 5 - convention:** RSpec/FilePath: Spec path should end with `v1/admin/menu/dishes_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::Menu::DishesController do
    ```

  * **Line # 5 - convention:** RSpec/SpecFilePathFormat: Spec path should end with `v1/admin/menu/dishes_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::Menu::DishesController do
    ```

  * **Line # 25 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:delete, "/v1/admin/menu/dishes/22/suggestions/55").to(format: :json, action: :remove_suggestion,
    ```

  * **Line # 25 - convention:** Layout/LineLength: Line is too long. [128/120]

    ```rb
          expect(subject).to route(:delete, "/v1/admin/menu/dishes/22/suggestions/55").to(format: :json, action: :remove_suggestion,
    ```

  * **Line # 26 - convention:** Layout/LineLength: Line is too long. [148/120]

    ```rb
                                                                                          controller: "v1/admin/menu/dishes", id: 22, suggestion_id: 55)
    ```

  * **Line # 45 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { dish.reload.suggestions.count }.by(-1) }
    ```

  * **Line # 46 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { Menu::DishSuggestion.count }.by(-1) }
    ```

  * **Line # 46 - convention:** RSpec/ExpectChange: Prefer `change(Menu::DishSuggestion, :count)`.

    ```rb
          it { expect { subject }.to change { Menu::DishSuggestion.count }.by(-1) }
    ```

  * **Line # 47 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { Menu::Dish.count }) }
    ```

  * **Line # 47 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Dish, :count)`.

    ```rb
          it { expect { subject }.not_to(change { Menu::Dish.count }) }
    ```

### spec/controllers/v1/admin/menu/dishes_controller/remove_tag_spec.rb - (12 offenses)
  * **Line # 5 - convention:** RSpec/FilePath: Spec path should end with `v1/admin/menu/dishes_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::Menu::DishesController do
    ```

  * **Line # 5 - convention:** RSpec/SpecFilePathFormat: Spec path should end with `v1/admin/menu/dishes_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::Menu::DishesController do
    ```

  * **Line # 23 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:delete, "/v1/admin/menu/dishes/22/tags/55").to(format: :json, action: :remove_tag,
    ```

  * **Line # 24 - convention:** Layout/LineLength: Line is too long. [134/120]

    ```rb
                                                                                   controller: "v1/admin/menu/dishes", id: 22, tag_id: 55)
    ```

  * **Line # 46 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { dish.reload.tags.count }.by(-1) }
    ```

  * **Line # 47 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { Menu::TagsInDish.count }.by(-1) }
    ```

  * **Line # 47 - convention:** RSpec/ExpectChange: Prefer `change(Menu::TagsInDish, :count)`.

    ```rb
          it { expect { subject }.to change { Menu::TagsInDish.count }.by(-1) }
    ```

  * **Line # 66 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:tag0) { tag } # already added
    ```

  * **Line # 67 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:tag1) { create(:menu_tag) }
    ```

  * **Line # 68 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:tag2) { create(:menu_tag) }
    ```

  * **Line # 79 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 85 - convention:** RSpec/ExampleLength: Example has too many lines. [8/5]

    ```rb
            it do ...
    ```

### spec/controllers/v1/admin/menu/dishes_controller/update_spec.rb - (3 offenses)
  * **Line # 5 - convention:** RSpec/FilePath: Spec path should end with `v1/admin/menu/dishes_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::Menu::DishesController do
    ```

  * **Line # 5 - convention:** RSpec/SpecFilePathFormat: Spec path should end with `v1/admin/menu/dishes_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::Menu::DishesController do
    ```

  * **Line # 18 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:patch, "/v1/admin/menu/dishes/22").to(format: :json, action: :update,
    ```

### spec/controllers/v1/admin/menu/dishes_controller/update_status_spec.rb - (9 offenses)
  * **Line # 5 - convention:** RSpec/FilePath: Spec path should end with `v1/admin/menu/dishes_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::Menu::DishesController do
    ```

  * **Line # 5 - convention:** RSpec/SpecFilePathFormat: Spec path should end with `v1/admin/menu/dishes_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::Menu::DishesController do
    ```

  * **Line # 21 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:patch, "/v1/admin/menu/dishes/22/status/inactive").to(format: :json, action: :update_status,
    ```

  * **Line # 21 - convention:** Layout/LineLength: Line is too long. [124/120]

    ```rb
          expect(subject).to route(:patch, "/v1/admin/menu/dishes/22/status/inactive").to(format: :json, action: :update_status,
    ```

  * **Line # 22 - convention:** Layout/LineLength: Line is too long. [149/120]

    ```rb
                                                                                          controller: "v1/admin/menu/dishes", id: 22, status: "inactive")
    ```

  * **Line # 50 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { dish.reload.status }.from("active").to("inactive") }
    ```

  * **Line # 51 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to(change { dish.reload.updated_at }) }
    ```

  * **Line # 53 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it "returns item" do
    ```

  * **Line # 59 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
          it "when setting to 'inactive' first, then 'active' status" do
    ```

### spec/controllers/v1/admin/menu/ingredients_controller_spec.rb - (62 offenses)
  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe V1::Admin::Menu::IngredientsController, type: :controller do
    ```

  * **Line # 16 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:get, "/v1/admin/menu/ingredients").to(format: :json, action: :index,
    ```

  * **Line # 98 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.size).to eq 1 }
    ```

  * **Line # 122 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.size).to eq 1 }
    ```

  * **Line # 140 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.size).to eq 1 }
    ```

  * **Line # 141 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject).to all(include(status: "active")) }
    ```

  * **Line # 159 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.size).to eq 1 }
    ```

  * **Line # 160 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.first[:status]).to eq "active" }
    ```

  * **Line # 219 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:get, "/v1/admin/menu/ingredients/1").to(format: :json, action: :show,
    ```

  * **Line # 266 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:patch, "/v1/admin/menu/ingredients/22").to(format: :json, action: :update,
    ```

  * **Line # 267 - convention:** Layout/LineLength: Line is too long. [123/120]

    ```rb
                                                                               controller: "v1/admin/menu/ingredients", id: 22)
    ```

  * **Line # 295 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { ingredient.reload.image }.to(nil) }
    ```

  * **Line # 296 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 296 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
            it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 298 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "returns 200" do
    ```

  * **Line # 299 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              subject
    ```

  * **Line # 313 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { ingredient.reload.image }.to(nil) }
    ```

  * **Line # 314 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 314 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
            it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 316 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "returns 200" do
    ```

  * **Line # 317 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              subject
    ```

  * **Line # 331 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Image.count }.by(1) }
    ```

  * **Line # 331 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
            it { expect { subject }.to change { Image.count }.by(1) }
    ```

  * **Line # 332 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { ingredient.reload.image }.to(an_instance_of(Image)) }
    ```

  * **Line # 443 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:post, "/v1/admin/menu/ingredients").to(format: :json, action: :create,
    ```

  * **Line # 469 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it do
    ```

  * **Line # 470 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to include(translations: Hash)
    ```

  * **Line # 471 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject[:translations]).to include(name: Hash)
    ```

  * **Line # 472 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject.dig(:translations, :name)).to include(en: "test")
    ```

  * **Line # 482 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "request should create a allergen" do
    ```

  * **Line # 483 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.to change(Menu::Ingredient, :count).by(1)
    ```

  * **Line # 505 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Image.count }.by(1) }
    ```

  * **Line # 505 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
            it { expect { subject }.to change { Image.count }.by(1) }
    ```

  * **Line # 508 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              subject
    ```

  * **Line # 513 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              subject
    ```

  * **Line # 574 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:delete, "/v1/admin/menu/ingredients/22").to(format: :json, action: :destroy,
    ```

  * **Line # 575 - convention:** Layout/LineLength: Line is too long. [124/120]

    ```rb
                                                                                controller: "v1/admin/menu/ingredients", id: 22)
    ```

  * **Line # 603 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it "does not delete item from database but update its status" do
    ```

  * **Line # 606 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Ingredient, :count)`.

    ```rb
            expect { req(menu_ingredient.id) }.not_to(change { Menu::Ingredient.count })
    ```

  * **Line # 624 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
              allow_any_instance_of(Menu::Ingredient).to receive(:deleted!).and_return(false)
    ```

  * **Line # 627 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Menu::Ingredient.visible.count }) }
    ```

  * **Line # 640 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
              allow_any_instance_of(Menu::Ingredient).to receive(:deleted!).and_raise(ActiveRecord::RecordInvalid)
    ```

  * **Line # 643 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Menu::Ingredient.visible.count }) }
    ```

  * **Line # 667 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:post, "/v1/admin/menu/ingredients/22/copy").to(format: :json, action: :copy,
    ```

  * **Line # 668 - convention:** Layout/LineLength: Line is too long. [127/120]

    ```rb
                                                                                   controller: "v1/admin/menu/ingredients", id: 22)
    ```

  * **Line # 689 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { Menu::Ingredient.count }.by(1) }
    ```

  * **Line # 689 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Ingredient, :count)`.

    ```rb
          it { expect { subject }.to change { Menu::Ingredient.count }.by(1) }
    ```

  * **Line # 713 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change { Image.count }.by(1) }
    ```

  * **Line # 713 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
              it { expect { subject }.to change { Image.count }.by(1) }
    ```

  * **Line # 714 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change { ImageToRecord.count }.by(1) }
    ```

  * **Line # 714 - convention:** RSpec/ExpectChange: Prefer `change(ImageToRecord, :count)`.

    ```rb
              it { expect { subject }.to change { ImageToRecord.count }.by(1) }
    ```

  * **Line # 717 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                before { subject }
    ```

  * **Line # 730 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 730 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
              it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 731 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change { ImageToRecord.count }.by(1) }
    ```

  * **Line # 731 - convention:** RSpec/ExpectChange: Prefer `change(ImageToRecord, :count)`.

    ```rb
              it { expect { subject }.to change { ImageToRecord.count }.by(1) }
    ```

  * **Line # 734 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                before { subject }
    ```

  * **Line # 747 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 747 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
              it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 748 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { ImageToRecord.count }) }
    ```

  * **Line # 748 - convention:** RSpec/ExpectChange: Prefer `change(ImageToRecord, :count)`.

    ```rb
              it { expect { subject }.not_to(change { ImageToRecord.count }) }
    ```

  * **Line # 751 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                before { subject }
    ```

### spec/controllers/v1/admin/menu/tags_controller_spec.rb - (154 offenses)
  * **Line # 8 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
        expect(subject).to include(
    ```

  * **Line # 17 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to include(
    ```

  * **Line # 23 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to include(
    ```

  * **Line # 31 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to include(
    ```

  * **Line # 37 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to include(
    ```

  * **Line # 45 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject[:image]).to be_a(Hash)
    ```

  * **Line # 50 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to include(image: nil)
    ```

  * **Line # 56 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to include(color: String)
    ```

  * **Line # 60 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to include(color: nil)
    ```

  * **Line # 65 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe V1::Admin::Menu::TagsController, type: :controller do
    ```

  * **Line # 74 - convention:** Performance/TimesMap: Use `Array.new(count)` with a block instead of `.times.map` only if `count` is always 0 or more.

    ```rb
        items = count.times.map do |_i| ...
    ```

  * **Line # 133 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:items].size).to eq 10 }
    ```

  * **Line # 134 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:total_count]).to eq 30 }
    ```

  * **Line # 135 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:current_page]).to eq 1 }
    ```

  * **Line # 136 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:per_page]).to eq 10 }
    ```

  * **Line # 144 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:items].size).to eq 3 }
    ```

  * **Line # 145 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:total_count]).to eq 10 }
    ```

  * **Line # 146 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:current_page]).to eq 1 }
    ```

  * **Line # 147 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:per_page]).to eq 3 }
    ```

  * **Line # 155 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:items].size).to eq 3 }
    ```

  * **Line # 156 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:total_count]).to eq 10 }
    ```

  * **Line # 157 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:current_page]).to eq 2 }
    ```

  * **Line # 158 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:per_page]).to eq 3 }
    ```

  * **Line # 167 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              it { expect(@page1).to eq @offset0 }
    ```

  * **Line # 167 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              it { expect(@page1).to eq @offset0 }
    ```

  * **Line # 176 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:items].size).to eq 1 }
    ```

  * **Line # 177 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:total_count]).to eq 10 }
    ```

  * **Line # 178 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:current_page]).to eq 4 }
    ```

  * **Line # 179 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:per_page]).to eq 3 }
    ```

  * **Line # 187 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:items].size).to eq 0 }
    ```

  * **Line # 188 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:total_count]).to eq 10 }
    ```

  * **Line # 189 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:current_page]).to eq 10 }
    ```

  * **Line # 190 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:per_page]).to eq 3 }
    ```

  * **Line # 201 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              @items
    ```

  * **Line # 204 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.length).to eq 10 }
    ```

  * **Line # 205 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject).to all(be_a(Hash)) }
    ```

  * **Line # 206 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.pluck(:id).uniq.count).to eq 10 }
    ```

  * **Line # 228 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject).to be_a(Hash) }
    ```

  * **Line # 229 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(Menu::Tag.find(subject[:id])).to be_a(Menu::Tag) }
    ```

  * **Line # 258 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.count).to eq 5 }
    ```

  * **Line # 259 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.pluck(:id).uniq.count).to eq 5 }
    ```

  * **Line # 268 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.count).to eq 5 }
    ```

  * **Line # 269 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.pluck(:id).uniq.count).to eq 5 }
    ```

  * **Line # 278 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.count).to eq 1 }
    ```

  * **Line # 279 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.pluck(:id).uniq.count).to eq 1 }
    ```

  * **Line # 280 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.first[:name]).to eq "Tag #1!!!" }
    ```

  * **Line # 289 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.count).to eq 1 }
    ```

  * **Line # 290 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.pluck(:id).uniq.count).to eq 1 }
    ```

  * **Line # 291 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.first[:name]).to eq "Tag #1!!!" }
    ```

  * **Line # 292 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.first[:description]).to eq "Description for #1!!!" }
    ```

  * **Line # 301 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.count).to eq 1 }
    ```

  * **Line # 302 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.pluck(:id).uniq.count).to eq 1 }
    ```

  * **Line # 303 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.first[:name]).to eq "Tag #5!!!" }
    ```

  * **Line # 304 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.first[:description]).to eq "Description for #5!!!" }
    ```

  * **Line # 321 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject).to all(include(status: "active")) }
    ```

  * **Line # 322 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.size).to eq 1 }
    ```

  * **Line # 393 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [401]

    ```rb
          context "when passing a invalid id" do ...
    ```

  * **Line # 401 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [393]

    ```rb
          context "when passing a invalid id" do ...
    ```

  * **Line # 450 - convention:** Rails/I18nLocaleAssignment: Use `I18n.with_locale` with block instead of `I18n.locale=`.

    ```rb
              I18n.locale = (I18n.available_locales - [I18n.default_locale]).sample
    ```

  * **Line # 457 - convention:** Rails/I18nLocaleAssignment: Use `I18n.with_locale` with block instead of `I18n.locale=`.

    ```rb
              I18n.locale = @initial_lang
    ```

  * **Line # 457 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              I18n.locale = @initial_lang
    ```

  * **Line # 509 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "request should create a tag" do
    ```

  * **Line # 510 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.to change(Menu::Tag, :count).by(1)
    ```

  * **Line # 532 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it do
    ```

  * **Line # 533 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to include(translations: Hash)
    ```

  * **Line # 534 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject[:translations]).to include(name: Hash)
    ```

  * **Line # 535 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject.dig(:translations, :name)).to include(en: "test")
    ```

  * **Line # 545 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "request should create a allergen" do
    ```

  * **Line # 546 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.to change(Menu::Tag, :count).by(1)
    ```

  * **Line # 568 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "request should create a tag" do
    ```

  * **Line # 569 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.to change(Menu::Tag, :count).by(1)
    ```

  * **Line # 594 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Image.count }.by(1) }
    ```

  * **Line # 594 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
            it { expect { subject }.to change { Image.count }.by(1) }
    ```

  * **Line # 597 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              subject
    ```

  * **Line # 602 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              subject
    ```

  * **Line # 613 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "request should create a tag" do
    ```

  * **Line # 614 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.to change(Menu::Tag, :count).by(1)
    ```

  * **Line # 640 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "request should create a tag" do
    ```

  * **Line # 641 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.to change(Menu::Tag, :count).by(1)
    ```

  * **Line # 659 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                before { subject }
    ```

  * **Line # 665 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
                  it { Mobility.with_locale(locale) { expect(Menu::Tag.first.description).to eq nil } }
    ```

  * **Line # 678 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "request should create a tag" do
    ```

  * **Line # 679 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.to change(Menu::Tag, :count).by(1)
    ```

  * **Line # 697 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                before { subject }
    ```

  * **Line # 703 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
                  it { Mobility.with_locale(locale) { expect(Menu::Tag.first.name).to eq nil } }
    ```

  * **Line # 716 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 717 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.not_to change(Menu::Tag, :count)
    ```

  * **Line # 755 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              before { subject }
    ```

  * **Line # 837 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { tag.reload.image }.to(nil) }
    ```

  * **Line # 838 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 838 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
            it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 840 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "returns 200" do
    ```

  * **Line # 841 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              subject
    ```

  * **Line # 855 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { tag.reload.image }.to(nil) }
    ```

  * **Line # 856 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 856 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
            it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 858 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "returns 200" do
    ```

  * **Line # 859 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              subject
    ```

  * **Line # 873 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Image.count }.by(1) }
    ```

  * **Line # 873 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
            it { expect { subject }.to change { Image.count }.by(1) }
    ```

  * **Line # 874 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { tag.reload.image }.to(an_instance_of(Image)) }
    ```

  * **Line # 911 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { Mobility.with_locale(:it) { expect(subject.name).to eq "Ciao" } }
    ```

  * **Line # 912 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { Mobility.with_locale(:it) { expect(subject.description).to eq nil } }
    ```

  * **Line # 912 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
              it { Mobility.with_locale(:it) { expect(subject.description).to eq nil } }
    ```

  * **Line # 913 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { Mobility.with_locale(:en) { expect(subject.name).to eq "Hello" } }
    ```

  * **Line # 914 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { Mobility.with_locale(:en) { expect(subject.description).to eq nil } }
    ```

  * **Line # 914 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
              it { Mobility.with_locale(:en) { expect(subject.description).to eq nil } }
    ```

  * **Line # 915 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.name).to eq "Hello" }
    ```

  * **Line # 916 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.name_it).to eq "Ciao" }
    ```

  * **Line # 917 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.name_en).to eq "Hello" }
    ```

  * **Line # 941 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.description).to eq "Hello" }
    ```

  * **Line # 942 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.description_it).to eq "Ciao" }
    ```

  * **Line # 943 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.description_en).to eq "Hello" }
    ```

  * **Line # 956 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 957 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.not_to change(Menu::Tag, :count)
    ```

  * **Line # 1029 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:name]).to eq nil }
    ```

  * **Line # 1029 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
            it { expect(subject[:name]).to eq nil }
    ```

  * **Line # 1036 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.name).to eq nil }
    ```

  * **Line # 1036 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
              it { expect(subject.name).to eq nil }
    ```

  * **Line # 1037 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.name_en).to eq nil }
    ```

  * **Line # 1037 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
              it { expect(subject.name_en).to eq nil }
    ```

  * **Line # 1038 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.name_it).to eq "test-it" }
    ```

  * **Line # 1064 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:name]).to eq nil }
    ```

  * **Line # 1064 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
            it { expect(subject[:name]).to eq nil }
    ```

  * **Line # 1071 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.name).to eq nil }
    ```

  * **Line # 1071 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
              it { expect(subject.name).to eq nil }
    ```

  * **Line # 1072 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.name_en).to eq nil }
    ```

  * **Line # 1072 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
              it { expect(subject.name_en).to eq nil }
    ```

  * **Line # 1073 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.name_it).to eq nil }
    ```

  * **Line # 1073 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
              it { expect(subject.name_it).to eq nil }
    ```

  * **Line # 1129 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Menu::Tag.visible.count }.by(-1) }
    ```

  * **Line # 1142 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
            before { allow_any_instance_of(Menu::Tag).to receive(:deleted!).and_return(false) }
    ```

  * **Line # 1144 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Menu::Tag.visible.count }) }
    ```

  * **Line # 1157 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
            before { allow_any_instance_of(Menu::Tag).to receive(:deleted!).and_raise(ActiveRecord::RecordInvalid) }
    ```

  * **Line # 1159 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Menu::Tag.visible.count }) }
    ```

  * **Line # 1182 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:post, "/v1/admin/menu/tags/22/copy").to(format: :json, action: :copy, controller: "v1/admin/menu/tags",
    ```

  * **Line # 1182 - convention:** Layout/LineLength: Line is too long. [135/120]

    ```rb
          expect(subject).to route(:post, "/v1/admin/menu/tags/22/copy").to(format: :json, action: :copy, controller: "v1/admin/menu/tags",
    ```

  * **Line # 1204 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { Menu::Tag.count }.by(1) }
    ```

  * **Line # 1204 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Tag, :count)`.

    ```rb
          it { expect { subject }.to change { Menu::Tag.count }.by(1) }
    ```

  * **Line # 1228 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change { Image.count }.by(1) }
    ```

  * **Line # 1228 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
              it { expect { subject }.to change { Image.count }.by(1) }
    ```

  * **Line # 1229 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change { ImageToRecord.count }.by(1) }
    ```

  * **Line # 1229 - convention:** RSpec/ExpectChange: Prefer `change(ImageToRecord, :count)`.

    ```rb
              it { expect { subject }.to change { ImageToRecord.count }.by(1) }
    ```

  * **Line # 1232 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                before { subject }
    ```

  * **Line # 1245 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 1245 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
              it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 1246 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change { ImageToRecord.count }.by(1) }
    ```

  * **Line # 1246 - convention:** RSpec/ExpectChange: Prefer `change(ImageToRecord, :count)`.

    ```rb
              it { expect { subject }.to change { ImageToRecord.count }.by(1) }
    ```

  * **Line # 1249 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                before { subject }
    ```

  * **Line # 1262 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 1262 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
              it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 1263 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { ImageToRecord.count }) }
    ```

  * **Line # 1263 - convention:** RSpec/ExpectChange: Prefer `change(ImageToRecord, :count)`.

    ```rb
              it { expect { subject }.not_to(change { ImageToRecord.count }) }
    ```

  * **Line # 1266 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                before { subject }
    ```

### spec/controllers/v1/admin/preferences_controller_spec.rb - (7 offenses)
  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe V1::Admin::PreferencesController, type: :controller do
    ```

  * **Line # 83 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:patch, "/v1/admin/preferences/language").to(action: :update, key: "language",
    ```

  * **Line # 97 - convention:** RSpec/ExampleLength: Example has too many lines. [7/5]

    ```rb
        it "is able to update the value" do ...
    ```

  * **Line # 97 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it "is able to update the value" do
    ```

  * **Line # 108 - convention:** RSpec/ExampleLength: Example has too many lines. [6/5]

    ```rb
        it "returns 422 with error explanation if invalid value is provided" do ...
    ```

  * **Line # 108 - convention:** RSpec/MultipleExpectations: Example has too many expectations [5/1].

    ```rb
        it "returns 422 with error explanation if invalid value is provided" do
    ```

  * **Line # 118 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it "returns an error if invalid key is provided" do
    ```

### spec/controllers/v1/admin/reservation_tags_controller_spec.rb - (2 offenses)
  * **Line # 7 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
      it "has valid structure" do
    ```

  * **Line # 24 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe V1::Admin::ReservationTagsController, type: :controller do
    ```

### spec/controllers/v1/admin/reservation_turns_controller_spec.rb - (13 offenses)
  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe V1::Admin::ReservationTurnsController, type: :controller do
    ```

  * **Line # 56 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
              let!(:turns) do
    ```

  * **Line # 65 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.dig(:metadata, :total_count)).to eq 1 }
    ```

  * **Line # 66 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject[:items]).to all(include(weekday: weekday_param)) }
    ```

  * **Line # 76 - convention:** Rails/TimeZone: Do not use `Time.now` without zone. Use one of `Time.zone.now`, `Time.current`, `Time.now.in_time_zone`, `Time.now.utc`, `Time.now.getlocal`, `Time.now.xmlschema`, `Time.now.iso8601`, `Time.now.jisx0301`, `Time.now.rfc3339`, `Time.now.httpdate`, `Time.now.to_i`, `Time.now.to_f` instead.

    ```rb
              req(date: (Time.now.end_of_week + 1.day).strftime("%Y-%m-%d"))
    ```

  * **Line # 79 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.dig(:metadata, :total_count)).to eq 1 }
    ```

  * **Line # 91 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.dig(:metadata, :total_count)).to eq 1 }
    ```

  * **Line # 92 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:items]).to all(include(name: "First")) }
    ```

  * **Line # 173 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
              it do
    ```

  * **Line # 190 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "contains all informations" do
    ```

  * **Line # 213 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "contains all informations" do
    ```

  * **Line # 287 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "contains all informations" do
    ```

  * **Line # 303 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "contains all informations" do
    ```

### spec/controllers/v1/admin/reservations_controller_spec.rb - (116 offenses)
  * **Line # 7 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
      it "has valid structure" do
    ```

  * **Line # 8 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
        expect(subject).to be_a(Hash)
    ```

  * **Line # 9 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
        expect(subject).to include(id: Integer, created_at: String, updated_at: String, datetime: String, adults: Integer,
    ```

  * **Line # 17 - convention:** Style/CaseLikeIf: Convert `if-elsif` to `case-when`.

    ```rb
        if options[field] == true ...
    ```

  * **Line # 19 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject).to include(field.to_sym => String)
    ```

  * **Line # 23 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject[field].to_s).to be_blank
    ```

  * **Line # 27 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject).to include(field.to_sym => options[field])
    ```

  * **Line # 33 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe V1::Admin::ReservationsController, type: :controller do
    ```

  * **Line # 98 - convention:** Performance/InefficientHashSearch: Use `#key?` instead of `#keys.include?`.

    ```rb
              it { expect(json[:items].filter { |j| j.keys.include?("payment") }.filter(&:present?).count).to eq(1) }
    ```

  * **Line # 98 - convention:** Performance/Count: Use `count` instead of `filter...count`.

    ```rb
              it { expect(json[:items].filter { |j| j.keys.include?("payment") }.filter(&:present?).count).to eq(1) }
    ```

  * **Line # 99 - convention:** Performance/Detect: Use `find` instead of `filter.first`.

    ```rb
              it { expect(json[:items].filter { |j| j.keys.include?("payment") }.first).to be_present }
    ```

  * **Line # 99 - convention:** Performance/InefficientHashSearch: Use `#key?` instead of `#keys.include?`.

    ```rb
              it { expect(json[:items].filter { |j| j.keys.include?("payment") }.first).to be_present }
    ```

  * **Line # 106 - convention:** Performance/Detect: Use `find` instead of `filter.first`.

    ```rb
                expect(json[:items].filter do |j| ...
    ```

  * **Line # 107 - convention:** Performance/InefficientHashSearch: Use `#key?` instead of `#keys.include?`.

    ```rb
                         j.keys.include?("payment")
    ```

  * **Line # 147 - convention:** RSpec/ExampleLength: Example has too many lines. [12/5]

    ```rb
            it "ignores param" do ...
    ```

  * **Line # 147 - convention:** RSpec/MultipleExpectations: Example has too many expectations [8/1].

    ```rb
            it "ignores param" do
    ```

  * **Line # 191 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject).to all(include(status: "active").or(include(status: "noshow")).or(include(status: "cancelled")))
    ```

  * **Line # 191 - convention:** Layout/LineLength: Line is too long. [124/120]

    ```rb
                expect(subject).to all(include(status: "active").or(include(status: "noshow")).or(include(status: "cancelled")))
    ```

  * **Line # 194 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.count).to eq 3 }
    ```

  * **Line # 223 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.count).to eq 2 }
    ```

  * **Line # 252 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.count).to eq 2 }
    ```

  * **Line # 309 - convention:** Style/RedundantArgument: Argument " " is redundant because it is implied by default.

    ```rb
              let(:query) { reservations.sample.fullname.split(" ").sample }
    ```

  * **Line # 325 - convention:** Style/RedundantArgument: Argument " " is redundant because it is implied by default.

    ```rb
              let(:query) { reservations.sample.notes.split(" ").sample }
    ```

  * **Line # 334 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:reservations) do
    ```

  * **Line # 337 - convention:** Rails/TimeZone: Do not use `Time.now` without zone. Use one of `Time.zone.now`, `Time.current`, `Time.now.in_time_zone`, `Time.now.utc`, `Time.now.getlocal`, `Time.now.xmlschema`, `Time.now.iso8601`, `Time.now.jisx0301`, `Time.now.rfc3339`, `Time.now.httpdate`, `Time.now.to_i`, `Time.now.to_f` instead.

    ```rb
                create(:reservation, status: :active, datetime: Time.now),
    ```

  * **Line # 351 - convention:** Rails/TimeZone: Do not use `Time.now` without zone. Use one of `Time.zone.now`, `Time.current`, `Time.now.in_time_zone`, `Time.now.utc`, `Time.now.getlocal`, `Time.now.xmlschema`, `Time.now.iso8601`, `Time.now.jisx0301`, `Time.now.rfc3339`, `Time.now.httpdate`, `Time.now.to_i`, `Time.now.to_f` instead.

    ```rb
              it { expect(parsed_response_body[:items][0][:datetime].to_date).to eq Time.now.to_date }
    ```

  * **Line # 357 - convention:** Rails/Date: Do not use `Date.today` without zone. Use `Time.zone.today` instead.

    ```rb
              before { req(date: Date.today.to_date) }
    ```

  * **Line # 361 - convention:** Rails/TimeZone: Do not use `Time.now` without zone. Use one of `Time.zone.now`, `Time.current`, `Time.now.in_time_zone`, `Time.now.utc`, `Time.now.getlocal`, `Time.now.xmlschema`, `Time.now.iso8601`, `Time.now.jisx0301`, `Time.now.rfc3339`, `Time.now.httpdate`, `Time.now.to_i`, `Time.now.to_f` instead.

    ```rb
              it { expect(parsed_response_body[:items][0][:datetime].to_date).to eq Time.now.to_date }
    ```

  * **Line # 395 - convention:** Layout/LineLength: Line is too long. [127/120]

    ```rb
            context "when filtering by {date_from: 1.day.from_now.end_of_day.to_datetime.to_s, date_to: 1.day.from_now.to_date}" do
    ```

  * **Line # 411 - convention:** Layout/LineLength: Line is too long. [135/120]

    ```rb
            context "when filtering by {datetime_from: 1.day.from_now.end_of_day.to_datetime.to_s, datetime_to: 1.day.from_now.to_date}" do
    ```

  * **Line # 522 - convention:** Performance/CollectionLiteralInLoop: Avoid immutable Array literals in loops. It is better to extract it into a local variable or a constant.

    ```rb
            %w[attribute column field by].each do |attribute_alias|
    ```

  * **Line # 523 - convention:** Layout/LineLength: Line is too long. [132/120]

    ```rb
              context "when ordering with {order_by: { #{attribute_alias.inspect}: 'datetime', #{direction_alias.inspect}: 'DESC' }}" do
    ```

  * **Line # 531 - convention:** RSpec/MultipleExpectations: Example has too many expectations [5/1].

    ```rb
                it "allows any combination between aliases." do
    ```

  * **Line # 622 - convention:** Rails/TimeZone: Do not use `Time.now` without zone. Use one of `Time.zone.now`, `Time.current`, `Time.now.in_time_zone`, `Time.now.utc`, `Time.now.getlocal`, `Time.now.xmlschema`, `Time.now.iso8601`, `Time.now.jisx0301`, `Time.now.rfc3339`, `Time.now.httpdate`, `Time.now.to_i`, `Time.now.to_f` instead.

    ```rb
              reservation.image_pixels.first.events.create!(event_time: Time.now)
    ```

  * **Line # 626 - convention:** RSpec/ExampleLength: Example has too many lines. [8/5]

    ```rb
            it do ...
    ```

  * **Line # 626 - convention:** RSpec/MultipleExpectations: Example has too many expectations [7/1].

    ```rb
            it do
    ```

  * **Line # 662 - convention:** RSpec/ExampleLength: Example has too many lines. [19/5]

    ```rb
            it "returns reservation info" do ...
    ```

  * **Line # 662 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "returns reservation info" do
    ```

  * **Line # 689 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "returns 200" do
    ```

  * **Line # 698 - convention:** Performance/CollectionLiteralInLoop: Avoid immutable Array literals in loops. It is better to extract it into a local variable or a constant.

    ```rb
            ["2024-10-12 19:00", "2024-12-25 21:00"].each do |datetime|
    ```

  * **Line # 699 - convention:** Performance/CollectionLiteralInLoop: Avoid immutable Array literals in loops. It is better to extract it into a local variable or a constant.

    ```rb
              [1, 2, 3].each do |adults|
    ```

  * **Line # 700 - convention:** Layout/LineLength: Line is too long. [121/120]

    ```rb
                context "when providing {fullname: #{fullname.inspect}, datetime: #{datetime.inspect}, adults: #{adults}}" do
    ```

  * **Line # 705 - convention:** RSpec/ExampleLength: Example has too many lines. [6/5]

    ```rb
                  it "returns provided info" do ...
    ```

  * **Line # 705 - convention:** RSpec/MultipleExpectations: Example has too many expectations [5/1].

    ```rb
                  it "returns provided info" do
    ```

  * **Line # 709 - convention:** Style/RedundantArgument: Argument " " is redundant because it is implied by default.

    ```rb
                    expect(parsed_response_body.dig(:item, :datetime)).to include(datetime.split(" ").first)
    ```

  * **Line # 710 - convention:** Style/RedundantArgument: Argument " " is redundant because it is implied by default.

    ```rb
                    expect(parsed_response_body.dig(:item, :datetime)).to include(datetime.split(" ").last)
    ```

  * **Line # 715 - convention:** Performance/CollectionLiteralInLoop: Avoid immutable Array literals in loops. It is better to extract it into a local variable or a constant.

    ```rb
                [201, "204 fuori"].each do |table|
    ```

  * **Line # 716 - convention:** Performance/CollectionLiteralInLoop: Avoid immutable Array literals in loops. It is better to extract it into a local variable or a constant.

    ```rb
                  ["bambini", "bella vita"].each do |notes|
    ```

  * **Line # 717 - convention:** Performance/CollectionLiteralInLoop: Avoid immutable Array literals in loops. It is better to extract it into a local variable or a constant.

    ```rb
                    ["sa@ba", "gi@gi"].each do |email|
    ```

  * **Line # 718 - convention:** Performance/CollectionLiteralInLoop: Avoid immutable Array literals in loops. It is better to extract it into a local variable or a constant.

    ```rb
                      ["123 333 333", "456 666 666"].each do |phone|
    ```

  * **Line # 719 - convention:** Layout/LineLength: Line is too long. [229/120]

    ```rb
                        context "when providing {fullname: #{fullname.inspect}, datetime: #{datetime.inspect}, adults: #{adults}, table: #{table.inspect}, notes: #{notes.inspect}, email: #{email.inspect}, phone: #{phone.inspect}}" do
    ```

  * **Line # 722 - convention:** RSpec/ExampleLength: Example has too many lines. [7/5]

    ```rb
                          it "returns provided info" do ...
    ```

  * **Line # 722 - convention:** RSpec/MultipleExpectations: Example has too many expectations [6/1].

    ```rb
                          it "returns provided info" do
    ```

  * **Line # 727 - convention:** Style/RedundantArgument: Argument " " is redundant because it is implied by default.

    ```rb
                            expect(parsed_response_body.dig(:item, :datetime)).to include(datetime.split(" ").first)
    ```

  * **Line # 728 - convention:** Style/RedundantArgument: Argument " " is redundant because it is implied by default.

    ```rb
                            expect(parsed_response_body.dig(:item, :datetime)).to include(datetime.split(" ").last)
    ```

  * **Line # 787 - convention:** Style/StringConcatenation: Prefer string interpolation to string concatenation.

    ```rb
            let(:fullname) { "Anne Marie" + SecureRandom.hex }
    ```

  * **Line # 814 - convention:** Style/StringConcatenation: Prefer string interpolation to string concatenation.

    ```rb
            let(:notes) { "Please be kind" + SecureRandom.hex }
    ```

  * **Line # 823 - convention:** Style/StringConcatenation: Prefer string interpolation to string concatenation.

    ```rb
            let(:email) { "giuly@presley" + SecureRandom.hex }
    ```

  * **Line # 906 - convention:** Layout/LineLength: Line is too long. [140/120]

    ```rb
                                                                                                 action: :update_status, id: "2", format: :json)
    ```

  * **Line # 933 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
            it do
    ```

  * **Line # 944 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
            it do
    ```

  * **Line # 955 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
            it do
    ```

  * **Line # 966 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
            it do
    ```

  * **Line # 1022 - convention:** RSpec/ExpectChange: Prefer `change(TagInReservation, :count)`.

    ```rb
            it { expect { req }.to change { TagInReservation.count }.by(1) }
    ```

  * **Line # 1023 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 1024 - convention:** RSpec/ExpectChange: Prefer `change(ReservationTag, :count)`.

    ```rb
            it { expect { req }.not_to(change { ReservationTag.count }) }
    ```

  * **Line # 1028 - convention:** RSpec/ExampleLength: Example has too many lines. [6/5]

    ```rb
            it "is successful" do ...
    ```

  * **Line # 1028 - convention:** RSpec/MultipleExpectations: Example has too many expectations [5/1].

    ```rb
            it "is successful" do
    ```

  * **Line # 1037 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
            it "can try to add twice the tag, will be added just once." do
    ```

  * **Line # 1038 - convention:** RSpec/ExpectChange: Prefer `change(TagInReservation, :count)`.

    ```rb
              expect { req }.to change { TagInReservation.count }.by(1)
    ```

  * **Line # 1040 - convention:** RSpec/ExpectChange: Prefer `change(TagInReservation, :count)`.

    ```rb
              expect { req }.not_to(change { TagInReservation.count })
    ```

  * **Line # 1051 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
              allow_any_instance_of(TagInReservation).to receive(:valid?).and_return(false)
    ```

  * **Line # 1054 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
              allow_any_instance_of(TagInReservation).to receive(:errors).and_return(errors)
    ```

  * **Line # 1057 - convention:** RSpec/ExpectChange: Prefer `change(TagInReservation, :count)`.

    ```rb
            it { expect { req }.not_to(change { TagInReservation.count }) }
    ```

  * **Line # 1059 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "returns 422 with message" do
    ```

  * **Line # 1075 - convention:** Layout/LineLength: Line is too long. [136/120]

    ```rb
                                                                                                action: :remove_tag, id: "2", format: :json)
    ```

  * **Line # 1114 - convention:** RSpec/ExpectChange: Prefer `change(TagInReservation, :count)`.

    ```rb
            it { expect { req }.to change { TagInReservation.count }.by(-1) }
    ```

  * **Line # 1115 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 1116 - convention:** RSpec/ExpectChange: Prefer `change(ReservationTag, :count)`.

    ```rb
            it { expect { req }.not_to(change { ReservationTag.count }) }
    ```

  * **Line # 1121 - convention:** RSpec/ExampleLength: Example has too many lines. [6/5]

    ```rb
            it "is successful" do ...
    ```

  * **Line # 1121 - convention:** RSpec/MultipleExpectations: Example has too many expectations [5/1].

    ```rb
            it "is successful" do
    ```

  * **Line # 1130 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
            it "when removing same tag twice, should be fine." do
    ```

  * **Line # 1146 - convention:** RSpec/ExpectChange: Prefer `change(TagInReservation, :count)`.

    ```rb
            it { expect { req }.to change { TagInReservation.count }.by(-1) }
    ```

  * **Line # 1147 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 1148 - convention:** RSpec/ExpectChange: Prefer `change(ReservationTag, :count)`.

    ```rb
            it { expect { req }.not_to(change { ReservationTag.count }) }
    ```

  * **Line # 1153 - convention:** RSpec/ExampleLength: Example has too many lines. [6/5]

    ```rb
            it "is successful" do ...
    ```

  * **Line # 1153 - convention:** RSpec/MultipleExpectations: Example has too many expectations [5/1].

    ```rb
            it "is successful" do
    ```

  * **Line # 1162 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
            it "when removing same tag twice, should be fine." do
    ```

  * **Line # 1190 - warning:** Lint/UnderscorePrefixedVariableName: Do not use prefix `_` for a variable that is used.

    ```rb
        def req(_params = params)
    ```

  * **Line # 1218 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "is successful" do
    ```

  * **Line # 1226 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
                allow_any_instance_of(Hash).to receive(:dig!).and_call_original
    ```

  * **Line # 1234 - convention:** RSpec/ExpectChange: Prefer `change(Log::DeliveredEmail, :count)`.

    ```rb
              it { expect { req }.to change { Log::DeliveredEmail.count }.by(1) }
    ```

  * **Line # 1236 - convention:** RSpec/ExpectChange: Prefer `change(Log::ImagePixel, :count)`.

    ```rb
              it { expect { req }.to change { Log::ImagePixel.count }.by(1) }
    ```

  * **Line # 1238 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
              it "is successful" do
    ```

  * **Line # 1246 - convention:** RSpec/ExampleLength: Example has too many lines. [9/5]

    ```rb
              it "last delivered email should have the correct reservation" do ...
    ```

  * **Line # 1246 - convention:** RSpec/MultipleExpectations: Example has too many expectations [6/1].

    ```rb
              it "last delivered email should have the correct reservation" do
    ```

  * **Line # 1265 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
              it "is successful" do
    ```

  * **Line # 1275 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
              it "returns delivery details" do
    ```

  * **Line # 1281 - convention:** RSpec/ExampleLength: Example has too many lines. [7/5]

    ```rb
              it do ...
    ```

  * **Line # 1281 - convention:** RSpec/MultipleExpectations: Example has too many expectations [5/1].

    ```rb
              it do
    ```

  * **Line # 1341 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:reservations) do
    ```

  * **Line # 1344 - convention:** Rails/TimeZone: Do not use `Time.now` without zone. Use one of `Time.zone.now`, `Time.current`, `Time.now.in_time_zone`, `Time.now.utc`, `Time.now.getlocal`, `Time.now.xmlschema`, `Time.now.iso8601`, `Time.now.jisx0301`, `Time.now.rfc3339`, `Time.now.httpdate`, `Time.now.to_i`, `Time.now.to_f` instead.

    ```rb
                create(:reservation, status: :active, datetime: Time.now, adults: 2),
    ```

  * **Line # 1351 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:reservation_turns) do
    ```

  * **Line # 1358 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
              let!(:reservation_turns) do
    ```

  * **Line # 1365 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
              let!(:reservations) do
    ```

  * **Line # 1416 - convention:** Rails/Date: Do not use `Date.today` without zone. Use `Time.zone.today` instead.

    ```rb
              before { req(date: Date.today.to_date) }
    ```

  * **Line # 1517 - convention:** Layout/LineLength: Line is too long. [133/120]

    ```rb
              expect(file.sheet("Prenotazioni").column(col_index("payment_hpp_url"))).to include(*ReservationPayment.all.pluck(:hpp_url))
    ```

  * **Line # 1585 - convention:** RSpec/MissingExampleGroupArgument: The first argument to `context` should not be empty.

    ```rb
          context do ...
    ```

  * **Line # 1595 - convention:** RSpec/MissingExampleGroupArgument: The first argument to `context` should not be empty.

    ```rb
          context do ...
    ```

  * **Line # 1605 - convention:** RSpec/MissingExampleGroupArgument: The first argument to `context` should not be empty.

    ```rb
          context do ...
    ```

  * **Line # 1636 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
            it { expect(col_values("id")).to contain_exactly(@middle.id) }
    ```

  * **Line # 1645 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
            it { expect(col_values("id")).to contain_exactly(@middle.id, @new.id) }
    ```

  * **Line # 1645 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
            it { expect(col_values("id")).to contain_exactly(@middle.id, @new.id) }
    ```

  * **Line # 1654 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
            it { expect(col_values("id")).to contain_exactly(@old.id, @middle.id, @new.id) }
    ```

  * **Line # 1654 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
            it { expect(col_values("id")).to contain_exactly(@old.id, @middle.id, @new.id) }
    ```

  * **Line # 1654 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
            it { expect(col_values("id")).to contain_exactly(@old.id, @middle.id, @new.id) }
    ```

### spec/controllers/v1/images_controller_spec.rb - (41 offenses)
  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe V1::ImagesController, type: :controller do
    ```

  * **Line # 46 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "checking mock data" do
    ```

  * **Line # 69 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
                it "when providing record_type: #{invalid_klass.inspect}" do
    ```

  * **Line # 86 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "checking mock data" do
    ```

  * **Line # 98 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.length).to eq 3 }
    ```

  * **Line # 123 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
          it { expect { req }.not_to(change { Image.count }) }
    ```

  * **Line # 134 - convention:** RSpec/ExpectChange: Prefer `change(ImageToRecord, :count)`.

    ```rb
          it { expect { req }.not_to(change { ImageToRecord.count }) }
    ```

  * **Line # 143 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:record_type) { "Menu::Category" }
    ```

  * **Line # 144 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:record_id) { category.id }
    ```

  * **Line # 147 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              subject
    ```

  * **Line # 151 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Image.count }.by(1) }
    ```

  * **Line # 151 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
            it { expect { subject }.to change { Image.count }.by(1) }
    ```

  * **Line # 152 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { ImageToRecord.count }.by(1) }
    ```

  * **Line # 152 - convention:** RSpec/ExpectChange: Prefer `change(ImageToRecord, :count)`.

    ```rb
            it { expect { subject }.to change { ImageToRecord.count }.by(1) }
    ```

  * **Line # 153 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { category.reload.images.count }.by(1) }
    ```

  * **Line # 166 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:patch, "/v1/images/1").to(format: :json, action: :update, id: 1,
    ```

  * **Line # 171 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:patch, "/v1/images/881").to(format: :json, action: :update, id: 881,
    ```

  * **Line # 185 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
          it { expect { req }.not_to(change { Image.count }) }
    ```

  * **Line # 198 - convention:** RSpec/ExpectChange: Prefer `change(ImageToRecord, :count)`.

    ```rb
          it { expect { req }.not_to(change { ImageToRecord.count }) }
    ```

  * **Line # 199 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
          it { expect { req }.not_to(change { Image.count }) }
    ```

  * **Line # 256 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:patch, "/v1/images/record").to(format: :json, action: :update_record,
    ```

  * **Line # 286 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 298 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 313 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
            let(:image_ids) { @order_before.reverse }
    ```

  * **Line # 320 - convention:** RSpec/ExpectChange: Prefer `change(ImageToRecord, :count)`.

    ```rb
            it { expect { req }.not_to(change { ImageToRecord.count }) }
    ```

  * **Line # 323 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 325 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              expect(record.reload.images.pluck(:id)).not_to eq @order_before
    ```

  * **Line # 326 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              expect(record.reload.images.pluck(:id)).to match_array(@order_before)
    ```

  * **Line # 343 - convention:** RSpec/ExpectChange: Prefer `change(ImageToRecord, :count)`.

    ```rb
            it { expect { req }.to(change { ImageToRecord.count }) }
    ```

  * **Line # 385 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:patch, "/v1/images/5/remove_from_record").to(format: :json, action: :remove_from_record,
    ```

  * **Line # 452 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:get, "/v1/images/23/download").to(format: :json, action: :download,
    ```

  * **Line # 480 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
            allow_any_instance_of(Image).to receive(:download).and_raise(ActiveStorage::FileNotFoundError)
    ```

  * **Line # 495 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:get, "/v1/images/23/download/blur").to(format: :json, action: :download_variant,
    ```

  * **Line # 539 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:get, "/v1/images/key/wassabratan").to(format: :json, action: :download_by_key, controller: "v1/images",
    ```

  * **Line # 539 - convention:** Layout/LineLength: Line is too long. [135/120]

    ```rb
          expect(subject).to route(:get, "/v1/images/key/wassabratan").to(format: :json, action: :download_by_key, controller: "v1/images",
    ```

  * **Line # 543 - warning:** Lint/UnderscorePrefixedVariableName: Do not use prefix `_` for a variable that is used.

    ```rb
        def req(_params = params)
    ```

  * **Line # 547 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it "returns 200" do
    ```

  * **Line # 574 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:get, "/v1/images/p/wassabratan").to(format: :json, action: :download_by_pixel_secret,
    ```

  * **Line # 578 - warning:** Lint/UnderscorePrefixedVariableName: Do not use prefix `_` for a variable that is used.

    ```rb
        def req(_params = params)
    ```

  * **Line # 593 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it "returns 200 usually" do
    ```

  * **Line # 604 - convention:** RSpec/ExpectChange: Prefer `change(Log::ImagePixelEvent, :count)`.

    ```rb
          expect { req }.to change { Log::ImagePixelEvent.count }.by(1)
    ```

### spec/controllers/v1/menu/allergens_controller_spec.rb - (61 offenses)
  * **Line # 8 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
        expect(subject).to include(
    ```

  * **Line # 17 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to include(
    ```

  * **Line # 23 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to include(
    ```

  * **Line # 31 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to include(
    ```

  * **Line # 37 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to include(
    ```

  * **Line # 45 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject[:image]).to be_a(Hash)
    ```

  * **Line # 50 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to include(image: nil)
    ```

  * **Line # 55 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe V1::Menu::AllergensController, type: :controller do
    ```

  * **Line # 63 - convention:** Performance/TimesMap: Use `Array.new(count)` with a block instead of `.times.map` only if `count` is always 0 or more.

    ```rb
        items = count.times.map do |_i| ...
    ```

  * **Line # 112 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:items].size).to eq 10 }
    ```

  * **Line # 113 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:total_count]).to eq 30 }
    ```

  * **Line # 114 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:current_page]).to eq 1 }
    ```

  * **Line # 115 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:per_page]).to eq 10 }
    ```

  * **Line # 123 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:items].size).to eq 3 }
    ```

  * **Line # 124 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:total_count]).to eq 10 }
    ```

  * **Line # 125 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:current_page]).to eq 1 }
    ```

  * **Line # 126 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:per_page]).to eq 3 }
    ```

  * **Line # 134 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:items].size).to eq 3 }
    ```

  * **Line # 135 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:total_count]).to eq 10 }
    ```

  * **Line # 136 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:current_page]).to eq 2 }
    ```

  * **Line # 137 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:per_page]).to eq 3 }
    ```

  * **Line # 146 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              it { expect(@page1).to eq @offset0 }
    ```

  * **Line # 146 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              it { expect(@page1).to eq @offset0 }
    ```

  * **Line # 155 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:items].size).to eq 1 }
    ```

  * **Line # 156 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:total_count]).to eq 10 }
    ```

  * **Line # 157 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:current_page]).to eq 4 }
    ```

  * **Line # 158 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:per_page]).to eq 3 }
    ```

  * **Line # 166 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:items].size).to eq 0 }
    ```

  * **Line # 167 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:total_count]).to eq 10 }
    ```

  * **Line # 168 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:current_page]).to eq 10 }
    ```

  * **Line # 169 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:per_page]).to eq 3 }
    ```

  * **Line # 180 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              @items
    ```

  * **Line # 183 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.length).to eq 10 }
    ```

  * **Line # 184 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject).to all(be_a(Hash)) }
    ```

  * **Line # 185 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.pluck(:id).uniq.count).to eq 10 }
    ```

  * **Line # 204 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject).to be_a(Hash) }
    ```

  * **Line # 205 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(Menu::Allergen.find(subject[:id])).to be_a(Menu::Allergen) }
    ```

  * **Line # 234 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.count).to eq 5 }
    ```

  * **Line # 235 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.pluck(:id).uniq.count).to eq 5 }
    ```

  * **Line # 244 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.count).to eq 5 }
    ```

  * **Line # 245 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.pluck(:id).uniq.count).to eq 5 }
    ```

  * **Line # 254 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.count).to eq 1 }
    ```

  * **Line # 255 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.pluck(:id).uniq.count).to eq 1 }
    ```

  * **Line # 256 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.first[:name]).to eq "Allergen #1!!!" }
    ```

  * **Line # 265 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.count).to eq 1 }
    ```

  * **Line # 266 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.pluck(:id).uniq.count).to eq 1 }
    ```

  * **Line # 267 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.first[:name]).to eq "Allergen #1!!!" }
    ```

  * **Line # 268 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.first[:description]).to eq "Description for #1!!!" }
    ```

  * **Line # 277 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.count).to eq 1 }
    ```

  * **Line # 278 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.pluck(:id).uniq.count).to eq 1 }
    ```

  * **Line # 279 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.first[:name]).to eq "Allergen #5!!!" }
    ```

  * **Line # 280 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.first[:description]).to eq "Description for #5!!!" }
    ```

  * **Line # 297 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject).to all(include(status: "active")) }
    ```

  * **Line # 298 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.size).to eq 1 }
    ```

  * **Line # 359 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [367]

    ```rb
        context "when passing a invalid id" do ...
    ```

  * **Line # 367 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [359]

    ```rb
        context "when passing a invalid id" do ...
    ```

  * **Line # 410 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject[:translations]).to include(name: Hash) }
    ```

  * **Line # 411 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.dig(:translations, :name)).to include(en: "test") }
    ```

  * **Line # 419 - convention:** Rails/I18nLocaleAssignment: Use `I18n.with_locale` with block instead of `I18n.locale=`.

    ```rb
            I18n.locale = (I18n.available_locales - [I18n.default_locale]).sample
    ```

  * **Line # 426 - convention:** Rails/I18nLocaleAssignment: Use `I18n.with_locale` with block instead of `I18n.locale=`.

    ```rb
            I18n.locale = @initial_lang
    ```

  * **Line # 426 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
            I18n.locale = @initial_lang
    ```

### spec/controllers/v1/menu/categories_controller_spec.rb - (126 offenses)
  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe V1::Menu::CategoriesController, type: :controller do
    ```

  * **Line # 56 - convention:** Layout/LineLength: Line is too long. [123/120]

    ```rb
        context "filtering for { skip_empty_categories: true } and categories are actually empty (no dishes, no categories)" do
    ```

  * **Line # 69 - convention:** Layout/LineLength: Line is too long. [126/120]

    ```rb
        context "filtering for { skip_empty_categories: true } and some categories have dishes, other have children categories" do
    ```

  * **Line # 124 - convention:** Layout/LineLength: Line is too long. [140/120]

    ```rb
          context "when public visibility is enabled but current time is out of absolute timezone (from: #{from.inspect}, to: #{to.inspect})" do
    ```

  * **Line # 176 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:items].size).to eq 10 }
    ```

  * **Line # 177 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:total_count]).to eq 30 }
    ```

  * **Line # 178 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:current_page]).to eq 1 }
    ```

  * **Line # 179 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:per_page]).to eq 10 }
    ```

  * **Line # 187 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:items].size).to eq 3 }
    ```

  * **Line # 188 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:total_count]).to eq 10 }
    ```

  * **Line # 189 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:current_page]).to eq 1 }
    ```

  * **Line # 190 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:per_page]).to eq 3 }
    ```

  * **Line # 198 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:items].size).to eq 3 }
    ```

  * **Line # 199 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:total_count]).to eq 10 }
    ```

  * **Line # 200 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:current_page]).to eq 2 }
    ```

  * **Line # 201 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:per_page]).to eq 3 }
    ```

  * **Line # 210 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              it { expect(@page1).to eq @offset0 }
    ```

  * **Line # 210 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              it { expect(@page1).to eq @offset0 }
    ```

  * **Line # 219 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:items].size).to eq 1 }
    ```

  * **Line # 220 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:total_count]).to eq 10 }
    ```

  * **Line # 221 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:current_page]).to eq 4 }
    ```

  * **Line # 222 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:per_page]).to eq 3 }
    ```

  * **Line # 230 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:items].size).to eq 0 }
    ```

  * **Line # 231 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:total_count]).to eq 10 }
    ```

  * **Line # 232 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:current_page]).to eq 10 }
    ```

  * **Line # 233 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:per_page]).to eq 3 }
    ```

  * **Line # 244 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              @items
    ```

  * **Line # 247 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.length).to eq 10 }
    ```

  * **Line # 248 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject).to all(be_a(Hash)) }
    ```

  * **Line # 249 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.pluck(:id).uniq.count).to eq 10 }
    ```

  * **Line # 265 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject).to be_a(Array) }
    ```

  * **Line # 266 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.count).to eq 2 }
    ```

  * **Line # 267 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[0][:index]).to eq 0 }
    ```

  * **Line # 268 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[1][:index]).to eq 1 }
    ```

  * **Line # 283 - convention:** Rails/SkipsModelValidations: Avoid using `update_all` because it skips validations.

    ```rb
              Menu::Visibility.update_all(public_visible: true)
    ```

  * **Line # 289 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject).to be_a(Array) }
    ```

  * **Line # 290 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.pluck(:id)).to eq Menu::Category.order(:index).pluck(:id) }
    ```

  * **Line # 300 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
            req(except: @excluded.id)
    ```

  * **Line # 306 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.count).to eq 1 }
    ```

  * **Line # 307 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.pluck(:id).uniq.count).to eq 1 }
    ```

  * **Line # 308 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.first[:id]).to eq Menu::Category.last.id }
    ```

  * **Line # 312 - convention:** Performance/CollectionLiteralInLoop: Avoid immutable Array literals in loops. It is better to extract it into a local variable or a constant.

    ```rb
          ["true", "t", "1", true, 1].each do |param_value|
    ```

  * **Line # 313 - convention:** Layout/LineLength: Line is too long. [133/120]

    ```rb
            context "when filtering by { #{param_name.inspect}: #{param_value.inspect} } should return only categories without parent" do
    ```

  * **Line # 317 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
              let!(:children) { create_list(:menu_category, 2, parent:, visibility: nil) }
    ```

  * **Line # 327 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.count).to eq 1 }
    ```

  * **Line # 328 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.pluck(:id).uniq).to match_array(Menu::Category.without_parent.pluck(:id)) }
    ```

  * **Line # 329 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.pluck(:parent_id)).to all(be_nil) }
    ```

  * **Line # 349 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject).to be_a(Hash) }
    ```

  * **Line # 350 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(Menu::Category.find(subject[:id])).to be_a(Menu::Category) }
    ```

  * **Line # 358 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject).to include(
    ```

  * **Line # 365 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject[:images].count).to eq 2 }
    ```

  * **Line # 371 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
            create_list(:menu_category, 2, visibility: nil, parent: @parent)
    ```

  * **Line # 382 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
            before { req(parent_id: @parent.id) }
    ```

  * **Line # 387 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.count).to eq 2 }
    ```

  * **Line # 388 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.pluck(:id).uniq.count).to eq 2 }
    ```

  * **Line # 391 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(Menu::Category.where(id: subject.pluck(:id).uniq).pluck(:id)).to match_array(Menu::Category.where(parent: @parent).pluck(:id))
    ```

  * **Line # 391 - convention:** Layout/LineLength: Line is too long. [145/120]

    ```rb
                expect(Menu::Category.where(id: subject.pluck(:id).uniq).pluck(:id)).to match_array(Menu::Category.where(parent: @parent).pluck(:id))
    ```

  * **Line # 391 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
                expect(Menu::Category.where(id: subject.pluck(:id).uniq).pluck(:id)).to match_array(Menu::Category.where(parent: @parent).pluck(:id))
    ```

  * **Line # 398 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject[:total_count]).to eq 2 }
    ```

  * **Line # 399 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject[:current_page]).to eq 1 }
    ```

  * **Line # 400 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject[:per_page]).to eq 10 }
    ```

  * **Line # 401 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject[:params]).to be_a(Hash) }
    ```

  * **Line # 402 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject[:params]).to include("parent_id" => @parent.id) }
    ```

  * **Line # 402 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              it { expect(subject[:params]).to include("parent_id" => @parent.id) }
    ```

  * **Line # 412 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.count).to eq 3 }
    ```

  * **Line # 413 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.pluck(:id).uniq.count).to eq 3 }
    ```

  * **Line # 416 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(Menu::Category.where(id: subject.pluck(:id).uniq).pluck(:id)).to match_array(Menu::Category.where(parent_id: nil).pluck(:id))
    ```

  * **Line # 416 - convention:** Layout/LineLength: Line is too long. [144/120]

    ```rb
                expect(Menu::Category.where(id: subject.pluck(:id).uniq).pluck(:id)).to match_array(Menu::Category.where(parent_id: nil).pluck(:id))
    ```

  * **Line # 423 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject[:total_count]).to eq 3 }
    ```

  * **Line # 424 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject[:current_page]).to eq 1 }
    ```

  * **Line # 425 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject[:per_page]).to eq 10 }
    ```

  * **Line # 426 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject[:params]).to be_a(Hash) }
    ```

  * **Line # 427 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject[:params]).to include("parent_id" => "") }
    ```

  * **Line # 435 - warning:** Lint/UselessAssignment: Useless assignment to variable - `items`.

    ```rb
            items = 5.times.map do |i|
    ```

  * **Line # 435 - convention:** Performance/TimesMap: Use `Array.new(5)` with a block instead of `.times.map`.

    ```rb
            items = 5.times.map do |i| ...
    ```

  * **Line # 457 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.count).to eq 5 }
    ```

  * **Line # 458 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.pluck(:id).uniq.count).to eq 5 }
    ```

  * **Line # 467 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.count).to eq 5 }
    ```

  * **Line # 468 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.pluck(:id).uniq.count).to eq 5 }
    ```

  * **Line # 477 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.count).to eq 1 }
    ```

  * **Line # 478 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.pluck(:id).uniq.count).to eq 1 }
    ```

  * **Line # 479 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.first[:name]).to eq "Category #1!!!" }
    ```

  * **Line # 488 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.count).to eq 1 }
    ```

  * **Line # 489 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.pluck(:id).uniq.count).to eq 1 }
    ```

  * **Line # 490 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.first[:name]).to eq "Category #1!!!" }
    ```

  * **Line # 491 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.first[:description]).to eq "Description for #1!!!" }
    ```

  * **Line # 500 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.count).to eq 1 }
    ```

  * **Line # 501 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.pluck(:id).uniq.count).to eq 1 }
    ```

  * **Line # 502 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.first[:name]).to eq "Category #5!!!" }
    ```

  * **Line # 503 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.first[:description]).to eq "Description for #5!!!" }
    ```

  * **Line # 510 - warning:** Lint/UselessAssignment: Useless assignment to variable - `items`.

    ```rb
            items = 5.times.map do |i|
    ```

  * **Line # 510 - convention:** Performance/TimesMap: Use `Array.new(5)` with a block instead of `.times.map`.

    ```rb
            items = 5.times.map do |i| ...
    ```

  * **Line # 522 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it do
    ```

  * **Line # 523 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject.map(&:price).uniq).to contain_exactly(nil, 10, 20, 30, 40, 50)
    ```

  * **Line # 524 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject.map(&:price?)).to match_array(([false] * 5) + ([true] * 5))
    ```

  * **Line # 525 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject.count).to eq 10
    ```

  * **Line # 535 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.count).to eq 5 }
    ```

  * **Line # 536 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.pluck(:id).uniq.count).to eq 5 }
    ```

  * **Line # 537 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.pluck(:price).uniq).to all(be_positive) }
    ```

  * **Line # 538 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.pluck(:price).uniq).to all(be_a(Numeric)) }
    ```

  * **Line # 553 - warning:** Lint/UselessAssignment: Useless assignment to variable - `items`.

    ```rb
            items = 5.times.map do |i|
    ```

  * **Line # 553 - convention:** Performance/TimesMap: Use `Array.new(5)` with a block instead of `.times.map`.

    ```rb
            items = 5.times.map do |i| ...
    ```

  * **Line # 565 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it do
    ```

  * **Line # 566 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject.map(&:price).uniq).to contain_exactly(nil, 10, 20, 30, 40, 50)
    ```

  * **Line # 567 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject.map(&:price?)).to match_array(([false] * 5) + ([true] * 5))
    ```

  * **Line # 568 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject.count).to eq 10
    ```

  * **Line # 578 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.count).to eq 5 }
    ```

  * **Line # 579 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.pluck(:id).uniq.count).to eq 5 }
    ```

  * **Line # 580 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.pluck(:price).uniq).to eq [nil] }
    ```

  * **Line # 605 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject).to all(include(status: "active")) }
    ```

  * **Line # 606 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.size).to eq 1 }
    ```

  * **Line # 700 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject).to include(
    ```

  * **Line # 707 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject[:images].count).to eq 0 }
    ```

  * **Line # 720 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
          it do
    ```

  * **Line # 721 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject).to include(translations: Hash)
    ```

  * **Line # 722 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject[:translations]).to include(name: Hash)
    ```

  * **Line # 723 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.dig(:translations, :name)).to include(en: "test-en")
    ```

  * **Line # 724 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.dig(:translations, :name)).to include(it: "test-it")
    ```

  * **Line # 728 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [736]

    ```rb
        context "when passing a invalid id" do ...
    ```

  * **Line # 736 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [728]

    ```rb
        context "when passing a invalid id" do ...
    ```

  * **Line # 757 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject).to include(
    ```

  * **Line # 764 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject[:images].count).to eq 2 }
    ```

  * **Line # 781 - convention:** RSpec/ExampleLength: Example has too many lines. [6/5]

    ```rb
          it { ...
    ```

  * **Line # 782 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject).to include(
    ```

  * **Line # 813 - convention:** Rails/I18nLocaleAssignment: Use `I18n.with_locale` with block instead of `I18n.locale=`.

    ```rb
            I18n.locale = (I18n.available_locales - [I18n.default_locale]).sample
    ```

  * **Line # 819 - convention:** Rails/I18nLocaleAssignment: Use `I18n.with_locale` with block instead of `I18n.locale=`.

    ```rb
          after { I18n.locale = I18n.default_locale }
    ```

### spec/controllers/v1/menu/dishes_controller/dishes_controller.index_spec.rb - (104 offenses)
  * **Line # 5 - convention:** RSpec/FilePath: Spec path should end with `v1/menu/dishes_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Menu::DishesController do
    ```

  * **Line # 5 - convention:** RSpec/SpecFilePathFormat: Spec path should end with `v1/menu/dishes_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Menu::DishesController do
    ```

  * **Line # 15 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:get, "/v1/menu/dishes").to(format: :json, action: :index,
    ```

  * **Line # 92 - convention:** Layout/LineLength: Line is too long. [125/120]

    ```rb
              expect(item[:images].map(&:symbolize_keys)).to all(include(id: Integer, filename: String, status: String, tag: nil,
    ```

  * **Line # 93 - convention:** Layout/LineLength: Line is too long. [150/120]

    ```rb
                                                                         original_id: nil, key: nil, url: String, updated_at: String, created_at: String))
    ```

  * **Line # 177 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it do
    ```

  * **Line # 178 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).not_to include(message: String)
    ```

  * **Line # 179 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to include(items: Array)
    ```

  * **Line # 180 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject[:items].count).to eq 1
    ```

  * **Line # 220 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.size).to eq 1 }
    ```

  * **Line # 244 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.size).to eq 1 }
    ```

  * **Line # 262 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.size).to eq 1 }
    ```

  * **Line # 263 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.first[:status]).to eq "active" }
    ```

  * **Line # 297 - convention:** Rails/UniqBeforePluck: Use `distinct` before `pluck`.

    ```rb
          it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(15, 16) }
    ```

  * **Line # 298 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.size).to eq 2 }
    ```

  * **Line # 302 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [320]

    ```rb
        context 'when filtering by price {price: "15.5"}' do ...
    ```

  * **Line # 316 - convention:** Rails/UniqBeforePluck: Use `distinct` before `pluck`.

    ```rb
          it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(15, 16) }
    ```

  * **Line # 317 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.size).to eq 0 }
    ```

  * **Line # 320 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [302]

    ```rb
        context 'when filtering by price {price: "15.5"}' do ...
    ```

  * **Line # 334 - convention:** Rails/UniqBeforePluck: Use `distinct` before `pluck`.

    ```rb
          it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(15.5, 15, 16) }
    ```

  * **Line # 335 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.size).to eq 1 }
    ```

  * **Line # 353 - convention:** Rails/UniqBeforePluck: Use `distinct` before `pluck`.

    ```rb
          it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(15, 15.5, 16) }
    ```

  * **Line # 354 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.size).to eq 1 }
    ```

  * **Line # 372 - convention:** Rails/UniqBeforePluck: Use `distinct` before `pluck`.

    ```rb
          it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(8, 10, 12) }
    ```

  * **Line # 373 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.size).to eq 2 }
    ```

  * **Line # 375 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.pluck(:price)).to contain_exactly(8, 10) }
    ```

  * **Line # 392 - convention:** Rails/UniqBeforePluck: Use `distinct` before `pluck`.

    ```rb
          it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(8, 10, 12) }
    ```

  * **Line # 393 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.size).to eq 2 }
    ```

  * **Line # 395 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.pluck(:price)).to contain_exactly(10, 12) }
    ```

  * **Line # 412 - convention:** Rails/UniqBeforePluck: Use `distinct` before `pluck`.

    ```rb
          it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(8, 10, 12) }
    ```

  * **Line # 413 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.size).to eq 1 }
    ```

  * **Line # 431 - convention:** Rails/UniqBeforePluck: Use `distinct` before `pluck`.

    ```rb
          it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(8, 10, 12) }
    ```

  * **Line # 432 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.size).to eq 1 }
    ```

  * **Line # 451 - convention:** Rails/UniqBeforePluck: Use `distinct` before `pluck`.

    ```rb
          it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(8, 10, 12, 14) }
    ```

  * **Line # 452 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.size).to eq 2 }
    ```

  * **Line # 453 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.pluck(:price)).to contain_exactly(10, 12) }
    ```

  * **Line # 471 - convention:** Rails/UniqBeforePluck: Use `distinct` before `pluck`.

    ```rb
          it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(8, 10, 12, 14) }
    ```

  * **Line # 472 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.size).to eq 1 }
    ```

  * **Line # 473 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.pluck(:price)).to contain_exactly(10) }
    ```

  * **Line # 477 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
          let(:category0) { create(:menu_category) }
    ```

  * **Line # 478 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
          let(:category1) { create(:menu_category) }
    ```

  * **Line # 494 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it do
    ```

  * **Line # 503 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
          let(:dish0) { create(:menu_dish) }
    ```

  * **Line # 504 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
          let(:dish1) { create(:menu_dish) }
    ```

  * **Line # 519 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it do
    ```

  * **Line # 527 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
          let!(:dish0) { create(:menu_dish, price: 15) }
    ```

  * **Line # 528 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
          let!(:dish1) { create(:menu_dish, price: nil) }
    ```

  * **Line # 528 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
          let!(:dish1) { create(:menu_dish, price: nil) }
    ```

  * **Line # 529 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
          let!(:dish2) { create(:menu_dish, price: 0) }
    ```

  * **Line # 535 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it do
    ```

  * **Line # 540 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it do
    ```

  * **Line # 547 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
          let!(:dish0) { create(:menu_dish, price: 15) }
    ```

  * **Line # 547 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
          let!(:dish0) { create(:menu_dish, price: 15) }
    ```

  * **Line # 548 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
          let!(:dish2) { create(:menu_dish, price: 0) }
    ```

  * **Line # 549 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
          let!(:dish3) { create(:menu_dish, price: 25) }
    ```

  * **Line # 550 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
          let!(:dish4) { create(:menu_dish, price: 14.9) }
    ```

  * **Line # 556 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it do
    ```

  * **Line # 561 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it do
    ```

  * **Line # 568 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
          let!(:dish0) { create(:menu_dish, price: 15) }
    ```

  * **Line # 568 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
          let!(:dish0) { create(:menu_dish, price: 15) }
    ```

  * **Line # 569 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
          let!(:dish1) { create(:menu_dish, price: nil) }
    ```

  * **Line # 570 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
          let!(:dish2) { create(:menu_dish, price: 0) }
    ```

  * **Line # 570 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
          let!(:dish2) { create(:menu_dish, price: 0) }
    ```

  * **Line # 576 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it do
    ```

  * **Line # 581 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it do
    ```

  * **Line # 588 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
          let!(:dish0) { create(:menu_dish, price: 15) }
    ```

  * **Line # 589 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
          let!(:dish1) { create(:menu_dish, price: nil) }
    ```

  * **Line # 589 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
          let!(:dish1) { create(:menu_dish, price: nil) }
    ```

  * **Line # 590 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
          let!(:dish2) { create(:menu_dish, price: 0) }
    ```

  * **Line # 590 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
          let!(:dish2) { create(:menu_dish, price: 0) }
    ```

  * **Line # 591 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
          let!(:dish3) { create(:menu_dish, price: 25) }
    ```

  * **Line # 591 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
          let!(:dish3) { create(:menu_dish, price: 25) }
    ```

  * **Line # 597 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it do
    ```

  * **Line # 602 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it do
    ```

  * **Line # 609 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
          let!(:dish0) { create(:menu_dish, price: 15) }
    ```

  * **Line # 610 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
          let!(:dish1) { create(:menu_dish, price: nil) }
    ```

  * **Line # 610 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
          let!(:dish1) { create(:menu_dish, price: nil) }
    ```

  * **Line # 611 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
          let!(:dish2) { create(:menu_dish, price: 0) }
    ```

  * **Line # 611 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
          let!(:dish2) { create(:menu_dish, price: 0) }
    ```

  * **Line # 612 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
          let!(:dish3) { create(:menu_dish, price: 25) }
    ```

  * **Line # 613 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
          let!(:dish4) { create(:menu_dish, price: 14.9) }
    ```

  * **Line # 613 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
          let!(:dish4) { create(:menu_dish, price: 14.9) }
    ```

  * **Line # 619 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it do
    ```

  * **Line # 624 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it do
    ```

  * **Line # 631 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
          let!(:dish0) { create(:menu_dish, price: 15) }
    ```

  * **Line # 632 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
          let!(:dish1) { create(:menu_dish, price: nil) }
    ```

  * **Line # 632 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
          let!(:dish1) { create(:menu_dish, price: nil) }
    ```

  * **Line # 633 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
          let!(:dish2) { create(:menu_dish, price: 0) }
    ```

  * **Line # 634 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
          let!(:dish3) { create(:menu_dish, price: 25) }
    ```

  * **Line # 635 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
          let!(:dish4) { create(:menu_dish, price: 100) }
    ```

  * **Line # 635 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
          let!(:dish4) { create(:menu_dish, price: 100) }
    ```

  * **Line # 641 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it do
    ```

  * **Line # 646 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it do
    ```

  * **Line # 676 - convention:** Layout/LineLength: Line is too long. [145/120]

    ```rb
        context "when filtering by {can_suggest: <dish_id>} will return dishes that can be added as suggestions for the dish with the provided id" do
    ```

  * **Line # 679 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
          let!(:deleted_dish) { create(:menu_dish, status: :deleted) }
    ```

  * **Line # 689 - convention:** Layout/LineLength: Line is too long. [151/120]

    ```rb
        context "when filtering by {except_in_category: <category_id>}, should return all items except those who are added in the provided category id." do
    ```

  * **Line # 690 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
          let!(:dishes) { create_list(:menu_dish, 3) }
    ```

  * **Line # 703 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
          it do
    ```

  * **Line # 710 - convention:** Layout/LineLength: Line is too long. [169/120]

    ```rb
        context "when filtering by {except_in_category: \"<category_id>,<category_id>\"}, should return all items except those who are added in the provided category id." do
    ```

  * **Line # 711 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
          let!(:dishes) { create_list(:menu_dish, 3) }
    ```

  * **Line # 713 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
          let!(:category0) do ...
    ```

  * **Line # 720 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
          let!(:category1) do ...
    ```

  * **Line # 731 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
          it do
    ```

  * **Line # 740 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
          let!(:dishes) { create_list(:menu_dish, 3) }
    ```

### spec/controllers/v1/menu/dishes_controller/dishes_controller.show_spec.rb - (11 offenses)
  * **Line # 5 - convention:** RSpec/FilePath: Spec path should end with `v1/menu/dishes_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Menu::DishesController do
    ```

  * **Line # 5 - convention:** RSpec/SpecFilePathFormat: Spec path should end with `v1/menu/dishes_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Menu::DishesController do
    ```

  * **Line # 33 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject).to include(id: Integer, name: nil, description: nil) }
    ```

  * **Line # 36 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [44]

    ```rb
        context "when passing a invalid id" do ...
    ```

  * **Line # 44 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [36]

    ```rb
        context "when passing a invalid id" do ...
    ```

  * **Line # 76 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject).to include(images: Array) }
    ```

  * **Line # 97 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject[:translations]).to include(name: Hash) }
    ```

  * **Line # 98 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.dig(:translations, :name)).to include(en: "test") }
    ```

  * **Line # 106 - convention:** Rails/I18nLocaleAssignment: Use `I18n.with_locale` with block instead of `I18n.locale=`.

    ```rb
            I18n.locale = (I18n.available_locales - [I18n.default_locale]).sample
    ```

  * **Line # 113 - convention:** Rails/I18nLocaleAssignment: Use `I18n.with_locale` with block instead of `I18n.locale=`.

    ```rb
            I18n.locale = @initial_lang
    ```

  * **Line # 113 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
            I18n.locale = @initial_lang
    ```

### spec/controllers/v1/menu/ingredients_controller_spec.rb - (9 offenses)
  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe V1::Menu::IngredientsController, type: :controller do
    ```

  * **Line # 15 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:get, "/v1/menu/ingredients").to(format: :json, action: :index,
    ```

  * **Line # 86 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.size).to eq 1 }
    ```

  * **Line # 110 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.size).to eq 1 }
    ```

  * **Line # 128 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.size).to eq 1 }
    ```

  * **Line # 129 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject).to all(include(status: "active")) }
    ```

  * **Line # 147 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.size).to eq 1 }
    ```

  * **Line # 148 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.first[:status]).to eq "active" }
    ```

  * **Line # 206 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:get, "/v1/menu/ingredients/1").to(format: :json, action: :show,
    ```

### spec/controllers/v1/menu/tags_controller_spec.rb - (61 offenses)
  * **Line # 8 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
        expect(subject).to include(
    ```

  * **Line # 17 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to include(
    ```

  * **Line # 23 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to include(
    ```

  * **Line # 31 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to include(
    ```

  * **Line # 37 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to include(
    ```

  * **Line # 45 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject[:image]).to be_a(Hash)
    ```

  * **Line # 50 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to include(image: nil)
    ```

  * **Line # 56 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to include(color: String)
    ```

  * **Line # 60 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to include(color: nil)
    ```

  * **Line # 65 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe V1::Menu::TagsController, type: :controller do
    ```

  * **Line # 73 - convention:** Performance/TimesMap: Use `Array.new(count)` with a block instead of `.times.map` only if `count` is always 0 or more.

    ```rb
        items = count.times.map do |_i| ...
    ```

  * **Line # 124 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:items].size).to eq 10 }
    ```

  * **Line # 125 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:total_count]).to eq 30 }
    ```

  * **Line # 126 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:current_page]).to eq 1 }
    ```

  * **Line # 127 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:per_page]).to eq 10 }
    ```

  * **Line # 135 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:items].size).to eq 3 }
    ```

  * **Line # 136 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:total_count]).to eq 10 }
    ```

  * **Line # 137 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:current_page]).to eq 1 }
    ```

  * **Line # 138 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:per_page]).to eq 3 }
    ```

  * **Line # 146 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:items].size).to eq 3 }
    ```

  * **Line # 147 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:total_count]).to eq 10 }
    ```

  * **Line # 148 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:current_page]).to eq 2 }
    ```

  * **Line # 149 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:per_page]).to eq 3 }
    ```

  * **Line # 158 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              it { expect(@page1).to eq @offset0 }
    ```

  * **Line # 158 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              it { expect(@page1).to eq @offset0 }
    ```

  * **Line # 167 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:items].size).to eq 1 }
    ```

  * **Line # 168 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:total_count]).to eq 10 }
    ```

  * **Line # 169 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:current_page]).to eq 4 }
    ```

  * **Line # 170 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:per_page]).to eq 3 }
    ```

  * **Line # 178 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:items].size).to eq 0 }
    ```

  * **Line # 179 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:total_count]).to eq 10 }
    ```

  * **Line # 180 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:current_page]).to eq 10 }
    ```

  * **Line # 181 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:per_page]).to eq 3 }
    ```

  * **Line # 192 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              @items
    ```

  * **Line # 195 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.length).to eq 10 }
    ```

  * **Line # 196 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject).to all(be_a(Hash)) }
    ```

  * **Line # 197 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.pluck(:id).uniq.count).to eq 10 }
    ```

  * **Line # 216 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject).to be_a(Hash) }
    ```

  * **Line # 217 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(Menu::Tag.find(subject[:id])).to be_a(Menu::Tag) }
    ```

  * **Line # 246 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.count).to eq 5 }
    ```

  * **Line # 247 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.pluck(:id).uniq.count).to eq 5 }
    ```

  * **Line # 256 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.count).to eq 5 }
    ```

  * **Line # 257 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.pluck(:id).uniq.count).to eq 5 }
    ```

  * **Line # 266 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.count).to eq 1 }
    ```

  * **Line # 267 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.pluck(:id).uniq.count).to eq 1 }
    ```

  * **Line # 268 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.first[:name]).to eq "Tag #1!!!" }
    ```

  * **Line # 277 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.count).to eq 1 }
    ```

  * **Line # 278 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.pluck(:id).uniq.count).to eq 1 }
    ```

  * **Line # 279 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.first[:name]).to eq "Tag #1!!!" }
    ```

  * **Line # 280 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.first[:description]).to eq "Description for #1!!!" }
    ```

  * **Line # 289 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.count).to eq 1 }
    ```

  * **Line # 290 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.pluck(:id).uniq.count).to eq 1 }
    ```

  * **Line # 291 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.first[:name]).to eq "Tag #5!!!" }
    ```

  * **Line # 292 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.first[:description]).to eq "Description for #5!!!" }
    ```

  * **Line # 309 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject).to all(include(status: "active")) }
    ```

  * **Line # 310 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.size).to eq 1 }
    ```

  * **Line # 371 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [379]

    ```rb
        context "when passing a invalid id" do ...
    ```

  * **Line # 379 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [371]

    ```rb
        context "when passing a invalid id" do ...
    ```

  * **Line # 428 - convention:** Rails/I18nLocaleAssignment: Use `I18n.with_locale` with block instead of `I18n.locale=`.

    ```rb
            I18n.locale = (I18n.available_locales - [I18n.default_locale]).sample
    ```

  * **Line # 435 - convention:** Rails/I18nLocaleAssignment: Use `I18n.with_locale` with block instead of `I18n.locale=`.

    ```rb
            I18n.locale = @initial_lang
    ```

  * **Line # 435 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
            I18n.locale = @initial_lang
    ```

### spec/controllers/v1/public_data_controller_spec.rb - (3 offenses)
  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe V1::PublicDataController, type: :controller do
    ```

  * **Line # 90 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
            allow_any_instance_of(ActionDispatch::Request).to receive(:cookies).and_return(Reservation::PUBLIC_CREATE_COOKIE => secret)
    ```

  * **Line # 90 - convention:** Layout/LineLength: Line is too long. [131/120]

    ```rb
            allow_any_instance_of(ActionDispatch::Request).to receive(:cookies).and_return(Reservation::PUBLIC_CREATE_COOKIE => secret)
    ```

### spec/controllers/v1/reservations_controller_spec.rb - (166 offenses)
  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe V1::ReservationsController, type: :controller do
    ```

  * **Line # 50 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:post, "/v1/reservations").to(format: :json, action: :create,
    ```

  * **Line # 62 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
          it { expect { req }.to change { Reservation.count }.by(1) }
    ```

  * **Line # 64 - convention:** RSpec/MissingExampleGroupArgument: The first argument to `context` should not be empty.

    ```rb
          context do ...
    ```

  * **Line # 76 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
          it { expect { req }.to change { Reservation.count }.by(1) }
    ```

  * **Line # 78 - convention:** RSpec/MissingExampleGroupArgument: The first argument to `context` should not be empty.

    ```rb
          context do ...
    ```

  * **Line # 90 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
          it { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 92 - convention:** RSpec/MissingExampleGroupArgument: The first argument to `context` should not be empty.

    ```rb
          context do ...
    ```

  * **Line # 108 - convention:** Layout/LineLength: Line is too long. [129/120]

    ```rb
          context "when providing a #{scenario[:name]} date, should create a reservation for turn with weekday=#{scenario[:wday]}" do
    ```

  * **Line # 110 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:turn) do
    ```

  * **Line # 120 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
          let!(:turn) do
    ```

  * **Line # 139 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { doit }.to(change { Reservation.count }) }
    ```

  * **Line # 156 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
              it { expect { doit }.to(change { Reservation.count }) }
    ```

  * **Line # 174 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
              it { expect { doit }.not_to(change { Reservation.count }) }
    ```

  * **Line # 190 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
          let!(:turn) do
    ```

  * **Line # 261 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it do
    ```

  * **Line # 287 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it do
    ```

  * **Line # 294 - convention:** Layout/LineLength: Line is too long. [122/120]

    ```rb
        context "when a 'weekly' Holiday exists (closed only on the morning while the reservation is made for the evening)" do
    ```

  * **Line # 295 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
          let!(:holiday) do
    ```

  * **Line # 308 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it do
    ```

  * **Line # 323 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
              it do
    ```

  * **Line # 333 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
          let!(:holiday) do
    ```

  * **Line # 346 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it do
    ```

  * **Line # 356 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
          it { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 358 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it do
    ```

  * **Line # 369 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.to(change { Reservation.count }.by(1)) }
    ```

  * **Line # 372 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 384 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 386 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 401 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.to change { Reservation.count }.by(1) }
    ```

  * **Line # 403 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it do
    ```

  * **Line # 414 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.to change { Reservation.count }.by(1) }
    ```

  * **Line # 416 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it do
    ```

  * **Line # 438 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.to change { Reservation.count }.by(1) }
    ```

  * **Line # 440 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it do
    ```

  * **Line # 451 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.to change { Reservation.count }.by(1) }
    ```

  * **Line # 453 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it do
    ```

  * **Line # 465 - convention:** Layout/LineLength: Line is too long. [127/120]

    ```rb
                         "#{Config.app.dig!(:nexi_api_url)}/#{Config.app.dig!(:nexi_simple_payment_path)}").to_return do |_request|
    ```

  * **Line # 468 - convention:** Rails/FilePath: Prefer `Rails.root.join('path/to')`.

    ```rb
                body: File.read(Rails.root.join("spec", "fixtures", "nexi-error-page.html"))
    ```

  * **Line # 490 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 491 - convention:** RSpec/ExpectChange: Prefer `change(ReservationPayment, :count)`.

    ```rb
            it { expect { req }.not_to(change { ReservationPayment.count }) }
    ```

  * **Line # 492 - convention:** RSpec/ExpectChange: Prefer `change(Nexi::HttpRequest, :count)`.

    ```rb
            it { expect { req }.to(change { Nexi::HttpRequest.count }.by(1)) }
    ```

  * **Line # 495 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 506 - convention:** Layout/LineLength: Line is too long. [127/120]

    ```rb
                         "#{Config.app.dig!(:nexi_api_url)}/#{Config.app.dig!(:nexi_simple_payment_path)}").to_return do |_request|
    ```

  * **Line # 531 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 532 - convention:** RSpec/ExpectChange: Prefer `change(ReservationPayment, :count)`.

    ```rb
            it { expect { req }.not_to(change { ReservationPayment.count }) }
    ```

  * **Line # 533 - convention:** RSpec/ExpectChange: Prefer `change(Nexi::HttpRequest, :count)`.

    ```rb
            it { expect { req }.to(change { Nexi::HttpRequest.count }.by(1)) }
    ```

  * **Line # 536 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 547 - convention:** Layout/LineLength: Line is too long. [127/120]

    ```rb
                         "#{Config.app.dig!(:nexi_api_url)}/#{Config.app.dig!(:nexi_simple_payment_path)}").to_return do |_request|
    ```

  * **Line # 555 - convention:** Rails/FilePath: Prefer `Rails.root.join('path/to')`.

    ```rb
            File.read(Rails.root.join("spec", "fixtures", "nexi-unauthorized-page.html"))
    ```

  * **Line # 569 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 570 - convention:** RSpec/ExpectChange: Prefer `change(ReservationPayment, :count)`.

    ```rb
            it { expect { req }.not_to(change { ReservationPayment.count }) }
    ```

  * **Line # 571 - convention:** RSpec/ExpectChange: Prefer `change(Nexi::HttpRequest, :count)`.

    ```rb
            it { expect { req }.to(change { Nexi::HttpRequest.count }.by(1)) }
    ```

  * **Line # 594 - convention:** Layout/LineLength: Line is too long. [127/120]

    ```rb
                         "#{Config.app.dig!(:nexi_api_url)}/#{Config.app.dig!(:nexi_simple_payment_path)}").to_return do |_request|
    ```

  * **Line # 602 - convention:** Rails/FilePath: Prefer `Rails.root.join('path/to')`.

    ```rb
            File.read(Rails.root.join("spec", "fixtures", "nexi-simple-payment-success-page.html"))
    ```

  * **Line # 616 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.to(change { Reservation.count }.by(1)) }
    ```

  * **Line # 617 - convention:** RSpec/ExpectChange: Prefer `change(ReservationPayment, :count)`.

    ```rb
            it { expect { req }.to(change { ReservationPayment.count }.by(1)) }
    ```

  * **Line # 618 - convention:** RSpec/ExpectChange: Prefer `change(Nexi::HttpRequest, :count)`.

    ```rb
            it { expect { req }.to(change { Nexi::HttpRequest.count }.by(1)) }
    ```

  * **Line # 623 - convention:** Layout/LineLength: Line is too long. [128/120]

    ```rb
                                                                               "deliver_now", params: anything, args: anything).once
    ```

  * **Line # 626 - convention:** RSpec/ExampleLength: Example has too many lines. [23/5]

    ```rb
            it do ...
    ```

  * **Line # 626 - convention:** RSpec/MultipleExpectations: Example has too many expectations [22/1].

    ```rb
            it do
    ```

  * **Line # 649 - convention:** Layout/LineLength: Line is too long. [144/120]

    ```rb
              expect(Nexi::HttpRequest.last.request_body.dig!("urlpost")).to eq(Rails.application.routes.url_helpers.nexi_receive_order_outcome_url)
    ```

  * **Line # 652 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 665 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
                it { expect { req }.to(change { Reservation.count }.by(1)) }
    ```

  * **Line # 668 - convention:** RSpec/ExpectChange: Prefer `change(Nexi::HttpRequest, :count)`.

    ```rb
                it { expect { req }.to(change { Nexi::HttpRequest.count }.by(1)) }
    ```

  * **Line # 670 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
                it do
    ```

  * **Line # 676 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
                it do
    ```

  * **Line # 686 - convention:** Style/SingleArgumentDig: Use `Nexi::HttpRequest.last.request_body["languageId"]` instead of `Nexi::HttpRequest.last.request_body.dig("languageId")`.

    ```rb
                  expect(Nexi::HttpRequest.last.request_body.dig("languageId")).to eq(scenario[:code])
    ```

  * **Line # 720 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
                it { expect { req }.to(change { Reservation.count }.by(1)) }
    ```

  * **Line # 721 - convention:** RSpec/ExpectChange: Prefer `change(ReservationPayment, :count)`.

    ```rb
                it { expect { req }.to(change { ReservationPayment.count }.by(1)) }
    ```

  * **Line # 722 - convention:** RSpec/ExpectChange: Prefer `change(Nexi::HttpRequest, :count)`.

    ```rb
                it { expect { req }.to(change { Nexi::HttpRequest.count }.by(1)) }
    ```

  * **Line # 724 - convention:** RSpec/ExampleLength: Example has too many lines. [8/5]

    ```rb
                it do ...
    ```

  * **Line # 724 - convention:** RSpec/MultipleExpectations: Example has too many expectations [7/1].

    ```rb
                it do
    ```

  * **Line # 735 - convention:** RSpec/ExampleLength: Example has too many lines. [6/5]

    ```rb
                it do ...
    ```

  * **Line # 735 - convention:** RSpec/MultipleExpectations: Example has too many expectations [5/1].

    ```rb
                it do
    ```

  * **Line # 744 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
                it do
    ```

  * **Line # 759 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
                it { expect { req }.to(change { Reservation.count }.by(1)) }
    ```

  * **Line # 760 - convention:** RSpec/ExpectChange: Prefer `change(ReservationPayment, :count)`.

    ```rb
                it { expect { req }.not_to(change { ReservationPayment.count }) }
    ```

  * **Line # 761 - convention:** RSpec/ExpectChange: Prefer `change(Nexi::HttpRequest, :count)`.

    ```rb
                it { expect { req }.not_to(change { Nexi::HttpRequest.count }) }
    ```

  * **Line # 773 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
                it do
    ```

  * **Line # 793 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it "creates a reservation" do
    ```

  * **Line # 802 - convention:** Layout/LineLength: Line is too long. [121/120]

    ```rb
                                                                             "deliver_now", params: anything, args: anything)
    ```

  * **Line # 823 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:turn) do
    ```

  * **Line # 828 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "returns 422" do
    ```

  * **Line # 839 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "returns 422" do
    ```

  * **Line # 850 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.to(change { Reservation.count }.by(1)) }
    ```

  * **Line # 867 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.to(change { Reservation.count }.by(1)) }
    ```

  * **Line # 894 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
                it "returns 422" do
    ```

  * **Line # 918 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
                it "returns 422" do
    ```

  * **Line # 933 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
            it "returns 422" do
    ```

  * **Line # 946 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
            it "returns 422" do
    ```

  * **Line # 958 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
            it "returns 422" do
    ```

  * **Line # 971 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
            it "returns 422" do
    ```

  * **Line # 983 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "returns 422" do
    ```

  * **Line # 994 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "returns 422" do
    ```

  * **Line # 1005 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "returns 422" do
    ```

  * **Line # 1016 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "returns 422" do
    ```

  * **Line # 1027 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "returns 422" do
    ```

  * **Line # 1038 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "returns 422" do
    ```

  * **Line # 1049 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.to change { Reservation.count }.by(1) }
    ```

  * **Line # 1051 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "returns 200 and create record" do
    ```

  * **Line # 1061 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.to change { Reservation.count }.by(1) }
    ```

  * **Line # 1063 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "returns 200 and create record" do
    ```

  * **Line # 1073 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.to change { Reservation.count }.by(1) }
    ```

  * **Line # 1075 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "returns 200 and create record" do
    ```

  * **Line # 1082 - convention:** Layout/LineLength: Line is too long. [129/120]

    ```rb
          context 'should create a reservation with "<firstname> <lastname>" as fullname and save the detail in the "other" field' do
    ```

  * **Line # 1086 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
            it "creates a reservation" do
    ```

  * **Line # 1099 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
            it "creates a reservation" do
    ```

  * **Line # 1112 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
            it "creates a reservation" do
    ```

  * **Line # 1121 - convention:** RSpec/RepeatedExampleGroupBody: Repeated context block body on line(s) [1183]

    ```rb
          context "when email is empty" do ...
    ```

  * **Line # 1121 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [1183]

    ```rb
          context "when email is empty" do ...
    ```

  * **Line # 1124 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 1126 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "returns 422" do
    ```

  * **Line # 1134 - convention:** RSpec/RepeatedExampleGroupBody: Repeated context block body on line(s) [1196]

    ```rb
          context "when email is nil" do ...
    ```

  * **Line # 1134 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [1196]

    ```rb
          context "when email is nil" do ...
    ```

  * **Line # 1137 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 1139 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "returns 422" do
    ```

  * **Line # 1147 - convention:** RSpec/RepeatedExampleGroupBody: Repeated context block body on line(s) [1209]

    ```rb
          context "when email is invalid" do ...
    ```

  * **Line # 1147 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [1209]

    ```rb
          context "when email is invalid" do ...
    ```

  * **Line # 1157 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
                it { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 1159 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
                it "returns 422" do
    ```

  * **Line # 1170 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:reservation) { create(:reservation, datetime:, email:) }
    ```

  * **Line # 1172 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 1174 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
            it "returns 422" do
    ```

  * **Line # 1183 - convention:** RSpec/RepeatedExampleGroupBody: Repeated context block body on line(s) [1121]

    ```rb
          context "when email is empty" do ...
    ```

  * **Line # 1183 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [1121]

    ```rb
          context "when email is empty" do ...
    ```

  * **Line # 1186 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 1188 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "returns 422" do
    ```

  * **Line # 1196 - convention:** RSpec/RepeatedExampleGroupBody: Repeated context block body on line(s) [1134]

    ```rb
          context "when email is nil" do ...
    ```

  * **Line # 1196 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [1134]

    ```rb
          context "when email is nil" do ...
    ```

  * **Line # 1199 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 1201 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "returns 422" do
    ```

  * **Line # 1209 - convention:** RSpec/RepeatedExampleGroupBody: Repeated context block body on line(s) [1147]

    ```rb
          context "when email is invalid" do ...
    ```

  * **Line # 1209 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [1147]

    ```rb
          context "when email is invalid" do ...
    ```

  * **Line # 1219 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
                it { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 1221 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
                it "returns 422" do
    ```

  * **Line # 1234 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 1236 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "returns 422" do
    ```

  * **Line # 1247 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 1249 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "returns 422" do
    ```

  * **Line # 1269 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
                it { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 1271 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
                it "returns 422" do
    ```

  * **Line # 1304 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
                it { expect { req }.to change { Reservation.count }.by(1) }
    ```

  * **Line # 1312 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
                it "returns 200" do
    ```

  * **Line # 1339 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:patch, "/v1/reservations/cancel").to(format: :json, action: :cancel,
    ```

  * **Line # 1345 - convention:** Layout/LineLength: Line is too long. [125/120]

    ```rb
                       "#{Config.app.dig!(:nexi_api_url)}/#{Config.app.dig!(:nexi_refund_payment_path)}").to_return do |_request|
    ```

  * **Line # 1365 - convention:** RSpec/ExpectChange: Prefer `change(Log::DeliveredEmail, :count)`.

    ```rb
          it { expect { req }.to change { Log::DeliveredEmail.count }.by(1) }
    ```

  * **Line # 1373 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
              let!(:payment) { create(:reservation_payment, status: payment_status, reservation:) }
    ```

  * **Line # 1375 - convention:** RSpec/ExpectChange: Prefer `change(ReservationPayment, :count)`.

    ```rb
              it  { expect { req }.not_to(change { ReservationPayment.count }) }
    ```

  * **Line # 1376 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
              it  { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 1378 - convention:** RSpec/ExpectChange: Prefer `change(Log::DeliveredEmail, :count)`.

    ```rb
              it { expect { req }.to change { Log::DeliveredEmail.count }.by(1) }
    ```

  * **Line # 1402 - convention:** RSpec/ExpectChange: Prefer `change(ReservationPayment, :count)`.

    ```rb
            it  { expect { req }.not_to(change { ReservationPayment.count }) }
    ```

  * **Line # 1403 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it  { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 1421 - convention:** RSpec/ExpectChange: Prefer `change(ReservationPayment, :count)`.

    ```rb
              it  { expect { req }.not_to(change { ReservationPayment.count }) }
    ```

  * **Line # 1422 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
              it  { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 1437 - convention:** RSpec/ExpectChange: Prefer `change(ReservationPayment, :count)`.

    ```rb
            it  { expect { req }.not_to(change { ReservationPayment.count }) }
    ```

  * **Line # 1438 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it  { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 1519 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 1551 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
              allow_any_instance_of(Reservation).to receive(:cancelled!).and_return(false)
    ```

  * **Line # 1554 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
              allow_any_instance_of(Reservation).to receive(:errors).and_return(errors)
    ```

  * **Line # 1560 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "renders errors" do
    ```

  * **Line # 1576 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:get, "/v1/reservations/supersecret").to(format: :json, action: :show, controller: "v1/reservations",
    ```

  * **Line # 1576 - convention:** Layout/LineLength: Line is too long. [132/120]

    ```rb
          expect(subject).to route(:get, "/v1/reservations/supersecret").to(format: :json, action: :show, controller: "v1/reservations",
    ```

  * **Line # 1601 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 1614 - convention:** RSpec/ExampleLength: Example has too many lines. [13/5]

    ```rb
              it { ...
    ```

  * **Line # 1615 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject).to include(
    ```

### spec/coverage_helper.rb - (1 offense)
  * **Line # 28 - convention:** Performance/Count: Use `count` instead of `reject...count`.

    ```rb
        uncommented_lines = source_file.lines.reject { |line| line.src.match?(/^\s*#/) }.count
    ```

### spec/factories/image_factory.rb - (1 offense)
  * **Line # 9 - convention:** FactoryBot/FactoryAssociationWithStrategy: Use an implicit, explicit or inline definition instead of hard coding a strategy for setting association within factory.

    ```rb
          original { build(:image) }
    ```

### spec/factories/log/image_pixel_event_factory.rb - (2 offenses)
  * **Line # 1 - convention:** Style/FrozenStringLiteralComment: Missing frozen string literal comment.

    ```rb
    FactoryBot.define do
    ```

  * **Line # 3 - convention:** Rails/TimeZone: Do not use `Time.now` without zone. Use one of `Time.zone.now`, `Time.current`, `Time.now.in_time_zone`, `Time.now.utc`, `Time.now.getlocal`, `Time.now.xmlschema`, `Time.now.iso8601`, `Time.now.jisx0301`, `Time.now.rfc3339`, `Time.now.httpdate`, `Time.now.to_i`, `Time.now.to_f` instead.

    ```rb
        event_time { Time.now }
    ```

### spec/factories/log/image_pixel_factory.rb - (3 offenses)
  * **Line # 8 - convention:** FactoryBot/FactoryAssociationWithStrategy: Use an implicit, explicit or inline definition instead of hard coding a strategy for setting association within factory.

    ```rb
          image { create(:image, :with_attached_image) }
    ```

  * **Line # 12 - convention:** FactoryBot/FactoryAssociationWithStrategy: Use an implicit, explicit or inline definition instead of hard coding a strategy for setting association within factory.

    ```rb
          record { create(:user) }
    ```

  * **Line # 16 - convention:** FactoryBot/FactoryAssociationWithStrategy: Use an implicit, explicit or inline definition instead of hard coding a strategy for setting association within factory.

    ```rb
          delivered_email { create(:log_delivered_email) }
    ```

### spec/factories/log/model_change_factory.rb - (1 offense)
  * **Line # 7 - convention:** FactoryBot/FactoryAssociationWithStrategy: Use an implicit, explicit or inline definition instead of hard coding a strategy for setting association within factory.

    ```rb
        record { create(:user) }
    ```

### spec/factories/menu/allergen_factory.rb - (2 offenses)
  * **Line # 11 - convention:** FactoryBot/FactoryAssociationWithStrategy: Use an implicit, explicit or inline definition instead of hard coding a strategy for setting association within factory.

    ```rb
          image { create(:image) }
    ```

  * **Line # 15 - convention:** FactoryBot/FactoryAssociationWithStrategy: Use an implicit, explicit or inline definition instead of hard coding a strategy for setting association within factory.

    ```rb
          image { create(:image, :with_attached_image) }
    ```

### spec/factories/menu/allergens_in_dish_factory.rb - (2 offenses)
  * **Line # 5 - convention:** FactoryBot/FactoryAssociationWithStrategy: Use an implicit, explicit or inline definition instead of hard coding a strategy for setting association within factory.

    ```rb
        menu_dish { create(:menu_dish) }
    ```

  * **Line # 6 - convention:** FactoryBot/FactoryAssociationWithStrategy: Use an implicit, explicit or inline definition instead of hard coding a strategy for setting association within factory.

    ```rb
        menu_allergen { create(:menu_allergen) }
    ```

### spec/factories/menu/category_factory.rb - (1 offense)
  * **Line # 11 - convention:** FactoryBot/FactoryAssociationWithStrategy: Use an implicit, explicit or inline definition instead of hard coding a strategy for setting association within factory.

    ```rb
        menu_visibility { build(:menu_visibility) }
    ```

### spec/factories/menu/dish_suggestion_factory.rb - (1 offense)
  * **Line # 1 - convention:** Style/FrozenStringLiteralComment: Missing frozen string literal comment.

    ```rb
    FactoryBot.define do
    ```

### spec/factories/menu/dishes_in_category_factory.rb - (2 offenses)
  * **Line # 5 - convention:** FactoryBot/FactoryAssociationWithStrategy: Use an implicit, explicit or inline definition instead of hard coding a strategy for setting association within factory.

    ```rb
        menu_dish { create(:menu_dish) }
    ```

  * **Line # 6 - convention:** FactoryBot/FactoryAssociationWithStrategy: Use an implicit, explicit or inline definition instead of hard coding a strategy for setting association within factory.

    ```rb
        menu_category { create(:menu_category) }
    ```

### spec/factories/menu/ingredient_factory.rb - (2 offenses)
  * **Line # 11 - convention:** FactoryBot/FactoryAssociationWithStrategy: Use an implicit, explicit or inline definition instead of hard coding a strategy for setting association within factory.

    ```rb
          image { create(:image) }
    ```

  * **Line # 15 - convention:** FactoryBot/FactoryAssociationWithStrategy: Use an implicit, explicit or inline definition instead of hard coding a strategy for setting association within factory.

    ```rb
          image { create(:image, :with_attached_image) }
    ```

### spec/factories/menu/ingredients_in_dish_factory.rb - (2 offenses)
  * **Line # 5 - convention:** FactoryBot/FactoryAssociationWithStrategy: Use an implicit, explicit or inline definition instead of hard coding a strategy for setting association within factory.

    ```rb
        menu_dish { create(:menu_dish) }
    ```

  * **Line # 6 - convention:** FactoryBot/FactoryAssociationWithStrategy: Use an implicit, explicit or inline definition instead of hard coding a strategy for setting association within factory.

    ```rb
        menu_ingredient { create(:menu_ingredient) }
    ```

### spec/factories/menu/tag_factory.rb - (2 offenses)
  * **Line # 12 - convention:** FactoryBot/FactoryAssociationWithStrategy: Use an implicit, explicit or inline definition instead of hard coding a strategy for setting association within factory.

    ```rb
          image { create(:image) }
    ```

  * **Line # 16 - convention:** FactoryBot/FactoryAssociationWithStrategy: Use an implicit, explicit or inline definition instead of hard coding a strategy for setting association within factory.

    ```rb
          image { create(:image, :with_attached_image) }
    ```

### spec/factories/menu/tags_in_dish_factory.rb - (2 offenses)
  * **Line # 5 - convention:** FactoryBot/FactoryAssociationWithStrategy: Use an implicit, explicit or inline definition instead of hard coding a strategy for setting association within factory.

    ```rb
        menu_dish { create(:menu_dish) }
    ```

  * **Line # 6 - convention:** FactoryBot/FactoryAssociationWithStrategy: Use an implicit, explicit or inline definition instead of hard coding a strategy for setting association within factory.

    ```rb
        menu_tag { create(:menu_tag) }
    ```

### spec/factories/preorder_reservation_date_factory.rb - (2 offenses)
  * **Line # 6 - convention:** FactoryBot/FactoryAssociationWithStrategy: Use an implicit, explicit or inline definition instead of hard coding a strategy for setting association within factory.

    ```rb
        reservation_turn { create(:reservation_turn, weekday: 1) }
    ```

  * **Line # 7 - convention:** FactoryBot/FactoryAssociationWithStrategy: Use an implicit, explicit or inline definition instead of hard coding a strategy for setting association within factory.

    ```rb
        group { create(:preorder_reservation_group) }
    ```

### spec/factories/refresh_token_factory.rb - (1 offense)
  * **Line # 9 - convention:** FactoryBot/FactoryAssociationWithStrategy: Use an implicit, explicit or inline definition instead of hard coding a strategy for setting association within factory.

    ```rb
          user { create(:user) }
    ```

### spec/factories/reservation_factory.rb - (2 offenses)
  * **Line # 1 - convention:** Style/FrozenStringLiteralComment: Missing frozen string literal comment.

    ```rb
    FactoryBot.define do
    ```

  * **Line # 3 - convention:** Rails/TimeZone: Do not use `Time.now` without zone. Use one of `Time.zone.now`, `Time.current`, `Time.now.in_time_zone`, `Time.now.utc`, `Time.now.getlocal`, `Time.now.xmlschema`, `Time.now.iso8601`, `Time.now.jisx0301`, `Time.now.rfc3339`, `Time.now.httpdate`, `Time.now.to_i`, `Time.now.to_f` instead.

    ```rb
        datetime { (Time.now + 1.week).strftime("%Y-%m-%d %H:%M") }
    ```

### spec/factories/reservation_payment_factory.rb - (1 offense)
  * **Line # 6 - convention:** Rails/FilePath: Prefer `Rails.root.join('path/to')`.

    ```rb
          File.read(Rails.root.join("spec", "fixtures", "nexi-simple-payment-success-page.html"))
    ```

### spec/factories/reservation_turn_to_messages.rb - (1 offense)
  * **Line # 4 - warning:** Lint/EmptyBlock: Empty block detected.

    ```rb
      factory :reservation_turn_to_message do ...
    ```

### spec/interactions/copy_image_spec.rb - (23 offenses)
  * **Line # 16 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect { subject }.to change(Image, :count).by(1)
    ```

  * **Line # 20 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject).to be_valid
    ```

  * **Line # 23 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
          it "returns image" do
    ```

  * **Line # 24 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result).to be_a(Image)
    ```

  * **Line # 25 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result).to be_valid
    ```

  * **Line # 26 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result).to be_persisted
    ```

  * **Line # 30 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect { subject }.to change(ActiveStorage::Blob, :count).by(1)
    ```

  * **Line # 34 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect { subject }.to change(ActiveStorage::Attachment, :count).by(1)
    ```

  * **Line # 38 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            new_image = subject.result
    ```

  * **Line # 46 - convention:** RSpec/NoExpectationExample: No expectation found in this example.

    ```rb
          it "enqueue a job to save the changes with current user info" do ...
    ```

  * **Line # 48 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            subject
    ```

  * **Line # 63 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect { subject }.to change(Image, :count).by(1)
    ```

  * **Line # 67 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject).to be_valid
    ```

  * **Line # 70 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
          it "returns image" do
    ```

  * **Line # 71 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result).to be_a(Image)
    ```

  * **Line # 72 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result).to be_valid
    ```

  * **Line # 73 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result).to be_persisted
    ```

  * **Line # 77 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect { subject }.not_to change(ActiveStorage::Blob, :count)
    ```

  * **Line # 81 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect { subject }.not_to change(ActiveStorage::Attachment, :count)
    ```

  * **Line # 85 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            new_image = subject.result
    ```

  * **Line # 93 - convention:** RSpec/NoExpectationExample: No expectation found in this example.

    ```rb
          it "enqueue a job to save the changes with current user info" do ...
    ```

  * **Line # 95 - convention:** Layout/LineLength: Line is too long. [289/120]

    ```rb
                                                                        "changed_fields" => %w[filename status], "record_changes" => { "filename" => [nil, image.filename], "status" => [nil, image.status] }, "record_id" => image.id + 1, "record_type" => "Image", "user_id" => current_user.id })
    ```

  * **Line # 96 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            subject
    ```

### spec/interactions/generate_image_variants_spec.rb - (8 offenses)
  * **Line # 29 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:image]).to include("must be original") }
    ```

  * **Line # 38 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.not_to(change { image.children.count })
    ```

  * **Line # 63 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.to change { image.children.count }.by(number_of_variants)
    ```

  * **Line # 82 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:image]).to include("must be persisted") }
    ```

  * **Line # 100 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:image]).to include("must have an attached image") }
    ```

  * **Line # 126 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect { subject }.to change { image.children.count }.by(number_of_variants)
    ```

  * **Line # 146 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { image.children.count }) }
    ```

  * **Line # 148 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.errors).to be_empty }
    ```

### spec/interactions/menu/can_publish_category_spec.rb - (12 offenses)
  * **Line # 10 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
        it "has a let(:category) of type Menu::Category" do
    ```

  * **Line # 11 - convention:** RSpec/IdenticalEqualityAssertion: Identical expressions on both sides of the equality may indicate a flawed test.

    ```rb
          expect(category).to eq category
    ```

  * **Line # 13 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Category, :count)`.

    ```rb
          expect { category }.not_to(change { Menu::Category.count })
    ```

  * **Line # 18 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
      it { expect(call.result).to eq false }
    ```

  * **Line # 195 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
            allow_any_instance_of(Menu::Dish).to receive(:validate).and_return(false)
    ```

  * **Line # 196 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
            allow_any_instance_of(Menu::Dish).to receive(:valid?).and_return(false)
    ```

  * **Line # 210 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
            allow_any_instance_of(Menu::Category).to receive(:validate).and_return(false)
    ```

  * **Line # 211 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
            allow_any_instance_of(Menu::Category).to receive(:valid?).and_return(false)
    ```

  * **Line # 214 - convention:** RSpec/Rails/NegationBeValid: Use `expect(...).not_to be_valid`.

    ```rb
          it { expect(category).to be_invalid }
    ```

  * **Line # 259 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
        it { expect(subject.reasons.full_messages).to be_empty }
    ```

  * **Line # 281 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.reasons.full_messages).to be_empty }
    ```

  * **Line # 318 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
        it { expect(subject.reasons.full_messages).to be_empty }
    ```

### spec/interactions/menu/copy_allergen_spec.rb - (70 offenses)
  * **Line # 16 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect { subject }.to change(Menu::Allergen, :count).by(1)
    ```

  * **Line # 20 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject).to be_valid
    ```

  * **Line # 23 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
          it "returns allergen" do
    ```

  * **Line # 24 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result).to be_a(Menu::Allergen)
    ```

  * **Line # 25 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result).to be_valid
    ```

  * **Line # 26 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result).to be_persisted
    ```

  * **Line # 29 - convention:** RSpec/NoExpectationExample: No expectation found in this example.

    ```rb
          it "enqueue a job to save the changes with current user info" do ...
    ```

  * **Line # 31 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            subject
    ```

  * **Line # 48 - convention:** RSpec/ExampleLength: Example has too many lines. [6/5]

    ```rb
            it "has name and description in all available locales" do ...
    ```

  * **Line # 48 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "has name and description in all available locales" do
    ```

  * **Line # 58 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it "copies name and description translations" do
    ```

  * **Line # 59 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.name).to eq(old.name)
    ```

  * **Line # 60 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.description).to eq(old.description)
    ```

  * **Line # 66 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject.result.name).to eq("Name in #{locale}")
    ```

  * **Line # 74 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject.result.description).to eq("Description in #{locale}")
    ```

  * **Line # 82 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.status).to eq(old.status)
    ```

  * **Line # 92 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.result.image).to be_present }
    ```

  * **Line # 94 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.errors).to be_empty }
    ```

  * **Line # 96 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { Image.count }.by(1) }
    ```

  * **Line # 96 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
          it { expect { subject }.to change { Image.count }.by(1) }
    ```

  * **Line # 97 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { ActiveStorage::Blob.count }.by(1) }
    ```

  * **Line # 97 - convention:** RSpec/ExpectChange: Prefer `change(ActiveStorage::Blob, :count)`.

    ```rb
          it { expect { subject }.to change { ActiveStorage::Blob.count }.by(1) }
    ```

  * **Line # 98 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { ActiveStorage::Attachment.count }.by(1) }
    ```

  * **Line # 98 - convention:** RSpec/ExpectChange: Prefer `change(ActiveStorage::Attachment, :count)`.

    ```rb
          it { expect { subject }.to change { ActiveStorage::Attachment.count }.by(1) }
    ```

  * **Line # 100 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.result.image.url).not_to eq allergen.image.url }
    ```

  * **Line # 102 - convention:** RSpec/ExampleLength: Example has too many lines. [7/5]

    ```rb
          it "has a different image" do ...
    ```

  * **Line # 102 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it "has a different image" do
    ```

  * **Line # 103 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            new = subject.result
    ```

  * **Line # 117 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it "copies other" do
    ```

  * **Line # 118 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.reload.other).to eq(old.other)
    ```

  * **Line # 119 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.other).to eq({ "foo" => "bar" })
    ```

  * **Line # 129 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.result.image).to be_present }
    ```

  * **Line # 131 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.errors).to be_empty }
    ```

  * **Line # 133 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 133 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
          it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 134 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Blob.count }) }
    ```

  * **Line # 134 - convention:** RSpec/ExpectChange: Prefer `change(ActiveStorage::Blob, :count)`.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Blob.count }) }
    ```

  * **Line # 135 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Attachment.count }) }
    ```

  * **Line # 135 - convention:** RSpec/ExpectChange: Prefer `change(ActiveStorage::Attachment, :count)`.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Attachment.count }) }
    ```

  * **Line # 137 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.result.image.url).to eq allergen.image.url }
    ```

  * **Line # 138 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.result.image.id).to eq allergen.image.id }
    ```

  * **Line # 147 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.result.image).to be_nil }
    ```

  * **Line # 148 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.result.reload.image).to be_nil }
    ```

  * **Line # 150 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 150 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
          it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 151 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Blob.count }) }
    ```

  * **Line # 151 - convention:** RSpec/ExpectChange: Prefer `change(ActiveStorage::Blob, :count)`.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Blob.count }) }
    ```

  * **Line # 152 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Attachment.count }) }
    ```

  * **Line # 152 - convention:** RSpec/ExpectChange: Prefer `change(ActiveStorage::Attachment, :count)`.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Attachment.count }) }
    ```

  * **Line # 160 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.result.image).not_to be_present }
    ```

  * **Line # 162 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 162 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
          it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 163 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Blob.count }) }
    ```

  * **Line # 163 - convention:** RSpec/ExpectChange: Prefer `change(ActiveStorage::Blob, :count)`.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Blob.count }) }
    ```

  * **Line # 164 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Attachment.count }) }
    ```

  * **Line # 164 - convention:** RSpec/ExpectChange: Prefer `change(ActiveStorage::Attachment, :count)`.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Attachment.count }) }
    ```

  * **Line # 173 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
            allow_any_instance_of(Image).to receive(:valid?).and_return(false)
    ```

  * **Line # 176 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
            allow_any_instance_of(Image).to receive(:errors).and_return(errors)
    ```

  * **Line # 179 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it "does not create any record and returns errors" do
    ```

  * **Line # 180 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect { subject }.not_to(change { Image.count })
    ```

  * **Line # 180 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
            expect { subject }.not_to(change { Image.count })
    ```

  * **Line # 181 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.errors).not_to be_empty
    ```

  * **Line # 184 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { Menu::Allergen.count }) }
    ```

  * **Line # 184 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Allergen, :count)`.

    ```rb
          it { expect { subject }.not_to(change { Menu::Allergen.count }) }
    ```

  * **Line # 185 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Blob.count }) }
    ```

  * **Line # 185 - convention:** RSpec/ExpectChange: Prefer `change(ActiveStorage::Blob, :count)`.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Blob.count }) }
    ```

  * **Line # 186 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { Menu::AllergensInDish.count }) }
    ```

  * **Line # 186 - convention:** RSpec/ExpectChange: Prefer `change(Menu::AllergensInDish, :count)`.

    ```rb
          it { expect { subject }.not_to(change { Menu::AllergensInDish.count }) }
    ```

  * **Line # 187 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { ImageToRecord.count }) }
    ```

  * **Line # 187 - convention:** RSpec/ExpectChange: Prefer `change(ImageToRecord, :count)`.

    ```rb
          it { expect { subject }.not_to(change { ImageToRecord.count }) }
    ```

### spec/interactions/menu/copy_category_spec.rb - (95 offenses)
  * **Line # 6 - convention:** RSpec/ExampleLength: Example has too many lines. [11/5]

    ```rb
      it "does not create any record" do ...
    ```

  * **Line # 21 - convention:** RSpec/MultipleExpectations: Example has too many expectations [5/1].

    ```rb
      it "does not copy dishes" do
    ```

  * **Line # 22 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Dish, :count)`.

    ```rb
        expect { subject }.not_to(change { Menu::Dish.count })
    ```

  * **Line # 26 - convention:** RSpec/Rails/NegationBeValid: Use `expect(...).not_to be_valid`.

    ```rb
        expect(subject).to be_invalid
    ```

  * **Line # 58 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect { subject }.to change(Menu::Category, :count).by(1)
    ```

  * **Line # 64 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject.result.name).to eq "Category-#{locale}"
    ```

  * **Line # 72 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject.result.description).to eq "Description-#{locale}"
    ```

  * **Line # 77 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
          it "copies images" do
    ```

  * **Line # 78 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect { subject }.to change(Image, :count).by(1)
    ```

  * **Line # 79 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.images.count).to eq 1
    ```

  * **Line # 80 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.images.first.url).not_to eq old.images.first.url
    ```

  * **Line # 83 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change(Image, :count).by(1) }
    ```

  * **Line # 85 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it "does not copy index" do
    ```

  * **Line # 86 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.index).to be_present
    ```

  * **Line # 87 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.index).not_to eq old.index
    ```

  * **Line # 90 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
          it "does not copy visibility_id" do
    ```

  * **Line # 91 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.visibility_id).to be_present
    ```

  * **Line # 93 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.visibility_id).not_to eq old.visibility_id
    ```

  * **Line # 96 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
          it "does not copy secret" do
    ```

  * **Line # 97 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.secret).to be_present
    ```

  * **Line # 99 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.secret).not_to eq old.secret
    ```

  * **Line # 102 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it "does not copy id" do
    ```

  * **Line # 103 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.id).to be_present
    ```

  * **Line # 104 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.id).not_to eq old.id
    ```

  * **Line # 107 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it "does not copy created_at" do
    ```

  * **Line # 108 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.created_at).to be_present
    ```

  * **Line # 109 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.created_at).not_to eq old.created_at
    ```

  * **Line # 112 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it "does not copy updated_at" do
    ```

  * **Line # 113 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.updated_at).to be_present
    ```

  * **Line # 114 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.updated_at).not_to eq old.updated_at
    ```

  * **Line # 117 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it "does not copy secret_desc" do
    ```

  * **Line # 119 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.secret_desc).to be_nil
    ```

  * **Line # 123 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.status).to eq old.status
    ```

  * **Line # 127 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.other).to eq old.other.merge("copied_from" => old.id)
    ```

  * **Line # 130 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it "does copy price" do
    ```

  * **Line # 131 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.price.to_i).to be_positive
    ```

  * **Line # 132 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.price).to eq old.price
    ```

  * **Line # 136 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject).to be_valid
    ```

  * **Line # 139 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
          it "returns category" do
    ```

  * **Line # 140 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result).to be_a(Menu::Category)
    ```

  * **Line # 141 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result).to be_valid
    ```

  * **Line # 142 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result).to be_persisted
    ```

  * **Line # 154 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Menu::Category.count }.by(old.children.count + 1) }
    ```

  * **Line # 154 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Category, :count)`.

    ```rb
            it { expect { subject }.to change { Menu::Category.count }.by(old.children.count + 1) }
    ```

  * **Line # 156 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "is successful" do
    ```

  * **Line # 157 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              subject.validate
    ```

  * **Line # 158 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject.errors.full_messages).to be_empty
    ```

  * **Line # 159 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to be_valid
    ```

  * **Line # 162 - convention:** RSpec/ExampleLength: Example has too many lines. [6/5]

    ```rb
            it "copies children" do ...
    ```

  * **Line # 162 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "copies children" do
    ```

  * **Line # 163 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject.result.children.reload.count).to eq old.children.reload.count
    ```

  * **Line # 167 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                  expect(subject.result.children.map(&:name)).to match_array(old.children.map(&:name))
    ```

  * **Line # 184 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 185 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.to change { Menu::Category.count }.by(1)
    ```

  * **Line # 185 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Category, :count)`.

    ```rb
              expect { subject }.to change { Menu::Category.count }.by(1)
    ```

  * **Line # 186 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject.result.children.count).to eq 0
    ```

  * **Line # 190 - convention:** RSpec/NoExpectationExample: No expectation found in this example.

    ```rb
          it "enqueue a job to save the changes with current user info" do ...
    ```

  * **Line # 192 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            subject
    ```

  * **Line # 199 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it "does copy parent_id" do
    ```

  * **Line # 200 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.parent_id).to be_present
    ```

  * **Line # 201 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.parent_id).to eq old.parent_id
    ```

  * **Line # 211 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { Menu::DishesInCategory.count }.by(1) }
    ```

  * **Line # 211 - convention:** RSpec/ExpectChange: Prefer `change(Menu::DishesInCategory, :count)`.

    ```rb
          it { expect { subject }.to change { Menu::DishesInCategory.count }.by(1) }
    ```

  * **Line # 213 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
          it "copies dishes" do
    ```

  * **Line # 214 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect { subject }.to change { Menu::Dish.count }.by(1)
    ```

  * **Line # 214 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Dish, :count)`.

    ```rb
            expect { subject }.to change { Menu::Dish.count }.by(1)
    ```

  * **Line # 215 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.dishes.count).to eq 1
    ```

  * **Line # 216 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.dishes.first.name).to eq old.dishes.first.name
    ```

  * **Line # 226 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { Menu::DishesInCategory.count }.by(1) }
    ```

  * **Line # 226 - convention:** RSpec/ExpectChange: Prefer `change(Menu::DishesInCategory, :count)`.

    ```rb
          it { expect { subject }.to change { Menu::DishesInCategory.count }.by(1) }
    ```

  * **Line # 228 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
          it "copies dishes" do
    ```

  * **Line # 229 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect { subject }.not_to(change { Menu::Dish.count })
    ```

  * **Line # 229 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Dish, :count)`.

    ```rb
            expect { subject }.not_to(change { Menu::Dish.count })
    ```

  * **Line # 230 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.dishes.count).to eq 1
    ```

  * **Line # 231 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.dishes.first.name).to eq old.dishes.first.name
    ```

  * **Line # 241 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { Menu::DishesInCategory.count }) }
    ```

  * **Line # 241 - convention:** RSpec/ExpectChange: Prefer `change(Menu::DishesInCategory, :count)`.

    ```rb
          it { expect { subject }.not_to(change { Menu::DishesInCategory.count }) }
    ```

  * **Line # 243 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it "does not copy dishes" do
    ```

  * **Line # 244 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect { subject }.not_to(change { Menu::Dish.count })
    ```

  * **Line # 244 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Dish, :count)`.

    ```rb
            expect { subject }.not_to(change { Menu::Dish.count })
    ```

  * **Line # 245 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.dishes.count).to eq 0
    ```

  * **Line # 266 - convention:** RSpec/ExampleLength: Example has too many lines. [11/5]

    ```rb
          it "check mock data" do ...
    ```

  * **Line # 266 - convention:** RSpec/MultipleExpectations: Example has too many expectations [11/1].

    ```rb
          it "check mock data" do
    ```

  * **Line # 281 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
            allow_any_instance_of(model).to receive(:valid?).and_return(false)
    ```

  * **Line # 284 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
            allow_any_instance_of(model).to receive(:errors).and_return(errors)
    ```

  * **Line # 323 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it "when {current_user: User, old: Menu::Category}" do
    ```

  * **Line # 330 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
        it "when {current_user: nil, old: Menu::Category}" do
    ```

  * **Line # 338 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
        it "when {current_user: User, old: nil}" do
    ```

  * **Line # 346 - convention:** RSpec/ExampleLength: Example has too many lines. [6/5]

    ```rb
        it "when {}" do ...
    ```

  * **Line # 346 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
        it "when {}" do
    ```

  * **Line # 355 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
        it "when {current_user: User, old: Menu::Category, unsupported_key: 'some-value'}" do
    ```

  * **Line # 363 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
        it "when {current_user: User, old: Menu::Category, copy_dishes: 'invalid-value'}" do
    ```

  * **Line # 371 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
        it "when {current_user: User, old: Menu::Category, copy_children: 'invalid-value'}" do
    ```

  * **Line # 379 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
        it "when {current_user: User, old: Menu::Category, copy_images: 'invalid-value'}" do
    ```

  * **Line # 387 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it "when {current_user: User, old: Menu::Category, copy_images: 'full'}" do
    ```

### spec/interactions/menu/copy_dish_spec.rb - (249 offenses)
  * **Line # 16 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect { subject }.to change(Menu::Dish, :count).by(1)
    ```

  * **Line # 20 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject).to be_valid
    ```

  * **Line # 23 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
          it "returns dish" do
    ```

  * **Line # 24 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result).to be_a(Menu::Dish)
    ```

  * **Line # 25 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result).to be_valid
    ```

  * **Line # 26 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result).to be_persisted
    ```

  * **Line # 29 - convention:** RSpec/NoExpectationExample: No expectation found in this example.

    ```rb
          it "enqueue a job to save the changes with current user info" do ...
    ```

  * **Line # 31 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            subject
    ```

  * **Line # 48 - convention:** RSpec/ExampleLength: Example has too many lines. [6/5]

    ```rb
            it "has name and description in all available locales" do ...
    ```

  * **Line # 48 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "has name and description in all available locales" do
    ```

  * **Line # 58 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
          it "copies name and description translations" do
    ```

  * **Line # 59 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.name).to eq(old.name)
    ```

  * **Line # 60 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.description).to eq(old.description)
    ```

  * **Line # 61 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.name).to be_present
    ```

  * **Line # 62 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.description).to be_present
    ```

  * **Line # 68 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject.result.name).to eq("Name in #{locale}")
    ```

  * **Line # 76 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject.result.description).to eq("Description in #{locale}")
    ```

  * **Line # 84 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.status).to eq(old.status)
    ```

  * **Line # 91 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it "copies price" do
    ```

  * **Line # 92 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.price).to eq(old.price)
    ```

  * **Line # 93 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.reload.price).to eq(1_001.5)
    ```

  * **Line # 100 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it "copies other" do
    ```

  * **Line # 101 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.reload.other).to eq(old.other)
    ```

  * **Line # 102 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.other).to eq({ "foo" => "bar" })
    ```

  * **Line # 112 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.result.images).not_to be_empty }
    ```

  * **Line # 114 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.errors).to be_empty }
    ```

  * **Line # 116 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { Image.count }.by(1) }
    ```

  * **Line # 116 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
          it { expect { subject }.to change { Image.count }.by(1) }
    ```

  * **Line # 117 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { ActiveStorage::Blob.count }.by(1) }
    ```

  * **Line # 117 - convention:** RSpec/ExpectChange: Prefer `change(ActiveStorage::Blob, :count)`.

    ```rb
          it { expect { subject }.to change { ActiveStorage::Blob.count }.by(1) }
    ```

  * **Line # 118 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { ActiveStorage::Attachment.count }.by(1) }
    ```

  * **Line # 118 - convention:** RSpec/ExpectChange: Prefer `change(ActiveStorage::Attachment, :count)`.

    ```rb
          it { expect { subject }.to change { ActiveStorage::Attachment.count }.by(1) }
    ```

  * **Line # 120 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.result.images.first.url).not_to eq dish.images.first.url }
    ```

  * **Line # 122 - convention:** RSpec/ExampleLength: Example has too many lines. [7/5]

    ```rb
          it "has a different image" do ...
    ```

  * **Line # 122 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it "has a different image" do
    ```

  * **Line # 123 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            new = subject.result
    ```

  * **Line # 140 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.result.images).not_to be_empty }
    ```

  * **Line # 142 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.errors).to be_empty }
    ```

  * **Line # 144 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { Image.count }.by(3) }
    ```

  * **Line # 144 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
          it { expect { subject }.to change { Image.count }.by(3) }
    ```

  * **Line # 145 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { ActiveStorage::Blob.count }.by(3) }
    ```

  * **Line # 145 - convention:** RSpec/ExpectChange: Prefer `change(ActiveStorage::Blob, :count)`.

    ```rb
          it { expect { subject }.to change { ActiveStorage::Blob.count }.by(3) }
    ```

  * **Line # 146 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { ActiveStorage::Attachment.count }.by(3) }
    ```

  * **Line # 146 - convention:** RSpec/ExpectChange: Prefer `change(ActiveStorage::Attachment, :count)`.

    ```rb
          it { expect { subject }.to change { ActiveStorage::Attachment.count }.by(3) }
    ```

  * **Line # 148 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.result.images.first.url).not_to eq dish.images.first.url }
    ```

  * **Line # 151 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            subject.result.images.each do |result_image|
    ```

  * **Line # 152 - convention:** Style/SymbolProc: Pass `&:url` as an argument to `map` instead of a block.

    ```rb
              expect(dish.images.map { |img| img.url }).not_to include(result_image.url)
    ```

  * **Line # 156 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.result.images.count).to eq dish.images.count }
    ```

  * **Line # 158 - convention:** RSpec/ExampleLength: Example has too many lines. [7/5]

    ```rb
          it "has a different image" do ...
    ```

  * **Line # 158 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it "has a different image" do
    ```

  * **Line # 159 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            new = subject.result
    ```

  * **Line # 176 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.result.images).not_to be_empty }
    ```

  * **Line # 178 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.errors).to be_empty }
    ```

  * **Line # 180 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 180 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
          it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 181 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Blob.count }) }
    ```

  * **Line # 181 - convention:** RSpec/ExpectChange: Prefer `change(ActiveStorage::Blob, :count)`.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Blob.count }) }
    ```

  * **Line # 182 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Attachment.count }) }
    ```

  * **Line # 182 - convention:** RSpec/ExpectChange: Prefer `change(ActiveStorage::Attachment, :count)`.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Attachment.count }) }
    ```

  * **Line # 184 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.result.images.first.url).to eq dish.images.first.url }
    ```

  * **Line # 185 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.result.images.first.id).to eq dish.images.first.id }
    ```

  * **Line # 194 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.result.images).not_to be_empty }
    ```

  * **Line # 195 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.result.images.count).to eq dish.images.count }
    ```

  * **Line # 197 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.errors).to be_empty }
    ```

  * **Line # 199 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 199 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
          it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 200 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Blob.count }) }
    ```

  * **Line # 200 - convention:** RSpec/ExpectChange: Prefer `change(ActiveStorage::Blob, :count)`.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Blob.count }) }
    ```

  * **Line # 201 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Attachment.count }) }
    ```

  * **Line # 201 - convention:** RSpec/ExpectChange: Prefer `change(ActiveStorage::Attachment, :count)`.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Attachment.count }) }
    ```

  * **Line # 203 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.result.images.first.url).to eq dish.images.first.url }
    ```

  * **Line # 204 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.result.images.first.id).to eq dish.images.first.id }
    ```

  * **Line # 205 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.result.images.map { |img| img.url }).to eq(dish.images.map { |img| img.url }) }
    ```

  * **Line # 205 - convention:** Style/SymbolProc: Pass `&:url` as an argument to `map` instead of a block.

    ```rb
          it { expect(subject.result.images.map { |img| img.url }).to eq(dish.images.map { |img| img.url }) }
    ```

  * **Line # 205 - convention:** Style/SymbolProc: Pass `&:url` as an argument to `map` instead of a block.

    ```rb
          it { expect(subject.result.images.map { |img| img.url }).to eq(dish.images.map { |img| img.url }) }
    ```

  * **Line # 214 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.result.images).to be_empty }
    ```

  * **Line # 215 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.result.reload.images).to be_empty }
    ```

  * **Line # 217 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 217 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
          it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 218 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Blob.count }) }
    ```

  * **Line # 218 - convention:** RSpec/ExpectChange: Prefer `change(ActiveStorage::Blob, :count)`.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Blob.count }) }
    ```

  * **Line # 219 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Attachment.count }) }
    ```

  * **Line # 219 - convention:** RSpec/ExpectChange: Prefer `change(ActiveStorage::Attachment, :count)`.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Attachment.count }) }
    ```

  * **Line # 235 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Menu::Ingredient.count }.by(ingredients.count) }
    ```

  * **Line # 235 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Ingredient, :count)`.

    ```rb
            it { expect { subject }.to change { Menu::Ingredient.count }.by(ingredients.count) }
    ```

  * **Line # 236 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Menu::IngredientsInDish.count }.by(ingredients.count) }
    ```

  * **Line # 236 - convention:** RSpec/ExpectChange: Prefer `change(Menu::IngredientsInDish, :count)`.

    ```rb
            it { expect { subject }.to change { Menu::IngredientsInDish.count }.by(ingredients.count) }
    ```

  * **Line # 237 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.result.ingredients.map(&:id)).not_to match_array(ingredients.map(&:id)) }
    ```

  * **Line # 238 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.result.ingredients.map(&:id)).not_to match_array(old.ingredients.map(&:id)) }
    ```

  * **Line # 243 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change { Image.count }.by(ingredients.count) }
    ```

  * **Line # 243 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
              it { expect { subject }.to change { Image.count }.by(ingredients.count) }
    ```

  * **Line # 244 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change { ImageToRecord.count }.by(ingredients.count) }
    ```

  * **Line # 244 - convention:** RSpec/ExpectChange: Prefer `change(ImageToRecord, :count)`.

    ```rb
              it { expect { subject }.to change { ImageToRecord.count }.by(ingredients.count) }
    ```

  * **Line # 245 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change { ActiveStorage::Attachment.count }.by(ingredients.count) }
    ```

  * **Line # 245 - convention:** RSpec/ExpectChange: Prefer `change(ActiveStorage::Attachment, :count)`.

    ```rb
              it { expect { subject }.to change { ActiveStorage::Attachment.count }.by(ingredients.count) }
    ```

  * **Line # 246 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change { ActiveStorage::Blob.count }.by(ingredients.count) }
    ```

  * **Line # 246 - convention:** RSpec/ExpectChange: Prefer `change(ActiveStorage::Blob, :count)`.

    ```rb
              it { expect { subject }.to change { ActiveStorage::Blob.count }.by(ingredients.count) }
    ```

  * **Line # 253 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.result.ingredients).not_to be_empty }
    ```

  * **Line # 254 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.result.ingredients.map(&:id)).to match_array(ingredients.map(&:id)) }
    ```

  * **Line # 255 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.result.ingredients.map(&:id)).to match_array(old.ingredients.map(&:id)) }
    ```

  * **Line # 256 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Menu::Ingredient.count }) }
    ```

  * **Line # 256 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Ingredient, :count)`.

    ```rb
            it { expect { subject }.not_to(change { Menu::Ingredient.count }) }
    ```

  * **Line # 257 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Menu::IngredientsInDish.count }.by(ingredients.count) }
    ```

  * **Line # 257 - convention:** RSpec/ExpectChange: Prefer `change(Menu::IngredientsInDish, :count)`.

    ```rb
            it { expect { subject }.to change { Menu::IngredientsInDish.count }.by(ingredients.count) }
    ```

  * **Line # 262 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 262 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
              it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 263 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { ActiveStorage::Attachment.count }) }
    ```

  * **Line # 263 - convention:** RSpec/ExpectChange: Prefer `change(ActiveStorage::Attachment, :count)`.

    ```rb
              it { expect { subject }.not_to(change { ActiveStorage::Attachment.count }) }
    ```

  * **Line # 264 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { ActiveStorage::Blob.count }) }
    ```

  * **Line # 264 - convention:** RSpec/ExpectChange: Prefer `change(ActiveStorage::Blob, :count)`.

    ```rb
              it { expect { subject }.not_to(change { ActiveStorage::Blob.count }) }
    ```

  * **Line # 271 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.result.ingredients).to be_empty }
    ```

  * **Line # 272 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Menu::Ingredient.count }) }
    ```

  * **Line # 272 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Ingredient, :count)`.

    ```rb
            it { expect { subject }.not_to(change { Menu::Ingredient.count }) }
    ```

  * **Line # 273 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Menu::IngredientsInDish.count }) }
    ```

  * **Line # 273 - convention:** RSpec/ExpectChange: Prefer `change(Menu::IngredientsInDish, :count)`.

    ```rb
            it { expect { subject }.not_to(change { Menu::IngredientsInDish.count }) }
    ```

  * **Line # 290 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Menu::Tag.count }.by(tags.count) }
    ```

  * **Line # 290 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Tag, :count)`.

    ```rb
            it { expect { subject }.to change { Menu::Tag.count }.by(tags.count) }
    ```

  * **Line # 291 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Menu::TagsInDish.count }.by(tags.count) }
    ```

  * **Line # 291 - convention:** RSpec/ExpectChange: Prefer `change(Menu::TagsInDish, :count)`.

    ```rb
            it { expect { subject }.to change { Menu::TagsInDish.count }.by(tags.count) }
    ```

  * **Line # 292 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.result.tags.map(&:id)).not_to match_array(tags.map(&:id)) }
    ```

  * **Line # 293 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.result.tags.map(&:id)).not_to match_array(old.tags.map(&:id)) }
    ```

  * **Line # 298 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change { Image.count }.by(tags.count) }
    ```

  * **Line # 298 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
              it { expect { subject }.to change { Image.count }.by(tags.count) }
    ```

  * **Line # 299 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change { ImageToRecord.count }.by(tags.count) }
    ```

  * **Line # 299 - convention:** RSpec/ExpectChange: Prefer `change(ImageToRecord, :count)`.

    ```rb
              it { expect { subject }.to change { ImageToRecord.count }.by(tags.count) }
    ```

  * **Line # 300 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change { ActiveStorage::Attachment.count }.by(tags.count) }
    ```

  * **Line # 300 - convention:** RSpec/ExpectChange: Prefer `change(ActiveStorage::Attachment, :count)`.

    ```rb
              it { expect { subject }.to change { ActiveStorage::Attachment.count }.by(tags.count) }
    ```

  * **Line # 301 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change { ActiveStorage::Blob.count }.by(tags.count) }
    ```

  * **Line # 301 - convention:** RSpec/ExpectChange: Prefer `change(ActiveStorage::Blob, :count)`.

    ```rb
              it { expect { subject }.to change { ActiveStorage::Blob.count }.by(tags.count) }
    ```

  * **Line # 305 - convention:** Performance/TimesMap: Use `Array.new(3)` with a block instead of `.times.map`.

    ```rb
              let(:tags) { 3.times.map { create(:menu_tag, color: Faker::Color.hex_color) } }
    ```

  * **Line # 307 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change { Menu::Tag.count }.by(tags.count) }
    ```

  * **Line # 307 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Tag, :count)`.

    ```rb
              it { expect { subject }.to change { Menu::Tag.count }.by(tags.count) }
    ```

  * **Line # 308 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change { Menu::TagsInDish.count }.by(tags.count) }
    ```

  * **Line # 308 - convention:** RSpec/ExpectChange: Prefer `change(Menu::TagsInDish, :count)`.

    ```rb
              it { expect { subject }.to change { Menu::TagsInDish.count }.by(tags.count) }
    ```

  * **Line # 309 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.result.tags.map(&:color)).to match_array(old.tags.map(&:color)) }
    ```

  * **Line # 310 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.result.tags.map(&:color)).to match_array(tags.map(&:color)) }
    ```

  * **Line # 317 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.result.tags).not_to be_empty }
    ```

  * **Line # 318 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.result.tags.map(&:id)).to match_array(tags.map(&:id)) }
    ```

  * **Line # 319 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.result.tags.map(&:id)).to match_array(old.tags.map(&:id)) }
    ```

  * **Line # 320 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Menu::Tag.count }) }
    ```

  * **Line # 320 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Tag, :count)`.

    ```rb
            it { expect { subject }.not_to(change { Menu::Tag.count }) }
    ```

  * **Line # 321 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Menu::TagsInDish.count }.by(tags.count) }
    ```

  * **Line # 321 - convention:** RSpec/ExpectChange: Prefer `change(Menu::TagsInDish, :count)`.

    ```rb
            it { expect { subject }.to change { Menu::TagsInDish.count }.by(tags.count) }
    ```

  * **Line # 326 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 326 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
              it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 327 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { ImageToRecord.count }) }
    ```

  * **Line # 327 - convention:** RSpec/ExpectChange: Prefer `change(ImageToRecord, :count)`.

    ```rb
              it { expect { subject }.not_to(change { ImageToRecord.count }) }
    ```

  * **Line # 328 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { ActiveStorage::Attachment.count }) }
    ```

  * **Line # 328 - convention:** RSpec/ExpectChange: Prefer `change(ActiveStorage::Attachment, :count)`.

    ```rb
              it { expect { subject }.not_to(change { ActiveStorage::Attachment.count }) }
    ```

  * **Line # 329 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { ActiveStorage::Blob.count }) }
    ```

  * **Line # 329 - convention:** RSpec/ExpectChange: Prefer `change(ActiveStorage::Blob, :count)`.

    ```rb
              it { expect { subject }.not_to(change { ActiveStorage::Blob.count }) }
    ```

  * **Line # 333 - convention:** Performance/TimesMap: Use `Array.new(3)` with a block instead of `.times.map`.

    ```rb
              let(:tags) { 3.times.map { create(:menu_tag, color: Faker::Color.hex_color) } }
    ```

  * **Line # 335 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { Menu::Tag.count }) }
    ```

  * **Line # 335 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Tag, :count)`.

    ```rb
              it { expect { subject }.not_to(change { Menu::Tag.count }) }
    ```

  * **Line # 336 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change { Menu::TagsInDish.count }.by(tags.count) }
    ```

  * **Line # 336 - convention:** RSpec/ExpectChange: Prefer `change(Menu::TagsInDish, :count)`.

    ```rb
              it { expect { subject }.to change { Menu::TagsInDish.count }.by(tags.count) }
    ```

  * **Line # 337 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.result.tags.map(&:color)).to match_array(old.tags.map(&:color)) }
    ```

  * **Line # 338 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.result.tags.map(&:color)).to match_array(tags.map(&:color)) }
    ```

  * **Line # 345 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.result.tags).to be_empty }
    ```

  * **Line # 346 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Menu::Tag.count }) }
    ```

  * **Line # 346 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Tag, :count)`.

    ```rb
            it { expect { subject }.not_to(change { Menu::Tag.count }) }
    ```

  * **Line # 347 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Menu::TagsInDish.count }) }
    ```

  * **Line # 347 - convention:** RSpec/ExpectChange: Prefer `change(Menu::TagsInDish, :count)`.

    ```rb
            it { expect { subject }.not_to(change { Menu::TagsInDish.count }) }
    ```

  * **Line # 364 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Menu::Allergen.count }.by(allergens.count) }
    ```

  * **Line # 364 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Allergen, :count)`.

    ```rb
            it { expect { subject }.to change { Menu::Allergen.count }.by(allergens.count) }
    ```

  * **Line # 365 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Menu::AllergensInDish.count }.by(allergens.count) }
    ```

  * **Line # 365 - convention:** RSpec/ExpectChange: Prefer `change(Menu::AllergensInDish, :count)`.

    ```rb
            it { expect { subject }.to change { Menu::AllergensInDish.count }.by(allergens.count) }
    ```

  * **Line # 366 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.result.allergens.map(&:id)).not_to match_array(allergens.map(&:id)) }
    ```

  * **Line # 367 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.result.allergens.map(&:id)).not_to match_array(old.allergens.map(&:id)) }
    ```

  * **Line # 372 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change { Image.count }.by(allergens.count) }
    ```

  * **Line # 372 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
              it { expect { subject }.to change { Image.count }.by(allergens.count) }
    ```

  * **Line # 373 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change { ImageToRecord.count }.by(allergens.count) }
    ```

  * **Line # 373 - convention:** RSpec/ExpectChange: Prefer `change(ImageToRecord, :count)`.

    ```rb
              it { expect { subject }.to change { ImageToRecord.count }.by(allergens.count) }
    ```

  * **Line # 374 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change { ActiveStorage::Attachment.count }.by(allergens.count) }
    ```

  * **Line # 374 - convention:** RSpec/ExpectChange: Prefer `change(ActiveStorage::Attachment, :count)`.

    ```rb
              it { expect { subject }.to change { ActiveStorage::Attachment.count }.by(allergens.count) }
    ```

  * **Line # 375 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change { ActiveStorage::Blob.count }.by(allergens.count) }
    ```

  * **Line # 375 - convention:** RSpec/ExpectChange: Prefer `change(ActiveStorage::Blob, :count)`.

    ```rb
              it { expect { subject }.to change { ActiveStorage::Blob.count }.by(allergens.count) }
    ```

  * **Line # 382 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.result.allergens).not_to be_empty }
    ```

  * **Line # 383 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.result.allergens.map(&:id)).to match_array(allergens.map(&:id)) }
    ```

  * **Line # 384 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.result.allergens.map(&:id)).to match_array(old.allergens.map(&:id)) }
    ```

  * **Line # 385 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Menu::Allergen.count }) }
    ```

  * **Line # 385 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Allergen, :count)`.

    ```rb
            it { expect { subject }.not_to(change { Menu::Allergen.count }) }
    ```

  * **Line # 386 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Menu::AllergensInDish.count }.by(allergens.count) }
    ```

  * **Line # 386 - convention:** RSpec/ExpectChange: Prefer `change(Menu::AllergensInDish, :count)`.

    ```rb
            it { expect { subject }.to change { Menu::AllergensInDish.count }.by(allergens.count) }
    ```

  * **Line # 391 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 391 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
              it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 392 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { ImageToRecord.count }) }
    ```

  * **Line # 392 - convention:** RSpec/ExpectChange: Prefer `change(ImageToRecord, :count)`.

    ```rb
              it { expect { subject }.not_to(change { ImageToRecord.count }) }
    ```

  * **Line # 393 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { ActiveStorage::Attachment.count }) }
    ```

  * **Line # 393 - convention:** RSpec/ExpectChange: Prefer `change(ActiveStorage::Attachment, :count)`.

    ```rb
              it { expect { subject }.not_to(change { ActiveStorage::Attachment.count }) }
    ```

  * **Line # 394 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { ActiveStorage::Blob.count }) }
    ```

  * **Line # 394 - convention:** RSpec/ExpectChange: Prefer `change(ActiveStorage::Blob, :count)`.

    ```rb
              it { expect { subject }.not_to(change { ActiveStorage::Blob.count }) }
    ```

  * **Line # 401 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.result.allergens).to be_empty }
    ```

  * **Line # 402 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Menu::Allergen.count }) }
    ```

  * **Line # 402 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Allergen, :count)`.

    ```rb
            it { expect { subject }.not_to(change { Menu::Allergen.count }) }
    ```

  * **Line # 403 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Menu::AllergensInDish.count }) }
    ```

  * **Line # 403 - convention:** RSpec/ExpectChange: Prefer `change(Menu::AllergensInDish, :count)`.

    ```rb
            it { expect { subject }.not_to(change { Menu::AllergensInDish.count }) }
    ```

  * **Line # 420 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
              allow_any_instance_of(Menu::Allergen).to receive(:valid?).and_return(false)
    ```

  * **Line # 425 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Menu::Allergen.count }) }
    ```

  * **Line # 425 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Allergen, :count)`.

    ```rb
            it { expect { subject }.not_to(change { Menu::Allergen.count }) }
    ```

  * **Line # 426 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Menu::Tag.count }) }
    ```

  * **Line # 426 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Tag, :count)`.

    ```rb
            it { expect { subject }.not_to(change { Menu::Tag.count }) }
    ```

  * **Line # 427 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Menu::Ingredient.count }) }
    ```

  * **Line # 427 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Ingredient, :count)`.

    ```rb
            it { expect { subject }.not_to(change { Menu::Ingredient.count }) }
    ```

  * **Line # 428 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Menu::Dish.count }) }
    ```

  * **Line # 428 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Dish, :count)`.

    ```rb
            it { expect { subject }.not_to(change { Menu::Dish.count }) }
    ```

  * **Line # 429 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.errors).not_to be_empty }
    ```

  * **Line # 430 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.errors.full_messages.join(", ")).to include("Cannot copy allergen:") }
    ```

  * **Line # 431 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject).to be_invalid }
    ```

  * **Line # 431 - convention:** RSpec/Rails/NegationBeValid: Use `expect(...).not_to be_valid`.

    ```rb
            it { expect(subject).to be_invalid }
    ```

  * **Line # 436 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
              allow_any_instance_of(Menu::Tag).to receive(:valid?).and_return(false)
    ```

  * **Line # 441 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Menu::Allergen.count }) }
    ```

  * **Line # 441 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Allergen, :count)`.

    ```rb
            it { expect { subject }.not_to(change { Menu::Allergen.count }) }
    ```

  * **Line # 442 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Menu::Tag.count }) }
    ```

  * **Line # 442 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Tag, :count)`.

    ```rb
            it { expect { subject }.not_to(change { Menu::Tag.count }) }
    ```

  * **Line # 443 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Menu::Ingredient.count }) }
    ```

  * **Line # 443 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Ingredient, :count)`.

    ```rb
            it { expect { subject }.not_to(change { Menu::Ingredient.count }) }
    ```

  * **Line # 444 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Menu::Dish.count }) }
    ```

  * **Line # 444 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Dish, :count)`.

    ```rb
            it { expect { subject }.not_to(change { Menu::Dish.count }) }
    ```

  * **Line # 445 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.errors).not_to be_empty }
    ```

  * **Line # 446 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.errors.full_messages.join(", ")).to include("Cannot copy tag:") }
    ```

  * **Line # 447 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject).to be_invalid }
    ```

  * **Line # 447 - convention:** RSpec/Rails/NegationBeValid: Use `expect(...).not_to be_valid`.

    ```rb
            it { expect(subject).to be_invalid }
    ```

  * **Line # 452 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
              allow_any_instance_of(Menu::Ingredient).to receive(:valid?).and_return(false)
    ```

  * **Line # 457 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Menu::Allergen.count }) }
    ```

  * **Line # 457 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Allergen, :count)`.

    ```rb
            it { expect { subject }.not_to(change { Menu::Allergen.count }) }
    ```

  * **Line # 458 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Menu::Tag.count }) }
    ```

  * **Line # 458 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Tag, :count)`.

    ```rb
            it { expect { subject }.not_to(change { Menu::Tag.count }) }
    ```

  * **Line # 459 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Menu::Ingredient.count }) }
    ```

  * **Line # 459 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Ingredient, :count)`.

    ```rb
            it { expect { subject }.not_to(change { Menu::Ingredient.count }) }
    ```

  * **Line # 460 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Menu::Dish.count }) }
    ```

  * **Line # 460 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Dish, :count)`.

    ```rb
            it { expect { subject }.not_to(change { Menu::Dish.count }) }
    ```

  * **Line # 461 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.errors).not_to be_empty }
    ```

  * **Line # 462 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.errors.full_messages.join(", ")).to include("Cannot copy ingredient:") }
    ```

  * **Line # 463 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject).to be_invalid }
    ```

  * **Line # 463 - convention:** RSpec/Rails/NegationBeValid: Use `expect(...).not_to be_valid`.

    ```rb
            it { expect(subject).to be_invalid }
    ```

  * **Line # 468 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
              allow_any_instance_of(Menu::Dish).to receive(:valid?).and_return(false)
    ```

  * **Line # 471 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
              allow_any_instance_of(Menu::Dish).to receive(:errors).and_return(errors)
    ```

  * **Line # 474 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Menu::Allergen.count }) }
    ```

  * **Line # 474 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Allergen, :count)`.

    ```rb
            it { expect { subject }.not_to(change { Menu::Allergen.count }) }
    ```

  * **Line # 475 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Menu::Tag.count }) }
    ```

  * **Line # 475 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Tag, :count)`.

    ```rb
            it { expect { subject }.not_to(change { Menu::Tag.count }) }
    ```

  * **Line # 476 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Menu::Ingredient.count }) }
    ```

  * **Line # 476 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Ingredient, :count)`.

    ```rb
            it { expect { subject }.not_to(change { Menu::Ingredient.count }) }
    ```

  * **Line # 477 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Menu::Dish.count }) }
    ```

  * **Line # 477 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Dish, :count)`.

    ```rb
            it { expect { subject }.not_to(change { Menu::Dish.count }) }
    ```

  * **Line # 478 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.errors).not_to be_empty }
    ```

  * **Line # 479 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject).to be_invalid }
    ```

  * **Line # 479 - convention:** RSpec/Rails/NegationBeValid: Use `expect(...).not_to be_valid`.

    ```rb
            it { expect(subject).to be_invalid }
    ```

### spec/interactions/menu/copy_ingredient_spec.rb - (70 offenses)
  * **Line # 16 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect { subject }.to change(Menu::Ingredient, :count).by(1)
    ```

  * **Line # 20 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject).to be_valid
    ```

  * **Line # 23 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
          it "returns ingredient" do
    ```

  * **Line # 24 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result).to be_a(Menu::Ingredient)
    ```

  * **Line # 25 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result).to be_valid
    ```

  * **Line # 26 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result).to be_persisted
    ```

  * **Line # 29 - convention:** RSpec/NoExpectationExample: No expectation found in this example.

    ```rb
          it "enqueue a job to save the changes with current user info" do ...
    ```

  * **Line # 31 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            subject
    ```

  * **Line # 48 - convention:** RSpec/ExampleLength: Example has too many lines. [6/5]

    ```rb
            it "has name and description in all available locales" do ...
    ```

  * **Line # 48 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "has name and description in all available locales" do
    ```

  * **Line # 58 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it "copies name and description translations" do
    ```

  * **Line # 59 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.name).to eq(old.name)
    ```

  * **Line # 60 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.description).to eq(old.description)
    ```

  * **Line # 66 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject.result.name).to eq("Name in #{locale}")
    ```

  * **Line # 74 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject.result.description).to eq("Description in #{locale}")
    ```

  * **Line # 82 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.status).to eq(old.status)
    ```

  * **Line # 89 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it "copies other" do
    ```

  * **Line # 90 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.reload.other).to eq(old.other)
    ```

  * **Line # 91 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.other).to eq({ "foo" => "bar" })
    ```

  * **Line # 101 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.result.image).to be_present }
    ```

  * **Line # 103 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.errors).to be_empty }
    ```

  * **Line # 105 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { Image.count }.by(1) }
    ```

  * **Line # 105 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
          it { expect { subject }.to change { Image.count }.by(1) }
    ```

  * **Line # 106 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { ActiveStorage::Blob.count }.by(1) }
    ```

  * **Line # 106 - convention:** RSpec/ExpectChange: Prefer `change(ActiveStorage::Blob, :count)`.

    ```rb
          it { expect { subject }.to change { ActiveStorage::Blob.count }.by(1) }
    ```

  * **Line # 107 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { ActiveStorage::Attachment.count }.by(1) }
    ```

  * **Line # 107 - convention:** RSpec/ExpectChange: Prefer `change(ActiveStorage::Attachment, :count)`.

    ```rb
          it { expect { subject }.to change { ActiveStorage::Attachment.count }.by(1) }
    ```

  * **Line # 109 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.result.image.url).not_to eq ingredient.image.url }
    ```

  * **Line # 111 - convention:** RSpec/ExampleLength: Example has too many lines. [7/5]

    ```rb
          it "has a different image" do ...
    ```

  * **Line # 111 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it "has a different image" do
    ```

  * **Line # 112 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            new = subject.result
    ```

  * **Line # 129 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.result.image).to be_present }
    ```

  * **Line # 131 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.errors).to be_empty }
    ```

  * **Line # 133 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 133 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
          it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 134 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Blob.count }) }
    ```

  * **Line # 134 - convention:** RSpec/ExpectChange: Prefer `change(ActiveStorage::Blob, :count)`.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Blob.count }) }
    ```

  * **Line # 135 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Attachment.count }) }
    ```

  * **Line # 135 - convention:** RSpec/ExpectChange: Prefer `change(ActiveStorage::Attachment, :count)`.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Attachment.count }) }
    ```

  * **Line # 137 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.result.image.url).to eq ingredient.image.url }
    ```

  * **Line # 138 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.result.image.id).to eq ingredient.image.id }
    ```

  * **Line # 147 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.result.image).to be_nil }
    ```

  * **Line # 148 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.result.reload.image).to be_nil }
    ```

  * **Line # 150 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 150 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
          it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 151 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Blob.count }) }
    ```

  * **Line # 151 - convention:** RSpec/ExpectChange: Prefer `change(ActiveStorage::Blob, :count)`.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Blob.count }) }
    ```

  * **Line # 152 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Attachment.count }) }
    ```

  * **Line # 152 - convention:** RSpec/ExpectChange: Prefer `change(ActiveStorage::Attachment, :count)`.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Attachment.count }) }
    ```

  * **Line # 160 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.result.image).not_to be_present }
    ```

  * **Line # 162 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 162 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
          it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 163 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Blob.count }) }
    ```

  * **Line # 163 - convention:** RSpec/ExpectChange: Prefer `change(ActiveStorage::Blob, :count)`.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Blob.count }) }
    ```

  * **Line # 164 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Attachment.count }) }
    ```

  * **Line # 164 - convention:** RSpec/ExpectChange: Prefer `change(ActiveStorage::Attachment, :count)`.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Attachment.count }) }
    ```

  * **Line # 173 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
            allow_any_instance_of(Image).to receive(:valid?).and_return(false)
    ```

  * **Line # 176 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
            allow_any_instance_of(Image).to receive(:errors).and_return(errors)
    ```

  * **Line # 179 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it "does not create any record and returns errors" do
    ```

  * **Line # 180 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect { subject }.not_to(change { Image.count })
    ```

  * **Line # 180 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
            expect { subject }.not_to(change { Image.count })
    ```

  * **Line # 181 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.errors).not_to be_empty
    ```

  * **Line # 184 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { Menu::Allergen.count }) }
    ```

  * **Line # 184 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Allergen, :count)`.

    ```rb
          it { expect { subject }.not_to(change { Menu::Allergen.count }) }
    ```

  * **Line # 185 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Blob.count }) }
    ```

  * **Line # 185 - convention:** RSpec/ExpectChange: Prefer `change(ActiveStorage::Blob, :count)`.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Blob.count }) }
    ```

  * **Line # 186 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { Menu::AllergensInDish.count }) }
    ```

  * **Line # 186 - convention:** RSpec/ExpectChange: Prefer `change(Menu::AllergensInDish, :count)`.

    ```rb
          it { expect { subject }.not_to(change { Menu::AllergensInDish.count }) }
    ```

  * **Line # 187 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { ImageToRecord.count }) }
    ```

  * **Line # 187 - convention:** RSpec/ExpectChange: Prefer `change(ImageToRecord, :count)`.

    ```rb
          it { expect { subject }.not_to(change { ImageToRecord.count }) }
    ```

### spec/interactions/menu/copy_tag_spec.rb - (75 offenses)
  * **Line # 16 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect { subject }.to change(Menu::Tag, :count).by(1)
    ```

  * **Line # 20 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject).to be_valid
    ```

  * **Line # 23 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
          it "returns tag" do
    ```

  * **Line # 24 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result).to be_a(Menu::Tag)
    ```

  * **Line # 25 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result).to be_valid
    ```

  * **Line # 26 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result).to be_persisted
    ```

  * **Line # 29 - convention:** RSpec/NoExpectationExample: No expectation found in this example.

    ```rb
          it "enqueue a job to save the changes with current user info" do ...
    ```

  * **Line # 31 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            subject
    ```

  * **Line # 48 - convention:** RSpec/ExampleLength: Example has too many lines. [6/5]

    ```rb
            it "has name and description in all available locales" do ...
    ```

  * **Line # 48 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "has name and description in all available locales" do
    ```

  * **Line # 58 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it "copies name and description translations" do
    ```

  * **Line # 59 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.name).to eq(old.name)
    ```

  * **Line # 60 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.description).to eq(old.description)
    ```

  * **Line # 66 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject.result.name).to eq("Name in #{locale}")
    ```

  * **Line # 74 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject.result.description).to eq("Description in #{locale}")
    ```

  * **Line # 82 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.status).to eq(old.status)
    ```

  * **Line # 89 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it "copies color" do
    ```

  * **Line # 90 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.reload.color).to eq(old.color)
    ```

  * **Line # 91 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.color).to eq("#ff0000")
    ```

  * **Line # 98 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it "copies other" do
    ```

  * **Line # 99 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.reload.other).to eq(old.other)
    ```

  * **Line # 100 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.result.other).to eq({ "foo" => "bar" })
    ```

  * **Line # 110 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.result.image).to be_present }
    ```

  * **Line # 112 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.errors).to be_empty }
    ```

  * **Line # 114 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { Image.count }.by(1) }
    ```

  * **Line # 114 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
          it { expect { subject }.to change { Image.count }.by(1) }
    ```

  * **Line # 115 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { ActiveStorage::Blob.count }.by(1) }
    ```

  * **Line # 115 - convention:** RSpec/ExpectChange: Prefer `change(ActiveStorage::Blob, :count)`.

    ```rb
          it { expect { subject }.to change { ActiveStorage::Blob.count }.by(1) }
    ```

  * **Line # 116 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { ActiveStorage::Attachment.count }.by(1) }
    ```

  * **Line # 116 - convention:** RSpec/ExpectChange: Prefer `change(ActiveStorage::Attachment, :count)`.

    ```rb
          it { expect { subject }.to change { ActiveStorage::Attachment.count }.by(1) }
    ```

  * **Line # 118 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.result.image.url).not_to eq tag.image.url }
    ```

  * **Line # 120 - convention:** RSpec/ExampleLength: Example has too many lines. [7/5]

    ```rb
          it "has a different image" do ...
    ```

  * **Line # 120 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it "has a different image" do
    ```

  * **Line # 121 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            new = subject.result
    ```

  * **Line # 138 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.result.image).to be_present }
    ```

  * **Line # 140 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.errors).to be_empty }
    ```

  * **Line # 142 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 142 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
          it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 143 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Blob.count }) }
    ```

  * **Line # 143 - convention:** RSpec/ExpectChange: Prefer `change(ActiveStorage::Blob, :count)`.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Blob.count }) }
    ```

  * **Line # 144 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Attachment.count }) }
    ```

  * **Line # 144 - convention:** RSpec/ExpectChange: Prefer `change(ActiveStorage::Attachment, :count)`.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Attachment.count }) }
    ```

  * **Line # 146 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.result.image.url).to eq tag.image.url }
    ```

  * **Line # 147 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.result.image.id).to eq tag.image.id }
    ```

  * **Line # 156 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.result.image).to be_nil }
    ```

  * **Line # 157 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.result.reload.image).to be_nil }
    ```

  * **Line # 159 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 159 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
          it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 160 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Blob.count }) }
    ```

  * **Line # 160 - convention:** RSpec/ExpectChange: Prefer `change(ActiveStorage::Blob, :count)`.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Blob.count }) }
    ```

  * **Line # 161 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Attachment.count }) }
    ```

  * **Line # 161 - convention:** RSpec/ExpectChange: Prefer `change(ActiveStorage::Attachment, :count)`.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Attachment.count }) }
    ```

  * **Line # 169 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.result.image).not_to be_present }
    ```

  * **Line # 171 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 171 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
          it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 172 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Blob.count }) }
    ```

  * **Line # 172 - convention:** RSpec/ExpectChange: Prefer `change(ActiveStorage::Blob, :count)`.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Blob.count }) }
    ```

  * **Line # 173 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Attachment.count }) }
    ```

  * **Line # 173 - convention:** RSpec/ExpectChange: Prefer `change(ActiveStorage::Attachment, :count)`.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Attachment.count }) }
    ```

  * **Line # 182 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
            allow_any_instance_of(Image).to receive(:valid?).and_return(false)
    ```

  * **Line # 185 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
            allow_any_instance_of(Image).to receive(:errors).and_return(errors)
    ```

  * **Line # 188 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it "does not create any record and returns errors" do
    ```

  * **Line # 189 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect { subject }.not_to(change { Image.count })
    ```

  * **Line # 189 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
            expect { subject }.not_to(change { Image.count })
    ```

  * **Line # 190 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.errors).not_to be_empty
    ```

  * **Line # 193 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { Menu::Tag.count }) }
    ```

  * **Line # 193 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Tag, :count)`.

    ```rb
          it { expect { subject }.not_to(change { Menu::Tag.count }) }
    ```

  * **Line # 194 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { Menu::TagsInDish.count }) }
    ```

  * **Line # 194 - convention:** RSpec/ExpectChange: Prefer `change(Menu::TagsInDish, :count)`.

    ```rb
          it { expect { subject }.not_to(change { Menu::TagsInDish.count }) }
    ```

  * **Line # 195 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Blob.count }) }
    ```

  * **Line # 195 - convention:** RSpec/ExpectChange: Prefer `change(ActiveStorage::Blob, :count)`.

    ```rb
          it { expect { subject }.not_to(change { ActiveStorage::Blob.count }) }
    ```

  * **Line # 196 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { Menu::AllergensInDish.count }) }
    ```

  * **Line # 196 - convention:** RSpec/ExpectChange: Prefer `change(Menu::AllergensInDish, :count)`.

    ```rb
          it { expect { subject }.not_to(change { Menu::AllergensInDish.count }) }
    ```

  * **Line # 197 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { ImageToRecord.count }) }
    ```

  * **Line # 197 - convention:** RSpec/ExpectChange: Prefer `change(ImageToRecord, :count)`.

    ```rb
          it { expect { subject }.not_to(change { ImageToRecord.count }) }
    ```

### spec/interactions/remind_reservations_mail_spec.rb - (8 offenses)
  * **Line # 31 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it do
    ```

  * **Line # 46 - convention:** RSpec/ExpectChange: Prefer `change(Log::DeliveredEmail, :count)`.

    ```rb
          it { expect { described_class.run! }.to change { Log::DeliveredEmail.count }.by(2) }
    ```

  * **Line # 49 - convention:** Layout/LineLength: Line is too long. [132/120]

    ```rb
            context "when a reservation does not have email (email = #{blank_email.inspect}), won't send email for that reservation." do
    ```

  * **Line # 55 - convention:** RSpec/ExpectChange: Prefer `change(Log::DeliveredEmail, :count)`.

    ```rb
              it { expect { described_class.run! }.to change { Log::DeliveredEmail.count }.by(1) }
    ```

  * **Line # 63 - convention:** RSpec/ExpectChange: Prefer `change(Log::DeliveredEmail, :count)`.

    ```rb
            it { expect { described_class.run! }.not_to(change { Log::DeliveredEmail.count }) }
    ```

  * **Line # 76 - convention:** RSpec/ExpectChange: Prefer `change(Log::DeliveredEmail, :count)`.

    ```rb
            it { expect { described_class.run! }.not_to(change { Log::DeliveredEmail.count }) }
    ```

  * **Line # 104 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
        let!(:reservation_payment) { create(:reservation_payment, reservation:, status: :todo) }
    ```

  * **Line # 121 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
        let!(:reservation_payment) { create(:reservation_payment, reservation:, status: :paid) }
    ```

### spec/jobs/remind_reservation_payments_job_spec.rb - (1 offense)
  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe RemindReservationPaymentsJob, type: :job do
    ```

### spec/jobs/remind_reservations_mail_job_spec.rb - (1 offense)
  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe RemindReservationsMailJob, type: :job do
    ```

### spec/mailers/previews/user_mailer_preview.rb - (1 offense)
  * **Line # 27 - convention:** Metrics/AbcSize: Assignment Branch Condition size for parse_params is too high. [<4, 18, 4> 18.87/17]

    ```rb
      def parse_params ...
    ```

### spec/mailers/reservation_mailer/reservation_mailer.confirmation_spec.rb - (5 offenses)
  * **Line # 41 - convention:** Layout/LineLength: Line is too long. [131/120]

    ```rb
            expect(mail.html_part.body.encoded).to include(CGI.escapeHTML(I18n.t("reservation_mailer.confirmation.payment_completed")))
    ```

  * **Line # 54 - convention:** Layout/LineLength: Line is too long. [130/120]

    ```rb
            expect(mail.html_part.body.encoded).to include(CGI.escapeHTML(I18n.t("reservation_mailer.confirmation.remember_payment")))
    ```

  * **Line # 70 - convention:** Layout/LineLength: Line is too long. [134/120]

    ```rb
            expect(mail.html_part.body.encoded).not_to include(CGI.escapeHTML(I18n.t("reservation_mailer.confirmation.remember_payment")))
    ```

  * **Line # 106 - convention:** Layout/LineLength: Line is too long. [125/120]

    ```rb
                                                                                   fullname: reservation.fullname, locale: lang))
    ```

  * **Line # 118 - convention:** Performance/CollectionLiteralInLoop: Avoid immutable Array literals in loops. It is better to extract it into a local variable or a constant.

    ```rb
          [ ...
    ```

### spec/mailers/reservation_mailer/reservation_mailer.payment_received_spec.rb - (3 offenses)
  * **Line # 66 - convention:** Performance/Detect: Use `reverse.find` instead of `filter.last`.

    ```rb
          mail_to = mail.to_s.split("\n").flatten.filter { |j| j.starts_with?("To:") }.last
    ```

  * **Line # 122 - convention:** Layout/LineLength: Line is too long. [125/120]

    ```rb
                                                                                   fullname: reservation.fullname, locale: lang))
    ```

  * **Line # 127 - convention:** Layout/LineLength: Line is too long. [130/120]

    ```rb
                                                                              "reservation_mailer.payment_received.body", locale: lang
    ```

### spec/mailers/reservation_mailer/reservation_mailer.remind_payment_spec.rb - (5 offenses)
  * **Line # 66 - convention:** Performance/Detect: Use `reverse.find` instead of `filter.last`.

    ```rb
          mail_to = mail.to_s.split("\n").flatten.filter { |j| j.starts_with?("To:") }.last
    ```

  * **Line # 75 - convention:** RSpec/ExpectChange: Prefer `change(Log::DeliveredEmail, :count)`.

    ```rb
          expect { mail }.to(change { Log::DeliveredEmail.count }.by(1))
    ```

  * **Line # 78 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
        it do
    ```

  * **Line # 119 - convention:** RSpec/ExampleLength: Example has too many lines. [9/5]

    ```rb
            it do ...
    ```

  * **Line # 143 - convention:** Layout/LineLength: Line is too long. [125/120]

    ```rb
                                                                                   fullname: reservation.fullname, locale: lang))
    ```

### spec/mailers/reservation_mailer/reservation_mailer.reminder_spec.rb - (2 offenses)
  * **Line # 66 - convention:** Performance/Detect: Use `reverse.find` instead of `filter.last`.

    ```rb
          mail_to = mail.to_s.split("\n").flatten.filter { |j| j.starts_with?("To:") }.last
    ```

  * **Line # 106 - convention:** Layout/LineLength: Line is too long. [125/120]

    ```rb
                                                                                   fullname: reservation.fullname, locale: lang))
    ```

### spec/mailers/user_mailer/user_mailer.email_updated_spec.rb - (3 offenses)
  * **Line # 117 - convention:** Layout/LineLength: Line is too long. [122/120]

    ```rb
                                                                                                        new_email: user.email)
    ```

  * **Line # 129 - convention:** Layout/LineLength: Line is too long. [152/120]

    ```rb
            #     expect(mail.html_part.body.encoded).to include CGI.escapeHTML(I18n.t("user_mailer.email_updated.body", old_email:, new_email: user.email))
    ```

  * **Line # 143 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it "if user is deleted raise error" do
    ```

### spec/mailers/user_mailer/user_mailer.email_verification_otp_spec.rb - (3 offenses)
  * **Line # 106 - convention:** Layout/LineLength: Line is too long. [123/120]

    ```rb
                expect(mail.html_part.body.encoded).to include CGI.escapeHTML(I18n.t("user_mailer.email_verification_otp.body",
    ```

  * **Line # 107 - convention:** Layout/LineLength: Line is too long. [134/120]

    ```rb
                                                                                     app_name: Config.hash[:app_name], email: user.email))
    ```

  * **Line # 121 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it "if user is deleted raise error" do
    ```

### spec/mailers/user_mailer/user_mailer.password_updated_spec.rb - (2 offenses)
  * **Line # 76 - convention:** Layout/LineLength: Line is too long. [134/120]

    ```rb
                                                                                     app_name: Config.hash[:app_name], email: user.email))
    ```

  * **Line # 98 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it "if user is deleted raise error" do
    ```

### spec/mailers/user_mailer/user_mailer.reset_password_spec.rb - (2 offenses)
  * **Line # 91 - convention:** Layout/LineLength: Line is too long. [123/120]

    ```rb
                expect(mail.html_part.body.encoded).not_to include CGI.escapeHTML(I18n.t("user_mailer.reset_password.subject"))
    ```

  * **Line # 131 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it "if user is deleted raise error" do
    ```

### spec/mailers/user_mailer/user_mailer.welcome_staffer_spec.rb - (2 offenses)
  * **Line # 75 - convention:** Layout/LineLength: Line is too long. [125/120]

    ```rb
                expect(mail.html_part.body.encoded).not_to include(CGI.escapeHTML(I18n.t("user_mailer.welcome_staffer.subject")))
    ```

  * **Line # 115 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it "if user is deleted raise error" do
    ```

### spec/matchers/active_interaction_matchers.rb - (3 offenses)
  * **Line # 168 - convention:** Style/IfWithBooleanLiteralBranches: Remove redundant ternary operator with boolean literal branches.

    ```rb
        @different_options.empty? ? true : false
    ```

  * **Line # 175 - convention:** Metrics/CyclomaticComplexity: Cyclomatic complexity for check_input_type is too high. [8/7]

    ```rb
      def check_input_type ...
    ```

  * **Line # 175 - convention:** Metrics/MethodLength: Method has too many lines. [11/10]

    ```rb
      def check_input_type ...
    ```

### spec/matchers/active_interaction_matchers_example.rb - (2 offenses)
  * **Line # 21 - convention:** Rails/Date: Do not use `Date.today` without zone. Use `Time.zone.today` instead.

    ```rb
      date :optional_date, default: Date.today
    ```

  * **Line # 24 - convention:** Rails/TimeZone: Do not use `Time.now` without zone. Use one of `Time.zone.now`, `Time.current`, `Time.now.in_time_zone`, `Time.now.utc`, `Time.now.getlocal`, `Time.now.xmlschema`, `Time.now.iso8601`, `Time.now.jisx0301`, `Time.now.rfc3339`, `Time.now.httpdate`, `Time.now.to_i`, `Time.now.to_f` instead.

    ```rb
      time :optional_time, default: Time.now
    ```

### spec/matchers/active_interaction_matchers_spec.rb - (20 offenses)
  * **Line # 5 - warning:** Lint/UnreachableCode: Unreachable code detected.

    ```rb
    require "rails_helper"
    ```

  * **Line # 7 - convention:** RSpec/FilePath: Spec path should end with `active_interaction_matchers_example*_spec.rb`.

    ```rb
    RSpec.describe ActiveInteractionMatchersExample, type: :interaction do
    ```

  * **Line # 7 - convention:** RSpec/SpecFilePathFormat: Spec path should end with `active_interaction_matchers_example*_spec.rb`.

    ```rb
    RSpec.describe ActiveInteractionMatchersExample, type: :interaction do
    ```

  * **Line # 10 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to have_input(:mandatory_string)
    ```

  * **Line # 14 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).not_to have_input(:not_existing_input)
    ```

  * **Line # 20 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to have_input(:mandatory_string).mandatory
    ```

  * **Line # 24 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).not_to have_input(:mandatory_string).optional
    ```

  * **Line # 30 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to have_input(:mandatory_string).without_default_value
    ```

  * **Line # 34 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).not_to have_input(:mandatory_string).with_default_value
    ```

  * **Line # 40 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to have_input(:optional_string).optional
    ```

  * **Line # 44 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).not_to have_input(:optional_string).mandatory
    ```

  * **Line # 50 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to have_input(:optional_string).with_default_value("default value")
    ```

  * **Line # 54 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to have_input(:optional_integer).with_default_value(1)
    ```

  * **Line # 58 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).not_to have_input(:mandatory_integer).with_default_value(2)
    ```

  * **Line # 64 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to have_input(:optional_string).of_type(String)
    ```

  * **Line # 68 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to have_input(:optional_string).of_type("string")
    ```

  * **Line # 72 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to have_input(:optional_string).of_type(:string)
    ```

  * **Line # 76 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to have_input(:optional_string).of_type(:String)
    ```

  * **Line # 80 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to have_input(:optional_string).of_type("String")
    ```

  * **Line # 84 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).not_to have_input(:optional_string).of_type("InvalidString")
    ```

### spec/models/contact_spec.rb - (3 offenses)
  * **Line # 10 - convention:** Style/HashEachMethods: Use `each_key` instead of `keys.each`.

    ```rb
          Contact::DEFAULTS.keys.each do |key|
    ```

  * **Line # 23 - convention:** Performance/CollectionLiteralInLoop: Avoid immutable Array literals in loops. It is better to extract it into a local variable or a constant.

    ```rb
          [ ...
    ```

  * **Line # 28 - convention:** RSpec/DescribedClass: Use `described_class` instead of `Contact`.

    ```rb
              before { Contact.create!(key: contact_key, value: blank_value) }
    ```

### spec/models/image_spec.rb - (46 offenses)
  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe Image, type: :model do
    ```

  * **Line # 37 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject.children << child }.to change { subject.children.count }.by(1) }
    ```

  * **Line # 37 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject.children << child }.to change { subject.children.count }.by(1) }
    ```

  * **Line # 40 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              before { subject.children << child }
    ```

  * **Line # 42 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.children).to include(child) }
    ```

  * **Line # 43 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(child.original).to eq(subject) }
    ```

  * **Line # 44 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(child.original_id).to eq(subject.id) }
    ```

  * **Line # 47 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                before { subject.destroy! }
    ```

  * **Line # 68 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.attached_image).to be_an_instance_of(ActiveStorage::Attached::One) }
    ```

  * **Line # 72 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              subject.attached_image.attach(io: File.open(spec_image), filename: "miao miao")
    ```

  * **Line # 88 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.defined_enums.keys).to include("status") }
    ```

  * **Line # 98 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.defined_enums.keys).to include("tag") }
    ```

  * **Line # 108 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.original).to be_an_instance_of(Image) }
    ```

  * **Line # 108 - convention:** RSpec/DescribedClass: Use `described_class` instead of `Image`.

    ```rb
          it { expect(subject.original).to be_an_instance_of(Image) }
    ```

  * **Line # 109 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject.update!(tag: nil) }.to raise_error(ActiveRecord::RecordInvalid) }
    ```

  * **Line # 117 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.original).to be_nil }
    ```

  * **Line # 118 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject.update!(tag: nil) }.not_to raise_error }
    ```

  * **Line # 129 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject).to respond_to(:is_original?) }
    ```

  * **Line # 130 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.original).to be_nil }
    ```

  * **Line # 131 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.original_id).to be_nil }
    ```

  * **Line # 140 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject).to respond_to(:blur_image) }
    ```

  * **Line # 141 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.original).to be_nil }
    ```

  * **Line # 142 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.original_id).to be_nil }
    ```

  * **Line # 143 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.children).to be_empty }
    ```

  * **Line # 148 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.children).to be_empty }
    ```

  * **Line # 149 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject.blur_image }.not_to(change { subject.children.count }) }
    ```

  * **Line # 149 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject.blur_image }.not_to(change { subject.children.count }) }
    ```

  * **Line # 150 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.blur_image).to be_nil }
    ```

  * **Line # 162 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject).to respond_to(:url) }
    ```

  * **Line # 182 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.to_sql).to include('WHERE "images"."original_id" IS NULL') }
    ```

  * **Line # 183 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.count).to eq(2) }
    ```

  * **Line # 185 - convention:** RSpec/IteratedExpectation: Prefer using the `all` matcher instead of iterating over an array.

    ```rb
          it { subject.each { |item| expect(item).to be_is_original } }
    ```

  * **Line # 185 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { subject.each { |item| expect(item).to be_is_original } }
    ```

  * **Line # 186 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.pluck(:original_id).uniq).to eq [nil] }
    ```

  * **Line # 200 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.to_sql).to include('WHERE "images"."original_id" IS NOT NULL') }
    ```

  * **Line # 201 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.count).to eq(1) }
    ```

  * **Line # 203 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { subject.each { |item| expect(item).not_to be_is_original } }
    ```

  * **Line # 204 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.pluck(:original_id).uniq).not_to eq [nil] }
    ```

  * **Line # 214 - convention:** RSpec/DescribedClass: Use `described_class` instead of `Image`.

    ```rb
          it { expect(Image.count).to eq 2 }
    ```

  * **Line # 215 - convention:** RSpec/DescribedClass: Use `described_class` instead of `Image`.

    ```rb
          it { expect(Image.active.count).to eq 1 }
    ```

  * **Line # 216 - convention:** RSpec/DescribedClass: Use `described_class` instead of `Image`.

    ```rb
          it { expect(Image.deleted.count).to eq 1 }
    ```

  * **Line # 217 - convention:** RSpec/DescribedClass: Use `described_class` instead of `Image`.

    ```rb
          it { expect(Image.visible.count).to eq 1 }
    ```

  * **Line # 227 - convention:** RSpec/DescribedClass: Use `described_class` instead of `Image`.

    ```rb
          it { expect(Image.count).to eq 3 }
    ```

  * **Line # 228 - convention:** RSpec/DescribedClass: Use `described_class` instead of `Image`.

    ```rb
          it { expect(Image.with_attached_image.count).to eq 2 }
    ```

  * **Line # 229 - convention:** RSpec/DescribedClass: Use `described_class` instead of `Image`.

    ```rb
          it { expect(Image.with_attached_image.pluck(:id).uniq.sort!).to eq Image.with_attached_image.pluck(:id).sort! }
    ```

  * **Line # 229 - convention:** RSpec/DescribedClass: Use `described_class` instead of `Image`.

    ```rb
          it { expect(Image.with_attached_image.pluck(:id).uniq.sort!).to eq Image.with_attached_image.pluck(:id).sort! }
    ```

### spec/models/log/delivered_email_spec.rb - (1 offense)
  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe Log::DeliveredEmail, type: :model do
    ```

### spec/models/log/image_pixel_event_spec.rb - (2 offenses)
  * **Line # 1 - convention:** Style/FrozenStringLiteralComment: Missing frozen string literal comment.

    ```rb
    require "rails_helper"
    ```

  * **Line # 3 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe Log::ImagePixelEvent, type: :model do
    ```

### spec/models/log/image_pixel_spec.rb - (3 offenses)
  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe Log::ImagePixel, type: :model do
    ```

  * **Line # 29 - convention:** RSpec/ExpectChange: Prefer `change(pixel, :record_id)`.

    ```rb
          it { expect { pixel.record = create(:user) }.to change { pixel.record_id }.from(pixel.record_id) }
    ```

  * **Line # 33 - convention:** RSpec/ExpectChange: Prefer `change(pixel, :image_id)`.

    ```rb
          it { expect { pixel.image = create(:image) }.to change { pixel.image_id }.from(pixel.image_id) }
    ```

### spec/models/log/model_change_spec.rb - (2 offenses)
  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe Log::ModelChange, type: :model do
    ```

  * **Line # 19 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
          allow_any_instance_of(described_class).to receive(:assign_defaults).and_return(true)
    ```

### spec/models/menu/allergen_spec.rb - (15 offenses)
  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe Menu::Allergen, type: :model do
    ```

  * **Line # 35 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
        it { expect { subject.save! }.not_to raise_error }
    ```

  * **Line # 36 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
        it { expect(subject.save).to eq true }
    ```

  * **Line # 36 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
        it { expect(subject.save).to eq true }
    ```

  * **Line # 47 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
        before { allow_any_instance_of(described_class).to receive(:assign_defaults).and_return(true) }
    ```

  * **Line # 52 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
        it { expect(subject.defined_enums.keys).to include("status") }
    ```

  * **Line # 69 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject.dishes = [create(:menu_dish)] }.not_to raise_error }
    ```

  * **Line # 72 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            before { subject.dishes = [create(:menu_dish)] }
    ```

  * **Line # 76 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.dishes.count).to eq 1 }
    ```

  * **Line # 77 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.dishes).to all(be_a Menu::Dish) }
    ```

  * **Line # 86 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject.menu_dishes = [create(:menu_dish)] }.not_to raise_error }
    ```

  * **Line # 89 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            before { subject.menu_dishes = [create(:menu_dish)] }
    ```

  * **Line # 93 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.dishes.count).to eq 1 }
    ```

  * **Line # 94 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.dishes).to all(be_a Menu::Dish) }
    ```

  * **Line # 104 - convention:** RSpec/DescribedClass: Use `described_class` instead of `Menu::Allergen`.

    ```rb
          it { expect { menu_allergen.destroy }.to change(Menu::Allergen, :count).by(-1) }
    ```

### spec/models/menu/allergens_in_dish_spec.rb - (4 offenses)
  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe Menu::AllergensInDish, type: :model do
    ```

  * **Line # 12 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
        it { expect { subject.save! }.not_to raise_error }
    ```

  * **Line # 13 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
        it { expect(subject.save).to eq true }
    ```

  * **Line # 13 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
        it { expect(subject.save).to eq true }
    ```

### spec/models/menu/category_spec.rb - (66 offenses)
  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe Menu::Category, type: :model do
    ```

  * **Line # 39 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
        it { expect { subject.save! }.not_to raise_error }
    ```

  * **Line # 46 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
          before { allow_any_instance_of(Menu::Category).to receive(:assign_defaults).and_return(true) }
    ```

  * **Line # 46 - convention:** RSpec/DescribedClass: Use `described_class` instead of `Menu::Category`.

    ```rb
          before { allow_any_instance_of(Menu::Category).to receive(:assign_defaults).and_return(true) }
    ```

  * **Line # 98 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
              it do
    ```

  * **Line # 116 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              before { subject.parent_id = subject.id }
    ```

  * **Line # 116 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              before { subject.parent_id = subject.id }
    ```

  * **Line # 119 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.save).to eq false }
    ```

  * **Line # 119 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
              it { expect(subject.save).to eq false }
    ```

  * **Line # 120 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
    ```

  * **Line # 170 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject).not_to be_valid }
    ```

  * **Line # 171 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject).not_to be_persisted }
    ```

  * **Line # 172 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.validate).to be false }
    ```

  * **Line # 173 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
    ```

  * **Line # 175 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it "has errors in :secret field" do
    ```

  * **Line # 176 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            subject.validate
    ```

  * **Line # 177 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.errors[:secret]).to be_a(Array)
    ```

  * **Line # 178 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.errors[:secret].count).to be > 0
    ```

  * **Line # 190 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject).not_to be_valid }
    ```

  * **Line # 191 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject).not_to be_persisted }
    ```

  * **Line # 192 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.validate).to be false }
    ```

  * **Line # 193 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
    ```

  * **Line # 195 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it "has errors in :secret_desc field" do
    ```

  * **Line # 196 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            subject.validate
    ```

  * **Line # 197 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.errors[:secret_desc]).to be_a(Array)
    ```

  * **Line # 198 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.errors[:secret_desc].count).to be > 0
    ```

  * **Line # 204 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
        before { allow_any_instance_of(Menu::Category).to receive(:assign_defaults).and_return(true) }
    ```

  * **Line # 204 - convention:** RSpec/DescribedClass: Use `described_class` instead of `Menu::Category`.

    ```rb
        before { allow_any_instance_of(Menu::Category).to receive(:assign_defaults).and_return(true) }
    ```

  * **Line # 213 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
          let!(:dish_in_category) { create(:menu_dishes_in_category, menu_dish: dish, menu_category: category) }
    ```

  * **Line # 221 - convention:** RSpec/ExpectChange: Prefer `change(Menu::DishesInCategory, :count)`.

    ```rb
          it { expect { category.destroy! }.to change { Menu::DishesInCategory.count }.by(-1) }
    ```

  * **Line # 222 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Visibility, :count)`.

    ```rb
          it { expect { category.destroy! }.to change { Menu::Visibility.count }.by(-1) }
    ```

  * **Line # 223 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Dish, :count)`.

    ```rb
          it { expect { category.destroy! }.not_to(change { Menu::Dish.count }) }
    ```

  * **Line # 251 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.save!).to be true }
    ```

  * **Line # 252 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject.save! }.not_to raise_error }
    ```

  * **Line # 259 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.save!).to be true }
    ```

  * **Line # 260 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject.save! }.not_to raise_error }
    ```

  * **Line # 270 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.dishes.count).to eq 0 }
    ```

  * **Line # 276 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
          it "works" do
    ```

  * **Line # 276 - convention:** RSpec/ExampleWording: Your example description is insufficient.

    ```rb
          it "works" do
    ```

  * **Line # 277 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect { subject.dishes = dishes }.not_to raise_error
    ```

  * **Line # 278 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.reload.dishes.count).to eq 2
    ```

  * **Line # 279 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.dishes.map(&:id)).to match_array(dishes.map(&:id))
    ```

  * **Line # 281 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(dishes.map(&:categories).flatten.map(&:id).uniq).to eq [subject.id]
    ```

  * **Line # 291 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject).to be_valid }
    ```

  * **Line # 292 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject).to be_persisted }
    ```

  * **Line # 293 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.parent).to eq parent }
    ```

  * **Line # 294 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.menu_visibility).to be_nil }
    ```

  * **Line # 295 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.visibility).to be_nil }
    ```

  * **Line # 300 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect { subject.update!(menu_visibility: visibility) }.to raise_error(ActiveRecord::RecordInvalid)
    ```

  * **Line # 303 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it "is not valid" do
    ```

  * **Line # 304 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            subject.menu_visibility = visibility
    ```

  * **Line # 305 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject).to be_invalid
    ```

  * **Line # 305 - convention:** RSpec/Rails/NegationBeValid: Use `expect(...).not_to be_valid`.

    ```rb
            expect(subject).to be_invalid
    ```

  * **Line # 306 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.errors[:visibility]).to be_present
    ```

  * **Line # 317 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.dishes.count).to eq 2 }
    ```

  * **Line # 319 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
          it "works" do
    ```

  * **Line # 319 - convention:** RSpec/ExampleWording: Your example description is insufficient.

    ```rb
          it "works" do
    ```

  * **Line # 320 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect { subject.dishes << dish }.not_to raise_error
    ```

  * **Line # 321 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.reload.dishes.count).to eq 3
    ```

  * **Line # 322 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(dish.categories.map(&:id).uniq).to eq [subject.id]
    ```

  * **Line # 350 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.visibility).to eq subject.menu_visibility }
    ```

  * **Line # 350 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.visibility).to eq subject.menu_visibility }
    ```

  * **Line # 376 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
          let!(:with_price) { create_list(:menu_category, 2, price: 5.2) }
    ```

  * **Line # 377 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
          let!(:without_price) { create_list(:menu_category, 2, price: nil) }
    ```

  * **Line # 382 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
          it { expect(described_class.without_fixed_price.map(&:price)).to all(eq nil) }
    ```

  * **Line # 386 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
          it { expect(described_class.without_price.map(&:price)).to all(eq nil) }
    ```

### spec/models/menu/dish_spec.rb - (29 offenses)
  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe Menu::Dish, type: :model do
    ```

  * **Line # 35 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
        it { expect(subject.save).to eq true }
    ```

  * **Line # 35 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
        it { expect(subject.save).to eq true }
    ```

  * **Line # 36 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
        it { expect { subject.save! }.not_to raise_error }
    ```

  * **Line # 53 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.save).to eq false }
    ```

  * **Line # 53 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
            it { expect(subject.save).to eq false }
    ```

  * **Line # 54 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject.save! }.to raise_error ActiveRecord::RecordInvalid }
    ```

  * **Line # 75 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
          it do
    ```

  * **Line # 82 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it do
    ```

  * **Line # 95 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.categories.count).to eq 0 }
    ```

  * **Line # 98 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it "assigns category" do
    ```

  * **Line # 99 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            subject.categories = [category]
    ```

  * **Line # 100 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.reload.categories.count).to eq 1
    ```

  * **Line # 110 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
          let!(:dish_in_category) { create(:menu_dishes_in_category, menu_dish: dish, menu_category: category) }
    ```

  * **Line # 118 - convention:** RSpec/ExpectChange: Prefer `change(Menu::DishesInCategory, :count)`.

    ```rb
          it { expect { dish.destroy! }.to change { Menu::DishesInCategory.count }.by(-1) }
    ```

  * **Line # 119 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Visibility, :count)`.

    ```rb
          it { expect { dish.destroy! }.not_to(change { Menu::Visibility.count }) }
    ```

  * **Line # 120 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Category, :count)`.

    ```rb
          it { expect { dish.destroy! }.not_to(change { Menu::Category.count }) }
    ```

  * **Line # 136 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.ingredients.count).to eq 0 }
    ```

  * **Line # 139 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "assigns ingredient" do
    ```

  * **Line # 140 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              subject.ingredients = [ingredient]
    ```

  * **Line # 141 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject.reload.ingredients.count).to eq 1
    ```

  * **Line # 160 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.allergens.count).to eq 0 }
    ```

  * **Line # 163 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "assigns allergen" do
    ```

  * **Line # 164 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              subject.allergens = [allergen]
    ```

  * **Line # 165 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject.reload.allergens.count).to eq 1
    ```

  * **Line # 184 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.tags.count).to eq 0 }
    ```

  * **Line # 187 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "assigns tag" do
    ```

  * **Line # 188 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              subject.tags = [tag]
    ```

  * **Line # 189 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject.reload.tags.count).to eq 1
    ```

### spec/models/menu/dish_suggestion_spec.rb - (2 offenses)
  * **Line # 1 - convention:** Style/FrozenStringLiteralComment: Missing frozen string literal comment.

    ```rb
    require "rails_helper"
    ```

  * **Line # 3 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe Menu::DishSuggestion, type: :model do
    ```

### spec/models/menu/dishes_in_category_spec.rb - (8 offenses)
  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe Menu::DishesInCategory, type: :model do
    ```

  * **Line # 12 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
        it { expect { subject.save! }.not_to raise_error }
    ```

  * **Line # 36 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
        it { expect(subject.save!).to be true }
    ```

  * **Line # 37 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
        it { expect { subject.save! }.not_to raise_error }
    ```

  * **Line # 47 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
        it { expect { subject.destroy! }.not_to(change { Menu::Dish.count }) }
    ```

  * **Line # 47 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Dish, :count)`.

    ```rb
        it { expect { subject.destroy! }.not_to(change { Menu::Dish.count }) }
    ```

  * **Line # 48 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
        it { expect { subject.destroy! }.not_to(change { Menu::Category.count }) }
    ```

  * **Line # 48 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Category, :count)`.

    ```rb
        it { expect { subject.destroy! }.not_to(change { Menu::Category.count }) }
    ```

### spec/models/menu/ingredient_spec.rb - (15 offenses)
  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe Menu::Ingredient, type: :model do
    ```

  * **Line # 35 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
        it { expect { subject.save! }.not_to raise_error }
    ```

  * **Line # 36 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
        it { expect(subject.save).to eq true }
    ```

  * **Line # 36 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
        it { expect(subject.save).to eq true }
    ```

  * **Line # 47 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
        before { allow_any_instance_of(described_class).to receive(:assign_defaults).and_return(true) }
    ```

  * **Line # 52 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
        it { expect(subject.defined_enums.keys).to include("status") }
    ```

  * **Line # 69 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject.dishes = [create(:menu_dish)] }.not_to raise_error }
    ```

  * **Line # 72 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            before { subject.dishes = [create(:menu_dish)] }
    ```

  * **Line # 76 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.dishes.count).to eq 1 }
    ```

  * **Line # 77 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.dishes).to all(be_a Menu::Dish) }
    ```

  * **Line # 86 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject.menu_dishes = [create(:menu_dish)] }.not_to raise_error }
    ```

  * **Line # 89 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            before { subject.menu_dishes = [create(:menu_dish)] }
    ```

  * **Line # 93 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.dishes.count).to eq 1 }
    ```

  * **Line # 94 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.dishes).to all(be_a Menu::Dish) }
    ```

  * **Line # 104 - convention:** RSpec/DescribedClass: Use `described_class` instead of `Menu::Ingredient`.

    ```rb
          it { expect { menu_ingredient.destroy }.to change(Menu::Ingredient, :count).by(-1) }
    ```

### spec/models/menu/ingredients_in_dish_spec.rb - (4 offenses)
  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe Menu::IngredientsInDish, type: :model do
    ```

  * **Line # 12 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
        it { expect { subject.save! }.not_to raise_error }
    ```

  * **Line # 13 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
        it { expect(subject.save).to eq true }
    ```

  * **Line # 13 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
        it { expect(subject.save).to eq true }
    ```

### spec/models/menu/tag_spec.rb - (15 offenses)
  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe Menu::Tag, type: :model do
    ```

  * **Line # 35 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
        it { expect { subject.save! }.not_to raise_error }
    ```

  * **Line # 36 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
        it { expect(subject.save).to eq true }
    ```

  * **Line # 36 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
        it { expect(subject.save).to eq true }
    ```

  * **Line # 47 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
        before { allow_any_instance_of(described_class).to receive(:assign_defaults).and_return(true) }
    ```

  * **Line # 52 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
        it { expect(subject.defined_enums.keys).to include("status") }
    ```

  * **Line # 69 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject.dishes = [create(:menu_dish)] }.not_to raise_error }
    ```

  * **Line # 72 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            before { subject.dishes = [create(:menu_dish)] }
    ```

  * **Line # 76 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.dishes.count).to eq 1 }
    ```

  * **Line # 77 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.dishes).to all(be_a Menu::Dish) }
    ```

  * **Line # 86 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject.menu_dishes = [create(:menu_dish)] }.not_to raise_error }
    ```

  * **Line # 89 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            before { subject.menu_dishes = [create(:menu_dish)] }
    ```

  * **Line # 93 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.dishes.count).to eq 1 }
    ```

  * **Line # 94 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.dishes).to all(be_a Menu::Dish) }
    ```

  * **Line # 104 - convention:** RSpec/DescribedClass: Use `described_class` instead of `Menu::Tag`.

    ```rb
          it { expect { menu_tag.destroy }.to change(Menu::Tag, :count).by(-1) }
    ```

### spec/models/menu/tags_in_dish_spec.rb - (4 offenses)
  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe Menu::TagsInDish, type: :model do
    ```

  * **Line # 12 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
        it { expect { subject.save! }.not_to raise_error }
    ```

  * **Line # 13 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
        it { expect(subject.save).to eq true }
    ```

  * **Line # 13 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
        it { expect(subject.save).to eq true }
    ```

### spec/models/menu/visibility_spec.rb - (23 offenses)
  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe Menu::Visibility, type: :model do
    ```

  * **Line # 19 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject.save! }.not_to raise_error }
    ```

  * **Line # 26 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject.save! }.not_to raise_error }
    ```

  * **Line # 57 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject.public! }.not_to raise_error }
    ```

  * **Line # 58 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.public!).to eq true }
    ```

  * **Line # 58 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
            it { expect(subject.public!).to eq true }
    ```

  * **Line # 64 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject.public! }.not_to raise_error }
    ```

  * **Line # 65 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.public!).to eq true }
    ```

  * **Line # 65 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
            it { expect(subject.public!).to eq true }
    ```

  * **Line # 75 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject.private! }.not_to raise_error }
    ```

  * **Line # 76 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.private!).to eq true }
    ```

  * **Line # 76 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
            it { expect(subject.private!).to eq true }
    ```

  * **Line # 82 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject.private! }.not_to raise_error }
    ```

  * **Line # 83 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.private!).to eq true }
    ```

  * **Line # 83 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
            it { expect(subject.private!).to eq true }
    ```

  * **Line # 94 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.public?).to be true }
    ```

  * **Line # 95 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject.public? }.not_to raise_error }
    ```

  * **Line # 102 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.public?).to be false }
    ```

  * **Line # 103 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject.public? }.not_to raise_error }
    ```

  * **Line # 114 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.private?).to be true }
    ```

  * **Line # 115 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject.private? }.not_to raise_error }
    ```

  * **Line # 122 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.private?).to be false }
    ```

  * **Line # 123 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject.private? }.not_to raise_error }
    ```

### spec/models/nexi/http_request_spec.rb - (1 offense)
  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe Nexi::HttpRequest, type: :model do
    ```

### spec/models/preference/DEFAULTS_spec.rb - (12 offenses)
  * **Line # 1 - convention:** Naming/FileName: The name of this source file (`DEFAULTS_spec.rb`) should use snake_case.

    ```rb
    # frozen_string_literal: true
    ```

  * **Line # 5 - convention:** RSpec/FilePath: Spec path should end with `preference/defaults*_spec.rb`.

    ```rb
    RSpec.describe Preference::DEFAULTS do
    ```

  * **Line # 5 - convention:** RSpec/SpecFilePathFormat: Spec path should end with `preference/defaults*_spec.rb`.

    ```rb
    RSpec.describe Preference::DEFAULTS do
    ```

  * **Line # 12 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
        expect(subject.keys.uniq).to match_array(subject.keys)
    ```

  * **Line # 12 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
        expect(subject.keys.uniq).to match_array(subject.keys)
    ```

  * **Line # 15 - convention:** RSpec/ExampleLength: Example has too many lines. [8/5]

    ```rb
      it "alls be valid Preference" do ...
    ```

  * **Line # 15 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
      it "alls be valid Preference" do
    ```

  * **Line # 19 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
        subject.each do |key, preference_data|
    ```

  * **Line # 28 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
        it "has a #{key} preference" do
    ```

  * **Line # 29 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject[key]).to be_a(Hash)
    ```

  * **Line # 30 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject[key.to_s]).to be_a(Hash)
    ```

  * **Line # 31 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject[key.to_sym]).to be_a(Hash)
    ```

### spec/models/preference_spec.rb - (12 offenses)
  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe Preference, type: :model do
    ```

  * **Line # 41 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
    ```

  * **Line # 43 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it "has errors on key" do
    ```

  * **Line # 44 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            subject.save
    ```

  * **Line # 45 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject).not_to be_persisted
    ```

  * **Line # 46 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.errors[:key]).not_to be_empty
    ```

  * **Line # 54 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
    ```

  * **Line # 61 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject.save! }.not_to raise_error }
    ```

  * **Line # 66 - convention:** RSpec/DescribedClass: Use `described_class` instead of `Preference`.

    ```rb
        subject { Preference }
    ```

  * **Line # 81 - convention:** RSpec/ExpectChange: Prefer `change(described_class, :count)`.

    ```rb
              it { expect { doit }.to change { described_class.count }.by(Preference::DEFAULTS.count) }
    ```

  * **Line # 96 - convention:** RSpec/ExpectChange: Prefer `change(described_class, :count)`.

    ```rb
              it { expect { doit }.to change { described_class.count }.by(Preference::DEFAULTS.count - 1) }
    ```

  * **Line # 110 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
            it { expect(doit).to eq nil }
    ```

### spec/models/preorder_reservation_date_spec.rb - (2 offenses)
  * **Line # 1 - convention:** Style/FrozenStringLiteralComment: Missing frozen string literal comment.

    ```rb
    require "rails_helper"
    ```

  * **Line # 3 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe PreorderReservationDate, type: :model do
    ```

### spec/models/preorder_reservation_group_spec.rb - (4 offenses)
  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe PreorderReservationGroup, type: :model do
    ```

  * **Line # 20 - convention:** RSpec/ExpectChange: Prefer `change(ReservationTurn, :count)`.

    ```rb
        it { expect { group.destroy! }.not_to(change { ReservationTurn.count }) }
    ```

  * **Line # 21 - convention:** RSpec/ExpectChange: Prefer `change(PreorderReservationDate, :count)`.

    ```rb
        it { expect { group.destroy! }.to(change { PreorderReservationDate.count }.by(-3)) }
    ```

  * **Line # 22 - convention:** RSpec/ExpectChange: Prefer `change(PreorderReservationGroupsToTurn, :count)`.

    ```rb
        it { expect { group.destroy! }.to(change { PreorderReservationGroupsToTurn.count }.by(-3)) }
    ```

### spec/models/preorder_reservation_groups_to_turn_spec.rb - (6 offenses)
  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe PreorderReservationGroupsToTurn, type: :model do
    ```

  * **Line # 17 - convention:** RSpec/ExpectChange: Prefer `change(described_class, :count)`.

    ```rb
        it { expect { group.turns = [turn] }.to change { described_class.count }.by(1) }
    ```

  * **Line # 22 - convention:** RSpec/ExpectChange: Prefer `change(ReservationTurn, :count)`.

    ```rb
          it { expect { group.destroy! }.not_to(change { ReservationTurn.count }) }
    ```

  * **Line # 23 - convention:** RSpec/ExpectChange: Prefer `change(described_class, :count)`.

    ```rb
          it { expect { group.destroy! }.to(change { described_class.count }.by(-1)) }
    ```

  * **Line # 25 - convention:** RSpec/ExpectChange: Prefer `change(described_class, :count)`.

    ```rb
          it { expect { group.turns = [] }.to(change { described_class.count }.by(-1)) }
    ```

  * **Line # 26 - convention:** RSpec/ExpectChange: Prefer `change(ReservationTurn, :count)`.

    ```rb
          it { expect { group.turns = [] }.not_to(change { ReservationTurn.count }) }
    ```

### spec/models/public_message_spec.rb - (2 offenses)
  * **Line # 1 - convention:** Style/FrozenStringLiteralComment: Missing frozen string literal comment.

    ```rb
    require "rails_helper"
    ```

  * **Line # 3 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe PublicMessage, type: :model do
    ```

### spec/models/refresh_token_spec.rb - (35 offenses)
  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe RefreshToken, type: :model do
    ```

  * **Line # 35 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
        let!(:refresh_token) { create(:refresh_token, :with_user) }
    ```

  * **Line # 37 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
        before { allow_any_instance_of(RefreshToken).to receive(:assign_defaults).and_return(true) }
    ```

  * **Line # 37 - convention:** RSpec/DescribedClass: Use `described_class` instead of `RefreshToken`.

    ```rb
        before { allow_any_instance_of(RefreshToken).to receive(:assign_defaults).and_return(true) }
    ```

  * **Line # 62 - convention:** RSpec/DescribedClass: Use `described_class` instead of `RefreshToken`.

    ```rb
            it { is_expected.to be_a(RefreshToken) }
    ```

  * **Line # 64 - convention:** RSpec/DescribedClass: Use `described_class` instead of `RefreshToken`.

    ```rb
            it { expect(refresh_token.expires_at).not_to eq RefreshToken.find(refresh_token.id).expires_at }
    ```

  * **Line # 65 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.changes).not_to be_empty }
    ```

  * **Line # 83 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
            it { expect(refresh_token.expired!).to eq true }
    ```

  * **Line # 103 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
            it { expect(refresh_token.expired!).to eq true }
    ```

  * **Line # 125 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
          it { expect(refresh_token.expired?).to eq false }
    ```

  * **Line # 126 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
          it { expect(refresh_token.not_expired?).to eq true }
    ```

  * **Line # 131 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
            it { expect(refresh_token.expired?).to eq true }
    ```

  * **Line # 138 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
              it { expect(refresh_token.expired?).to eq true }
    ```

  * **Line # 189 - convention:** RSpec/DescribedClass: Use `described_class` instead of `RefreshToken`.

    ```rb
                it { is_expected.to be_a(RefreshToken) }
    ```

  * **Line # 192 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                it { expect(subject.user.id).to eq user.id }
    ```

  * **Line # 222 - convention:** RSpec/DescribedClass: Use `described_class` instead of `RefreshToken`.

    ```rb
                it { is_expected.to be_a(RefreshToken) }
    ```

  * **Line # 225 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                it { expect(subject.user.id).to eq user.id }
    ```

  * **Line # 243 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
          let!(:expired_refresh_tokens) do
    ```

  * **Line # 249 - convention:** RSpec/DescribedClass: Use `described_class` instead of `RefreshToken`.

    ```rb
            RefreshToken.import! items, validate: false
    ```

  * **Line # 252 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
          let!(:not_expired_refresh_tokens) do
    ```

  * **Line # 258 - convention:** RSpec/DescribedClass: Use `described_class` instead of `RefreshToken`.

    ```rb
            RefreshToken.import! items, validate: false
    ```

  * **Line # 271 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.count).to eq count }
    ```

  * **Line # 272 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject).to all(be_a(RefreshToken)) }
    ```

  * **Line # 272 - convention:** RSpec/DescribedClass: Use `described_class` instead of `RefreshToken`.

    ```rb
              it { expect(subject).to all(be_a(RefreshToken)) }
    ```

  * **Line # 273 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject).to all(be_expired) }
    ```

  * **Line # 274 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.pluck(:id)).to match_array(RefreshToken.where("expires_at < NOW()").pluck(:id)) }
    ```

  * **Line # 274 - convention:** RSpec/DescribedClass: Use `described_class` instead of `RefreshToken`.

    ```rb
              it { expect(subject.pluck(:id)).to match_array(RefreshToken.where("expires_at < NOW()").pluck(:id)) }
    ```

  * **Line # 288 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.count).to eq count }
    ```

  * **Line # 289 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject).to all(be_a(RefreshToken)) }
    ```

  * **Line # 289 - convention:** RSpec/DescribedClass: Use `described_class` instead of `RefreshToken`.

    ```rb
              it { expect(subject).to all(be_a(RefreshToken)) }
    ```

  * **Line # 290 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject).to all(be_not_expired) }
    ```

  * **Line # 291 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.map(&:expired?)).to all(eq false) }
    ```

  * **Line # 291 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
              it { expect(subject.map(&:expired?)).to all(eq false) }
    ```

  * **Line # 292 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.pluck(:id)).to match_array(RefreshToken.where("expires_at > NOW()").pluck(:id)) }
    ```

  * **Line # 292 - convention:** RSpec/DescribedClass: Use `described_class` instead of `RefreshToken`.

    ```rb
              it { expect(subject.pluck(:id)).to match_array(RefreshToken.where("expires_at > NOW()").pluck(:id)) }
    ```

### spec/models/reservation_payment_spec.rb - (1 offense)
  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe ReservationPayment, type: :model do
    ```

### spec/models/reservation_spec.rb - (33 offenses)
  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe Reservation, type: :model do
    ```

  * **Line # 15 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            before { subject.valid? }
    ```

  * **Line # 18 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
    ```

  * **Line # 19 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.errors[:datetime]).not_to be_empty }
    ```

  * **Line # 31 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            before { subject.valid? }
    ```

  * **Line # 34 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
    ```

  * **Line # 35 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.errors[:fullname]).not_to be_empty }
    ```

  * **Line # 49 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            before { subject.valid? }
    ```

  * **Line # 52 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
    ```

  * **Line # 53 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.errors[:secret]).not_to be_empty }
    ```

  * **Line # 75 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            before { subject.valid? }
    ```

  * **Line # 78 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
    ```

  * **Line # 79 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.errors[:adults]).not_to be_empty }
    ```

  * **Line # 80 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.errors[:children]).not_to be_empty }
    ```

  * **Line # 104 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            before { subject.valid? }
    ```

  * **Line # 107 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
    ```

  * **Line # 108 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.errors[:status]).not_to be_empty }
    ```

  * **Line # 128 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject.reservation_tags = [create(:reservation_tag)] }.to change {
    ```

  * **Line # 129 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                                                                                    subject.reload.tags.count
    ```

  * **Line # 133 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject.destroy! }.to change { Reservation.count }.by(-1) }
    ```

  * **Line # 133 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { subject.destroy! }.to change { Reservation.count }.by(-1) }
    ```

  * **Line # 133 - convention:** RSpec/DescribedClass: Use `described_class` instead of `Reservation`.

    ```rb
            it { expect { subject.destroy! }.to change { Reservation.count }.by(-1) }
    ```

  * **Line # 134 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject.destroy! }.to change { TagInReservation.count }.by(-3) }
    ```

  * **Line # 134 - convention:** RSpec/ExpectChange: Prefer `change(TagInReservation, :count)`.

    ```rb
            it { expect { subject.destroy! }.to change { TagInReservation.count }.by(-3) }
    ```

  * **Line # 135 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject.destroy! }.not_to(change { ReservationTag.count }) }
    ```

  * **Line # 135 - convention:** RSpec/ExpectChange: Prefer `change(ReservationTag, :count)`.

    ```rb
            it { expect { subject.destroy! }.not_to(change { ReservationTag.count }) }
    ```

  * **Line # 137 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject.tags = [] }.not_to(change { Reservation.count }) }
    ```

  * **Line # 137 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { subject.tags = [] }.not_to(change { Reservation.count }) }
    ```

  * **Line # 137 - convention:** RSpec/DescribedClass: Use `described_class` instead of `Reservation`.

    ```rb
            it { expect { subject.tags = [] }.not_to(change { Reservation.count }) }
    ```

  * **Line # 138 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject.tags = [] }.not_to(change { ReservationTag.count }) }
    ```

  * **Line # 138 - convention:** RSpec/ExpectChange: Prefer `change(ReservationTag, :count)`.

    ```rb
            it { expect { subject.tags = [] }.not_to(change { ReservationTag.count }) }
    ```

  * **Line # 139 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject.tags = [] }.to change { TagInReservation.count }.by(-3) }
    ```

  * **Line # 139 - convention:** RSpec/ExpectChange: Prefer `change(TagInReservation, :count)`.

    ```rb
            it { expect { subject.tags = [] }.to change { TagInReservation.count }.by(-3) }
    ```

### spec/models/reservation_tag_spec.rb - (23 offenses)
  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe ReservationTag, type: :model do
    ```

  * **Line # 15 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            before { subject.valid? }
    ```

  * **Line # 18 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
    ```

  * **Line # 19 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.errors[:title]).not_to be_empty }
    ```

  * **Line # 27 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
          let!(:old) { create(:reservation_tag, title:) }
    ```

  * **Line # 33 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.errors[:title]).not_to be_empty }
    ```

  * **Line # 45 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            before { subject.valid? }
    ```

  * **Line # 48 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
    ```

  * **Line # 49 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.errors[:bg_color]).not_to be_empty }
    ```

  * **Line # 62 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            before { subject.valid? }
    ```

  * **Line # 65 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
    ```

  * **Line # 66 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.errors[:color]).not_to be_empty }
    ```

  * **Line # 78 - convention:** RSpec/ExpectChange: Prefer `change(ReservationTag, :count)`.

    ```rb
        it { expect { tag.reservations << reservations.sample }.not_to(change { ReservationTag.count }) }
    ```

  * **Line # 78 - convention:** RSpec/DescribedClass: Use `described_class` instead of `ReservationTag`.

    ```rb
        it { expect { tag.reservations << reservations.sample }.not_to(change { ReservationTag.count }) }
    ```

  * **Line # 79 - convention:** RSpec/ExpectChange: Prefer `change(TagInReservation, :count)`.

    ```rb
        it { expect { tag.reservations << reservations.sample }.to change { TagInReservation.count }.by(1) }
    ```

  * **Line # 85 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
          it { expect { tag.destroy! }.not_to(change { Reservation.count }) }
    ```

  * **Line # 86 - convention:** RSpec/ExpectChange: Prefer `change(ReservationTag, :count)`.

    ```rb
          it { expect { tag.destroy! }.to change { ReservationTag.count }.by(-1) }
    ```

  * **Line # 86 - convention:** RSpec/DescribedClass: Use `described_class` instead of `ReservationTag`.

    ```rb
          it { expect { tag.destroy! }.to change { ReservationTag.count }.by(-1) }
    ```

  * **Line # 87 - convention:** RSpec/ExpectChange: Prefer `change(TagInReservation, :count)`.

    ```rb
          it { expect { tag.destroy! }.to change { TagInReservation.count }.by(-3) }
    ```

  * **Line # 89 - convention:** RSpec/ExpectChange: Prefer `change(TagInReservation, :count)`.

    ```rb
          it { expect { tag.reservations.sample.destroy! }.to change { TagInReservation.count }.by(-1) }
    ```

  * **Line # 90 - convention:** RSpec/ExpectChange: Prefer `change(ReservationTag, :count)`.

    ```rb
          it { expect { tag.reservations.sample.destroy! }.not_to(change { ReservationTag.count }) }
    ```

  * **Line # 90 - convention:** RSpec/DescribedClass: Use `described_class` instead of `ReservationTag`.

    ```rb
          it { expect { tag.reservations.sample.destroy! }.not_to(change { ReservationTag.count }) }
    ```

  * **Line # 91 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
          it { expect { tag.reservations.sample.destroy! }.to change { Reservation.count }.by(-1) }
    ```

### spec/models/reservation_turn_spec.rb - (28 offenses)
  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe ReservationTurn, type: :model do
    ```

  * **Line # 8 - convention:** RSpec/ExpectChange: Prefer `change(ReservationTurn, :count)`.

    ```rb
        it { expect { create(:reservation_turn) }.to change { ReservationTurn.count }.by(1) }
    ```

  * **Line # 8 - convention:** RSpec/DescribedClass: Use `described_class` instead of `ReservationTurn`.

    ```rb
        it { expect { create(:reservation_turn) }.to change { ReservationTurn.count }.by(1) }
    ```

  * **Line # 22 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            before { subject.valid? }
    ```

  * **Line # 25 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
    ```

  * **Line # 26 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.errors[:starts_at]).not_to be_empty }
    ```

  * **Line # 38 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            before { subject.valid? }
    ```

  * **Line # 41 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
    ```

  * **Line # 42 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.errors[:ends_at]).not_to be_empty }
    ```

  * **Line # 49 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          before { subject.valid? }
    ```

  * **Line # 52 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
    ```

  * **Line # 53 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.errors[:starts_at]).not_to be_empty }
    ```

  * **Line # 54 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.errors[:ends_at]).not_to be_empty }
    ```

  * **Line # 66 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
    ```

  * **Line # 67 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.errors[:starts_at]).not_to be_empty }
    ```

  * **Line # 79 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
    ```

  * **Line # 80 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.errors[:starts_at]).not_to be_empty }
    ```

  * **Line # 92 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
    ```

  * **Line # 93 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.errors[:ends_at]).not_to be_empty }
    ```

  * **Line # 99 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
          let!(:turn) { create(:reservation_turn, starts_at: "10:00", ends_at: "11:00") }
    ```

  * **Line # 105 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject.save! }.not_to raise_error }
    ```

  * **Line # 117 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject.save! }.not_to raise_error }
    ```

  * **Line # 129 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject.save! }.not_to raise_error }
    ```

  * **Line # 144 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
    ```

  * **Line # 159 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
    ```

  * **Line # 165 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
        let!(:pranzo) do
    ```

  * **Line # 173 - convention:** RSpec/DescribedClass: Use `described_class` instead of `ReservationTurn`.

    ```rb
        it { expect(ReservationTurn.count).to eq 1 }
    ```

  * **Line # 175 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it do
    ```

### spec/models/reset_password_secret_spec.rb - (7 offenses)
  * **Line # 10 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
          allow_any_instance_of(described_class).to receive(:generate_secret).and_return(true)
    ```

  * **Line # 13 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
        it { expect(subject).not_to allow_value(nil).for(:secret) }
    ```

  * **Line # 14 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
        it { expect(subject).not_to allow_value("").for(:secret) }
    ```

  * **Line # 15 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
        it { expect(subject).not_to allow_value(nil).for(:user) }
    ```

  * **Line # 36 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
        it do
    ```

  * **Line # 68 - convention:** RSpec/ExpectChange: Prefer `change(described_class, :count)`.

    ```rb
        it { expect { described_class.delete_expired_secrets }.to change { described_class.count }.by(-1) }
    ```

  * **Line # 82 - convention:** RSpec/Rails/NegationBeValid: Use `expect(...).not_to be_valid`.

    ```rb
        it { expect(secret).to be_invalid }
    ```

### spec/models/setting/defaults_spec.rb - (10 offenses)
  * **Line # 12 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
        expect(subject.keys.uniq).to match_array(subject.keys)
    ```

  * **Line # 12 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
        expect(subject.keys.uniq).to match_array(subject.keys)
    ```

  * **Line # 15 - convention:** RSpec/ExampleLength: Example has too many lines. [7/5]

    ```rb
      it "alls be valid Setting" do ...
    ```

  * **Line # 15 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
      it "alls be valid Setting" do
    ```

  * **Line # 16 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
        subject.each do |key, setting_data|
    ```

  * **Line # 21 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
          expect(setting.save).to eq true
    ```

  * **Line # 26 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
        it "has a #{key} setting" do
    ```

  * **Line # 27 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject[key]).to be_a(Hash)
    ```

  * **Line # 28 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject[key.to_s]).to be_a(Hash)
    ```

  * **Line # 29 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject[key.to_sym]).to be_a(Hash)
    ```

### spec/models/setting_spec.rb - (18 offenses)
  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe Setting, type: :model do
    ```

  * **Line # 38 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
    ```

  * **Line # 40 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it "has errors on key" do
    ```

  * **Line # 41 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            subject.save
    ```

  * **Line # 42 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject).not_to be_persisted
    ```

  * **Line # 43 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.errors[:key]).not_to be_empty
    ```

  * **Line # 51 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
    ```

  * **Line # 58 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject.save! }.not_to raise_error }
    ```

  * **Line # 63 - convention:** RSpec/DescribedClass: Use `described_class` instead of `Setting`.

    ```rb
        subject { Setting }
    ```

  * **Line # 73 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
            it { expect(doit).to eq nil }
    ```

  * **Line # 89 - convention:** RSpec/DescribedClass: Use `described_class` instead of `Setting`.

    ```rb
            Setting.destroy_all
    ```

  * **Line # 90 - convention:** RSpec/DescribedClass: Use `described_class` instead of `Setting`.

    ```rb
            Setting.create(key: :default_language)
    ```

  * **Line # 101 - convention:** RSpec/DescribedClass: Use `described_class` instead of `Setting`.

    ```rb
            before { Setting.destroy_all }
    ```

  * **Line # 112 - convention:** RSpec/DescribedClass: Use `described_class` instead of `Setting`.

    ```rb
              Setting.destroy_all
    ```

  * **Line # 113 - convention:** RSpec/DescribedClass: Use `described_class` instead of `Setting`.

    ```rb
              Setting.create(key: :default_language, value: locale_but_not_the_default_one)
    ```

  * **Line # 124 - convention:** RSpec/DescribedClass: Use `described_class` instead of `Setting`.

    ```rb
            Setting.destroy_all
    ```

  * **Line # 132 - convention:** RSpec/ExpectChange: Prefer `change(described_class, :count)`.

    ```rb
          it { expect { doit }.to change { described_class.count }.by(Setting::DEFAULTS.count) }
    ```

  * **Line # 137 - convention:** RSpec/ExpectChange: Prefer `change(described_class, :count)`.

    ```rb
            expect { doit }.not_to(change { described_class.count })
    ```

### spec/models/user_spec.rb - (30 offenses)
  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe User, type: :model do
    ```

  * **Line # 14 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
          allow_any_instance_of(User).to receive(:assign_defaults).and_return(true)
    ```

  * **Line # 14 - convention:** RSpec/DescribedClass: Use `described_class` instead of `User`.

    ```rb
          allow_any_instance_of(User).to receive(:assign_defaults).and_return(true)
    ```

  * **Line # 50 - convention:** RSpec/ExpectChange: Prefer `change(ResetPasswordSecret, :count)`.

    ```rb
          it { expect { call }.to(change { ResetPasswordSecret.count }.by(1)) }
    ```

  * **Line # 77 - convention:** RSpec/DescribedClass: Use `described_class` instead of `User`.

    ```rb
            it { is_expected.to be_a(User) }
    ```

  * **Line # 79 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.changes).to be_empty }
    ```

  * **Line # 88 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.temporarily_blocked?).to be false }
    ```

  * **Line # 89 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject).not_to be_temporarily_blocked }
    ```

  * **Line # 96 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.temporarily_blocked?).to be false }
    ```

  * **Line # 97 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject).not_to be_temporarily_blocked }
    ```

  * **Line # 104 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.temporarily_blocked?).to be true }
    ```

  * **Line # 105 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject).to be_temporarily_blocked }
    ```

  * **Line # 109 - convention:** Rails/TimeZone: Do not use `Time.now` without zone. Use one of `Time.zone.now`, `Time.current`, `Time.now.in_time_zone`, `Time.now.utc`, `Time.now.getlocal`, `Time.now.xmlschema`, `Time.now.iso8601`, `Time.now.jisx0301`, `Time.now.rfc3339`, `Time.now.httpdate`, `Time.now.to_i`, `Time.now.to_f` instead.

    ```rb
            subject { build(:user, locked_at: Time.now) }
    ```

  * **Line # 112 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.temporarily_blocked?).to be true }
    ```

  * **Line # 113 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject).to be_temporarily_blocked }
    ```

  * **Line # 171 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:user) { refresh_token.user }
    ```

  * **Line # 185 - convention:** RSpec/DescribedClass: Use `described_class` instead of `User`.

    ```rb
          it { expect(User.root.pluck(:id)).not_to include(user.id) }
    ```

  * **Line # 191 - convention:** RSpec/DescribedClass: Use `described_class` instead of `User`.

    ```rb
            it { expect(User.root.pluck(:id)).to include(user.id) }
    ```

  * **Line # 201 - convention:** RSpec/DescribedClass: Use `described_class` instead of `User`.

    ```rb
                expect(User.root.pluck(:id)).not_to include(user.id)
    ```

  * **Line # 208 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
      it "is able to create a user with just { email }" do
    ```

  * **Line # 209 - convention:** RSpec/DescribedClass: Use `described_class` instead of `User`.

    ```rb
        user = User.new(email: Faker::Internet.email)
    ```

  * **Line # 222 - convention:** RSpec/DescribedClass: Use `described_class` instead of `User`.

    ```rb
          expect { doit }.to change(User, :count).by(2)
    ```

  * **Line # 245 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it "assign timezone value and check if assigned." do
    ```

  * **Line # 252 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it "reset timezone value and check if function returns default" do
    ```

  * **Line # 255 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
          expect(user.preference(:timezone).value).to eq nil
    ```

  * **Line # 264 - convention:** RSpec/NoExpectationExample: No expectation found in this example.

    ```rb
        it do ...
    ```

  * **Line # 268 - convention:** RSpec/NoExpectationExample: No expectation found in this example.

    ```rb
        it do ...
    ```

  * **Line # 274 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it do
    ```

  * **Line # 275 - convention:** RSpec/DescribedClass: Use `described_class` instead of `User`.

    ```rb
          user = User.new(email: generate(:user_email), password: "banana")
    ```

  * **Line # 277 - convention:** RSpec/DescribedClass: Use `described_class` instead of `User`.

    ```rb
          expect(User.find(user.id).authenticate("banana")).to be_truthy
    ```

### spec/rails_helper.rb - (5 offenses)
  * **Line # 1 - convention:** Style/FrozenStringLiteralComment: Missing frozen string literal comment.

    ```rb
    # This file is copied to spec/ when you run 'rails generate rspec:install'
    ```

  * **Line # 37 - warning:** Lint/RedundantDirGlobSort: Remove redundant `sort`.

    ```rb
    Dir[Rails.root.join("spec/support/**/*.rb")].sort.each { |f| require f }
    ```

  * **Line # 38 - warning:** Lint/RedundantDirGlobSort: Remove redundant `sort`.

    ```rb
    Dir[Rails.root.join("spec/contexts/**/*.rb")].sort.each { |f| require f }
    ```

  * **Line # 39 - warning:** Lint/RedundantDirGlobSort: Remove redundant `sort`.

    ```rb
    Dir[Rails.root.join("spec/shared_examples/**/*.rb")].sort.each { |f| require f }
    ```

  * **Line # 40 - warning:** Lint/RedundantDirGlobSort: Remove redundant `sort`.

    ```rb
    Dir[Rails.root.join("spec/matchers/**/*.rb")].sort.each { |f| require f }
    ```

### spec/requests/v1/admin/contacts_controller/contacts_controller.index_spec.rb - (2 offenses)
  * **Line # 11 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(p = params, h = headers)
    ```

  * **Line # 11 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(p = params, h = headers)
    ```

### spec/requests/v1/admin/contacts_controller/contacts_controller.show_spec.rb - (3 offenses)
  * **Line # 12 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(_k = key, p = params, h = headers)
    ```

  * **Line # 12 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(_k = key, p = params, h = headers)
    ```

  * **Line # 12 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(_k = key, p = params, h = headers)
    ```

### spec/requests/v1/admin/contacts_controller/contacts_controller.update_spec.rb - (9 offenses)
  * **Line # 13 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(_k = key, p = params, h = headers)
    ```

  * **Line # 13 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(_k = key, p = params, h = headers)
    ```

  * **Line # 13 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(_k = key, p = params, h = headers)
    ```

  * **Line # 78 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it do
    ```

  * **Line # 113 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it do
    ```

  * **Line # 131 - convention:** Layout/LineLength: Line is too long. [123/120]

    ```rb
          value: "https://www.tripadvisor.it/Restaurant_Review-g187870-d1735599-Reviews-La_Porta_D_Acqua-Venice_Veneto.html" },
    ```

  * **Line # 137 - convention:** Performance/CollectionLiteralInLoop: Avoid immutable Array literals in loops. It is better to extract it into a local variable or a constant.

    ```rb
            ws = [ ...
    ```

  * **Line # 202 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
        let!(:contact) { create(:contact, key: "email", value: email) }
    ```

  * **Line # 218 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
        it do
    ```

### spec/requests/v1/admin/holidays_controller/holidays_controller.create_spec.rb - (10 offenses)
  * **Line # 47 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
      it "saves translated message" do
    ```

  * **Line # 62 - convention:** RSpec/ExpectChange: Prefer `change(Holiday, :count)`.

    ```rb
        it { expect { req }.not_to(change { Holiday.count }) }
    ```

  * **Line # 94 - convention:** RSpec/ExampleLength: Example has too many lines. [8/5]

    ```rb
          it do ...
    ```

  * **Line # 107 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [143]

    ```rb
      context "when creating a weekly holiday" do ...
    ```

  * **Line # 130 - convention:** RSpec/ExampleLength: Example has too many lines. [8/5]

    ```rb
          it do ...
    ```

  * **Line # 143 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [107]

    ```rb
      context "when creating a weekly holiday" do ...
    ```

  * **Line # 166 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it do
    ```

  * **Line # 183 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it do
    ```

  * **Line # 191 - convention:** Layout/LineLength: Line is too long. [130/120]

    ```rb
      context "when to_timestamp, weekly_from and weekly_to are blank should return 422: it would be a 'forever holiday' situation" do
    ```

  * **Line # 203 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it do
    ```

### spec/requests/v1/admin/holidays_controller/holidays_controller.destroy_spec.rb - (2 offenses)
  * **Line # 25 - convention:** RSpec/ExpectChange: Prefer `change(Holiday, :count)`.

    ```rb
        it { expect { req }.not_to(change { Holiday.count }) }
    ```

  * **Line # 39 - convention:** RSpec/ExpectChange: Prefer `change(Holiday, :count)`.

    ```rb
      it { expect { req }.to change { Holiday.count }.by(-1) }
    ```

### spec/requests/v1/admin/holidays_controller/holidays_controller.index_spec.rb - (1 offense)
  * **Line # 115 - convention:** Layout/LineLength: Line is too long. [161/120]

    ```rb
          context "when filtering for 5 days from now with time #{time.inspect}: should not find anything. This because weekly holidays are for specific weekays." do
    ```

### spec/requests/v1/admin/holidays_controller/holidays_controller.update_spec.rb - (9 offenses)
  * **Line # 52 - convention:** RSpec/ExampleLength: Example has too many lines. [6/5]

    ```rb
      it "saves translated message in Italian" do ...
    ```

  * **Line # 52 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
      it "saves translated message in Italian" do
    ```

  * **Line # 61 - convention:** RSpec/ExampleLength: Example has too many lines. [6/5]

    ```rb
      it "saves translated message in English" do ...
    ```

  * **Line # 61 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
      it "saves translated message in English" do
    ```

  * **Line # 102 - convention:** RSpec/RepeatedExampleGroupBody: Repeated context block body on line(s) [119]

    ```rb
      context "when updating a period holiday by adding weekly_from, should get 422" do ...
    ```

  * **Line # 102 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [119]

    ```rb
      context "when updating a period holiday by adding weekly_from, should get 422" do ...
    ```

  * **Line # 119 - convention:** RSpec/RepeatedExampleGroupBody: Repeated context block body on line(s) [102]

    ```rb
      context "when updating a period holiday by adding weekly_from, should get 422" do ...
    ```

  * **Line # 119 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [102]

    ```rb
      context "when updating a period holiday by adding weekly_from, should get 422" do ...
    ```

  * **Line # 153 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
        it do
    ```

### spec/requests/v1/admin/menu/dishes_controller/menu_dishes_controller.update_prices_spec.rb - (4 offenses)
  * **Line # 54 - convention:** RSpec/ExampleLength: Example has too many lines. [6/5]

    ```rb
        it do ...
    ```

  * **Line # 83 - convention:** Layout/LineLength: Line is too long. [141/120]

    ```rb
                                                      { "id" => dishes.second.id, "price" => 3.51 }, { "id" => dishes.last.id, "price" => 5.00 })
    ```

  * **Line # 103 - convention:** RSpec/ExampleLength: Example has too many lines. [6/5]

    ```rb
          it do ...
    ```

  * **Line # 203 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it do
    ```

### spec/requests/v1/admin/menu/export_controller/menu_export_controller.export_spec.rb - (20 offenses)
  * **Line # 20 - convention:** Metrics/AbcSize: Assignment Branch Condition size for populate_database is too high. [<5, 40, 3> 40.42/17]

    ```rb
      def populate_database ...
    ```

  * **Line # 20 - convention:** Metrics/MethodLength: Method has too many lines. [20/10]

    ```rb
      def populate_database ...
    ```

  * **Line # 110 - convention:** Style/CombinableLoops: Combine this loop with the previous loop.

    ```rb
        %w[id name.it name.en description.it description.en status created_at updated_at].each do |col| ...
    ```

  * **Line # 116 - convention:** Style/CombinableLoops: Combine this loop with the previous loop.

    ```rb
        %w[id name.it name.en description.it description.en status created_at updated_at].each do |col| ...
    ```

  * **Line # 122 - convention:** Style/CombinableLoops: Combine this loop with the previous loop.

    ```rb
        %w[id name.it name.en description.it description.en status created_at updated_at].each do |col| ...
    ```

  * **Line # 131 - convention:** Layout/LineLength: Line is too long. [135/120]

    ```rb
                                                                                     *Menu::Allergen.where.not(status: :deleted).map(&:id))
    ```

  * **Line # 137 - convention:** Layout/LineLength: Line is too long. [139/120]

    ```rb
                                                                                       *Menu::Ingredient.where.not(status: :deleted).map(&:id))
    ```

  * **Line # 143 - convention:** Layout/LineLength: Line is too long. [125/120]

    ```rb
                                                                                *Menu::Tag.where.not(status: :deleted).map(&:id))
    ```

  * **Line # 149 - convention:** Layout/LineLength: Line is too long. [145/120]

    ```rb
                                                                                *Menu::Category.where.not(status: :deleted).without_parent.map(&:id))
    ```

  * **Line # 155 - convention:** Layout/LineLength: Line is too long. [134/120]

    ```rb
                                                         col))).to contain_exactly(col, *Menu::Dish.where.not(status: :deleted).map do |t|
    ```

  * **Line # 156 - convention:** Layout/LineLength: Line is too long. [124/120]

    ```rb
                                                                                          t.send(col).strftime("%Y-%m-%d %H:%M")
    ```

  * **Line # 162 - convention:** Layout/LineLength: Line is too long. [141/120]

    ```rb
                                                            col))).to contain_exactly(col, *Menu::Allergen.where.not(status: :deleted).map do |t|
    ```

  * **Line # 163 - convention:** Layout/LineLength: Line is too long. [127/120]

    ```rb
                                                                                             t.send(col).strftime("%Y-%m-%d %H:%M")
    ```

  * **Line # 169 - convention:** Layout/LineLength: Line is too long. [131/120]

    ```rb
                                                       col))).to contain_exactly(col, *Menu::Tag.where.not(status: :deleted).map do |t|
    ```

  * **Line # 170 - convention:** Layout/LineLength: Line is too long. [122/120]

    ```rb
                                                                                        t.send(col).strftime("%Y-%m-%d %H:%M")
    ```

  * **Line # 176 - convention:** Layout/LineLength: Line is too long. [158/120]

    ```rb
                                                       col))).to contain_exactly(col, *Menu::Category.where.not(status: :deleted).where(parent_id: nil).map do |t|
    ```

  * **Line # 177 - convention:** Layout/LineLength: Line is too long. [122/120]

    ```rb
                                                                                        t.send(col).strftime("%Y-%m-%d %H:%M")
    ```

  * **Line # 186 - convention:** Layout/LineLength: Line is too long. [130/120]

    ```rb
                                                                                    *Menu::Dish.where.not(status: :deleted).map(&:id))
    ```

  * **Line # 189 - convention:** RSpec/ExampleLength: Example has too many lines. [9/5]

    ```rb
          it do ...
    ```

  * **Line # 189 - convention:** RSpec/MultipleExpectations: Example has too many expectations [7/1].

    ```rb
          it do
    ```

### spec/requests/v1/admin/preferences_controller/preferences_controller.hash_spec.rb - (2 offenses)
  * **Line # 11 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(p = params, h = headers)
    ```

  * **Line # 11 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(p = params, h = headers)
    ```

### spec/requests/v1/admin/preferences_controller/preferences_controller.index_spec.rb - (2 offenses)
  * **Line # 11 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(p = params, h = headers)
    ```

  * **Line # 11 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(p = params, h = headers)
    ```

### spec/requests/v1/admin/preferences_controller/preferences_controller.show_spec.rb - (3 offenses)
  * **Line # 12 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(k = key, p = params, h = headers)
    ```

  * **Line # 12 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(k = key, p = params, h = headers)
    ```

  * **Line # 12 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(k = key, p = params, h = headers)
    ```

### spec/requests/v1/admin/preferences_controller/preferences_controller.update_spec.rb - (3 offenses)
  * **Line # 14 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(k = key, p = params, h = headers)
    ```

  * **Line # 14 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(k = key, p = params, h = headers)
    ```

  * **Line # 14 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(k = key, p = params, h = headers)
    ```

### spec/requests/v1/admin/preorder_reservation_groups/preorder_reservation_groups.create_spec.rb - (35 offenses)
  * **Line # 35 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(p = params, h = headers)
    ```

  * **Line # 35 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(p = params, h = headers)
    ```

  * **Line # 72 - convention:** RSpec/ExampleLength: Example has too many lines. [10/5]

    ```rb
          it do ...
    ```

  * **Line # 116 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [133]

    ```rb
        context "when trying to add same turn to a new group" do ...
    ```

  * **Line # 129 - convention:** RSpec/ExpectChange: Prefer `change(PreorderReservationGroup, :count)`.

    ```rb
          it { expect { req }.not_to(change { PreorderReservationGroup.count }) }
    ```

  * **Line # 130 - convention:** RSpec/ExpectChange: Prefer `change(PreorderReservationGroupsToTurn, :count)`.

    ```rb
          it { expect { req }.not_to(change { PreorderReservationGroupsToTurn.count }) }
    ```

  * **Line # 133 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [116]

    ```rb
        context "when trying to add same turn to a new group" do ...
    ```

  * **Line # 146 - convention:** RSpec/ExpectChange: Prefer `change(PreorderReservationGroup, :count)`.

    ```rb
          it { expect { req }.not_to(change { PreorderReservationGroup.count }) }
    ```

  * **Line # 147 - convention:** RSpec/ExpectChange: Prefer `change(PreorderReservationGroupsToTurn, :count)`.

    ```rb
          it { expect { req }.not_to(change { PreorderReservationGroupsToTurn.count }) }
    ```

  * **Line # 167 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [184]

    ```rb
        context "when trying to add same turn to a new group" do ...
    ```

  * **Line # 180 - convention:** RSpec/ExpectChange: Prefer `change(PreorderReservationGroup, :count)`.

    ```rb
          it { expect { req }.not_to(change { PreorderReservationGroup.count }) }
    ```

  * **Line # 181 - convention:** RSpec/ExpectChange: Prefer `change(PreorderReservationGroupsToTurn, :count)`.

    ```rb
          it { expect { req }.not_to(change { PreorderReservationGroupsToTurn.count }) }
    ```

  * **Line # 184 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [167]

    ```rb
        context "when trying to add same turn to a new group" do ...
    ```

  * **Line # 197 - convention:** RSpec/ExpectChange: Prefer `change(PreorderReservationGroup, :count)`.

    ```rb
          it { expect { req }.not_to(change { PreorderReservationGroup.count }) }
    ```

  * **Line # 198 - convention:** RSpec/ExpectChange: Prefer `change(PreorderReservationGroupsToTurn, :count)`.

    ```rb
          it { expect { req }.not_to(change { PreorderReservationGroupsToTurn.count }) }
    ```

  * **Line # 202 - convention:** Layout/LineLength: Line is too long. [142/120]

    ```rb
      context "when providing many dates for same turn - real-life scenario where on certain dates the reservations can be created only paying" do
    ```

  * **Line # 212 - convention:** RSpec/ExpectChange: Prefer `change(PreorderReservationGroup, :count)`.

    ```rb
        it { expect { req }.to(change { PreorderReservationGroup.count }.by(1)) }
    ```

  * **Line # 213 - convention:** RSpec/ExpectChange: Prefer `change(PreorderReservationDate, :count)`.

    ```rb
        it { expect { req }.to(change { PreorderReservationDate.count }.by(4)) }
    ```

  * **Line # 214 - convention:** RSpec/ExpectChange: Prefer `change(PreorderReservationGroupsToTurn, :count)`.

    ```rb
        it { expect { req }.not_to(change { PreorderReservationGroupsToTurn.count }) }
    ```

  * **Line # 226 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it do
    ```

  * **Line # 234 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
        let(:turn2) { create(:reservation_turn, weekday: 1) }
    ```

  * **Line # 235 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
        let(:turn3) { create(:reservation_turn, weekday: 2) }
    ```

  * **Line # 236 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
        let(:turn4) { create(:reservation_turn, weekday: 2) }
    ```

  * **Line # 251 - convention:** RSpec/ExpectChange: Prefer `change(PreorderReservationGroup, :count)`.

    ```rb
        it { expect { req }.to(change { PreorderReservationGroup.count }.by(1)) }
    ```

  * **Line # 252 - convention:** RSpec/ExpectChange: Prefer `change(PreorderReservationDate, :count)`.

    ```rb
        it { expect { req }.to(change { PreorderReservationDate.count }.by(5)) }
    ```

  * **Line # 253 - convention:** RSpec/ExpectChange: Prefer `change(PreorderReservationGroupsToTurn, :count)`.

    ```rb
        it { expect { req }.to(change { PreorderReservationGroupsToTurn.count }.by(1)) }
    ```

  * **Line # 265 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
        it do
    ```

  * **Line # 291 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [310]

    ```rb
        context "when adding some turn to the new group, should receive 422" do ...
    ```

  * **Line # 305 - convention:** RSpec/ExpectChange: Prefer `change(PreorderReservationGroup, :count)`.

    ```rb
          it { expect { req }.not_to(change { PreorderReservationGroup.count }) }
    ```

  * **Line # 306 - convention:** RSpec/ExpectChange: Prefer `change(PreorderReservationDate, :count)`.

    ```rb
          it { expect { req }.not_to(change { PreorderReservationDate.count }) }
    ```

  * **Line # 307 - convention:** RSpec/ExpectChange: Prefer `change(PreorderReservationGroupsToTurn, :count)`.

    ```rb
          it { expect { req }.not_to(change { PreorderReservationGroupsToTurn.count }) }
    ```

  * **Line # 310 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [291]

    ```rb
        context "when adding some turn to the new group, should receive 422" do ...
    ```

  * **Line # 326 - convention:** RSpec/ExpectChange: Prefer `change(PreorderReservationGroup, :count)`.

    ```rb
          it { expect { req }.not_to(change { PreorderReservationGroup.count }) }
    ```

  * **Line # 327 - convention:** RSpec/ExpectChange: Prefer `change(PreorderReservationDate, :count)`.

    ```rb
          it { expect { req }.not_to(change { PreorderReservationDate.count }) }
    ```

  * **Line # 328 - convention:** RSpec/ExpectChange: Prefer `change(PreorderReservationGroupsToTurn, :count)`.

    ```rb
          it { expect { req }.not_to(change { PreorderReservationGroupsToTurn.count }) }
    ```

### spec/requests/v1/admin/preorder_reservation_groups/preorder_reservation_groups.destroy_spec.rb - (2 offenses)
  * **Line # 23 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(id = group.id, p = params, h = headers)
    ```

  * **Line # 23 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(id = group.id, p = params, h = headers)
    ```

### spec/requests/v1/admin/preorder_reservation_groups/preorder_reservation_groups.index_spec.rb - (4 offenses)
  * **Line # 25 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(p = params, h = headers)
    ```

  * **Line # 25 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(p = params, h = headers)
    ```

  * **Line # 66 - convention:** Layout/LineLength: Line is too long. [124/120]

    ```rb
            expect(item[:turns]).to all(include(id: Integer, name: String, starts_at: String, ends_at: String, weekday: Integer,
    ```

  * **Line # 144 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
          let!(:all_inactive) do
    ```

### spec/requests/v1/admin/preorder_reservation_groups/preorder_reservation_groups.update_spec.rb - (12 offenses)
  * **Line # 45 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(id = group.id, p = params, h = headers)
    ```

  * **Line # 45 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(id = group.id, p = params, h = headers)
    ```

  * **Line # 74 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it do
    ```

  * **Line # 87 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it do
    ```

  * **Line # 89 - convention:** Style/SingleArgumentDig: Use `json[:item]` instead of `json.dig(:item)`.

    ```rb
          expect(json.dig(:item)).to include(:active_from)
    ```

  * **Line # 93 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it do
    ```

  * **Line # 117 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it do
    ```

  * **Line # 135 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it do
    ```

  * **Line # 153 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it do
    ```

  * **Line # 168 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it do
    ```

  * **Line # 188 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it do
    ```

  * **Line # 212 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

### spec/requests/v1/admin/public_messages_controller/public_messages_controller.create_spec.rb - (2 offenses)
  * **Line # 15 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(p = params, h = headers)
    ```

  * **Line # 15 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(p = params, h = headers)
    ```

### spec/requests/v1/admin/public_messages_controller/public_messages_controller.index_spec.rb - (2 offenses)
  * **Line # 11 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(p = params, h = headers)
    ```

  * **Line # 11 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(p = params, h = headers)
    ```

### spec/requests/v1/admin/public_messages_controller/public_messages_controller.show_spec.rb - (3 offenses)
  * **Line # 13 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(k = key, p = params, h = headers)
    ```

  * **Line # 13 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(k = key, p = params, h = headers)
    ```

  * **Line # 13 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(k = key, p = params, h = headers)
    ```

### spec/requests/v1/admin/public_messages_controller/public_messages_controller.update_spec.rb - (2 offenses)
  * **Line # 15 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(p = params, h = headers)
    ```

  * **Line # 15 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(p = params, h = headers)
    ```

### spec/requests/v1/admin/reservation_turn_messages_controller/admin_reservation_turn_messages_controller.create_spec.rb - (3 offenses)
  * **Line # 21 - convention:** RSpec/ExpectChange: Prefer `change(ReservationTurnMessage, :count)`.

    ```rb
      it { expect { req }.not_to(change { ReservationTurnMessage.count }) }
    ```

  * **Line # 35 - convention:** RSpec/ExpectChange: Prefer `change(ReservationTurnMessage, :count)`.

    ```rb
      it { expect { req }.to(change { ReservationTurnMessage.count }) }
    ```

  * **Line # 50 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
      let!(:reservation_turn) do
    ```

### spec/requests/v1/admin/reservation_turn_messages_controller/admin_reservation_turn_messages_controller.delete_spec.rb - (1 offense)
  * **Line # 35 - convention:** RSpec/ExpectChange: Prefer `change(ReservationTurnMessage, :count)`.

    ```rb
      it { expect { req }.to(change { ReservationTurnMessage.count }.by(-1)) }
    ```

### spec/requests/v1/admin/reservation_turn_messages_controller/admin_reservation_turn_messages_controller.index_spec.rb - (1 offense)
  * **Line # 44 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
      let!(:message) do
    ```

### spec/requests/v1/admin/reservation_turn_messages_controller/admin_reservation_turn_messages_controller.update_spec.rb - (1 offense)
  * **Line # 36 - convention:** RSpec/ExpectChange: Prefer `change(ReservationTurnMessage, :count)`.

    ```rb
      it { expect { req }.not_to(change { ReservationTurnMessage.count }) }
    ```

### spec/requests/v1/admin/reservations_controller/reservations_controller.refresh_payment_status_spec.rb - (15 offenses)
  * **Line # 62 - convention:** Layout/LineLength: Line is too long. [121/120]

    ```rb
                     "#{Config.app.dig!(:nexi_api_url)}/#{Config.app.dig!(:nexi_order_status_path)}").to_return do |_request|
    ```

  * **Line # 122 - convention:** RSpec/ExpectChange: Prefer `change(Nexi::HttpRequest, :count)`.

    ```rb
        it { expect { req }.to(change { Nexi::HttpRequest.count }.by(1)) }
    ```

  * **Line # 130 - convention:** RSpec/ExpectChange: Prefer `change(Nexi::HttpRequest, :count)`.

    ```rb
        it { expect { req }.not_to(change { Nexi::HttpRequest.count }) }
    ```

  * **Line # 139 - convention:** Performance/CollectionLiteralInLoop: Avoid immutable Array literals in loops. It is better to extract it into a local variable or a constant.

    ```rb
        %w[ ...
    ```

  * **Line # 143 - convention:** Layout/LineLength: Line is too long. [136/120]

    ```rb
          context "when payment has status '#{payment_initial_status}' but nexi api says it's okay: returns #{nexi_success_code.inspect}" do
    ```

  * **Line # 162 - convention:** RSpec/ExpectChange: Prefer `change(Nexi::HttpRequest, :count)`.

    ```rb
            it { expect { req }.to(change { Nexi::HttpRequest.count }.by(1)) }
    ```

  * **Line # 182 - convention:** Performance/CollectionLiteralInLoop: Avoid immutable Array literals in loops. It is better to extract it into a local variable or a constant.

    ```rb
        %w[ ...
    ```

  * **Line # 186 - convention:** Layout/LineLength: Line is too long. [143/120]

    ```rb
          context "when payment has status '#{payment_initial_status}' but nexi api says refound was made: returns #{nexi_success_code.inspect}" do
    ```

  * **Line # 210 - convention:** RSpec/ExpectChange: Prefer `change(Nexi::HttpRequest, :count)`.

    ```rb
            it { expect { req }.to(change { Nexi::HttpRequest.count }.by(1)) }
    ```

  * **Line # 229 - convention:** RSpec/ExpectChange: Prefer `change(Nexi::HttpRequest, :count)`.

    ```rb
        it { expect { req }.to(change { Nexi::HttpRequest.count }.by(1)) }
    ```

  * **Line # 237 - convention:** RSpec/ExpectChange: Prefer `change(Nexi::HttpRequest, :count)`.

    ```rb
        it { expect { req }.to(change { Nexi::HttpRequest.count }.by(1)) }
    ```

  * **Line # 241 - convention:** Layout/LineLength: Line is too long. [128/120]

    ```rb
      context "when nexi apis return partially-valid response: value of 'report' is an array that does not include same order id" do
    ```

  * **Line # 257 - convention:** RSpec/ExpectChange: Prefer `change(Nexi::HttpRequest, :count)`.

    ```rb
        it { expect { req }.to(change { Nexi::HttpRequest.count }.by(1)) }
    ```

  * **Line # 280 - convention:** RSpec/ExpectChange: Prefer `change(Nexi::HttpRequest, :count)`.

    ```rb
            it { expect { req }.to(change { Nexi::HttpRequest.count }.by(1)) }
    ```

  * **Line # 292 - convention:** RSpec/ExpectChange: Prefer `change(Nexi::HttpRequest, :count)`.

    ```rb
          it { expect { req }.to(change { Nexi::HttpRequest.count }.by(1)) }
    ```

### spec/requests/v1/admin/reservations_controller/reservations_controller.refund_payment_spec.rb - (6 offenses)
  * **Line # 53 - convention:** Layout/LineLength: Line is too long. [123/120]

    ```rb
                     "#{Config.app.dig!(:nexi_api_url)}/#{Config.app.dig!(:nexi_refund_payment_path)}").to_return do |_request|
    ```

  * **Line # 113 - convention:** RSpec/ExpectChange: Prefer `change(Nexi::HttpRequest, :count)`.

    ```rb
        it { expect { req }.to(change { Nexi::HttpRequest.count }.by(1)) }
    ```

  * **Line # 124 - convention:** RSpec/ExpectChange: Prefer `change(Nexi::HttpRequest, :count)`.

    ```rb
        it { expect { req }.not_to(change { Nexi::HttpRequest.count }) }
    ```

  * **Line # 132 - convention:** RSpec/ExpectChange: Prefer `change(Nexi::HttpRequest, :count)`.

    ```rb
        it { expect { req }.not_to(change { Nexi::HttpRequest.count }) }
    ```

  * **Line # 140 - convention:** RSpec/ExpectChange: Prefer `change(Nexi::HttpRequest, :count)`.

    ```rb
        it { expect { req }.to(change { Nexi::HttpRequest.count }.by(1)) }
    ```

  * **Line # 148 - convention:** RSpec/ExpectChange: Prefer `change(Nexi::HttpRequest, :count)`.

    ```rb
        it { expect { req }.to(change { Nexi::HttpRequest.count }.by(1)) }
    ```

### spec/requests/v1/admin/settings_controller/settings_controller.hash_spec.rb - (2 offenses)
  * **Line # 11 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(p = params, h = headers)
    ```

  * **Line # 11 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(p = params, h = headers)
    ```

### spec/requests/v1/admin/settings_controller/settings_controller.index_spec.rb - (2 offenses)
  * **Line # 11 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(p = params, h = headers)
    ```

  * **Line # 11 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(p = params, h = headers)
    ```

### spec/requests/v1/admin/settings_controller/settings_controller.show_spec.rb - (3 offenses)
  * **Line # 12 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(k = key, p = params, h = headers)
    ```

  * **Line # 12 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(k = key, p = params, h = headers)
    ```

  * **Line # 12 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(k = key, p = params, h = headers)
    ```

### spec/requests/v1/admin/settings_controller/settings_controller.update_spec.rb - (3 offenses)
  * **Line # 15 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(k = key, p = params, h = headers)
    ```

  * **Line # 15 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(k = key, p = params, h = headers)
    ```

  * **Line # 15 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(k = key, p = params, h = headers)
    ```

### spec/requests/v1/admin/stats_controller/stats_controller.index_spec.rb - (10 offenses)
  * **Line # 8 - warning:** Lint/ConstantDefinitionInBlock: Do not define constants this way within a block.

    ```rb
      ALL_KEYS = %w[reservations-by-hour].freeze
    ```

  * **Line # 8 - convention:** RSpec/LeakyConstantDeclaration: Stub constant instead of declaring explicitly.

    ```rb
      ALL_KEYS = %w[reservations-by-hour].freeze
    ```

  * **Line # 14 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(p = params, h = headers)
    ```

  * **Line # 14 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(p = params, h = headers)
    ```

  * **Line # 82 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
          let(:res1) { create(:reservation, adults: 1, datetime:) }
    ```

  * **Line # 83 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
          let(:res2) { create(:reservation, adults: 1, datetime:) }
    ```

  * **Line # 100 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
          let(:datetime1) { DateTime.parse("2021-01-01 10:00:00") }
    ```

  * **Line # 101 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
          let(:datetime2) { DateTime.parse("2021-01-01 11:00:00") }
    ```

  * **Line # 102 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
          let(:res1) { create(:reservation, adults: 1, datetime: datetime1) }
    ```

  * **Line # 103 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
          let(:res2) { create(:reservation, adults: 1, datetime: datetime2) }
    ```

### spec/requests/v1/admin/users_controller/users_controller.index_spec.rb - (4 offenses)
  * **Line # 60 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it "returns the user with the email" do
    ```

  * **Line # 70 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it "returns the user with the fullname" do
    ```

  * **Line # 90 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it "returns the user with the id" do
    ```

  * **Line # 99 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it "returns the user with the id" do
    ```

### spec/requests/v1/admin/users_controller/users_controller.show_spec.rb - (6 offenses)
  * **Line # 27 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to include(item: Hash)
    ```

  * **Line # 30 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
        it do
    ```

  * **Line # 31 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject[:item]).to include(id: Integer, email: String)
    ```

  * **Line # 32 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject[:item]).not_to include(:password)
    ```

  * **Line # 33 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject[:item]).not_to include(:password_digest)
    ```

  * **Line # 34 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject[:item]).not_to include(:enc_otp_key)
    ```

### spec/requests/v1/auth_controller/auth_controller.login_spec.rb - (12 offenses)
  * **Line # 22 - convention:** RSpec/ExpectChange: Prefer `change(RefreshToken, :count)`.

    ```rb
          expect { req }.to(change { RefreshToken.count }.by(1))
    ```

  * **Line # 42 - convention:** RSpec/ExpectChange: Prefer `change(RefreshToken, :count)`.

    ```rb
          expect { req }.to(change { RefreshToken.count }.by(1))
    ```

  * **Line # 62 - convention:** RSpec/ExpectChange: Prefer `change(RefreshToken, :count)`.

    ```rb
          expect { req }.to(change { RefreshToken.count }.by(1))
    ```

  * **Line # 82 - convention:** RSpec/ExpectChange: Prefer `change(RefreshToken, :count)`.

    ```rb
          expect { req }.to(change { RefreshToken.count }.by(1))
    ```

  * **Line # 107 - convention:** RSpec/ExpectChange: Prefer `change(RefreshToken, :count)`.

    ```rb
          expect { req }.to(change { RefreshToken.count }.by(1))
    ```

  * **Line # 140 - convention:** RSpec/ExpectChange: Prefer `change(RefreshToken, :count)`.

    ```rb
          expect { req }.not_to(change { RefreshToken.count })
    ```

  * **Line # 148 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it do
    ```

  * **Line # 161 - convention:** RSpec/ExpectChange: Prefer `change(RefreshToken, :count)`.

    ```rb
          expect { req }.not_to(change { RefreshToken.count })
    ```

  * **Line # 169 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it do
    ```

  * **Line # 184 - convention:** RSpec/ExpectInHook: Do not use `expect` in `before` hook

    ```rb
          expect(response).to have_http_status(:unauthorized)
    ```

  * **Line # 220 - convention:** RSpec/ExpectInHook: Do not use `expect` in `before` hook

    ```rb
            expect(response).to have_http_status(:unauthorized)
    ```

  * **Line # 274 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it do
    ```

### spec/requests/v1/auth_controller/auth_controller.refresh_token_spec.rb - (1 offense)
  * **Line # 82 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it do
    ```

### spec/requests/v1/auth_controller/auth_controller.reset_password_spec.rb - (6 offenses)
  * **Line # 57 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it do
    ```

  * **Line # 58 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
          expect(current_user.reload.authenticate(password)).to eq false
    ```

  * **Line # 63 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it do
    ```

  * **Line # 94 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it do
    ```

  * **Line # 95 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
          expect(current_user.reload.authenticate(password)).to eq false
    ```

  * **Line # 100 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it do
    ```

### spec/requests/v1/auth_controller/auth_controller.root_spec.rb - (2 offenses)
  * **Line # 51 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it "after some time, won't be root anymore." do
    ```

  * **Line # 85 - convention:** Layout/LineLength: Line is too long. [121/120]

    ```rb
                          :password)).to be_present.and(be_a(Array)).and(include(I18n.t("errors.messages.invalid_password")))
    ```

### spec/requests/v1/nexi_controller/nexi_controller.receive_order_outcome_spec.rb - (14 offenses)
  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.context "POST /v1/nexi/receive_order_outcome", type: :request do
    ```

  * **Line # 42 - convention:** RSpec/VariableName: Use snake_case for variable names.

    ```rb
      let(:codiceEsito) { "0" }
    ```

  * **Line # 47 - convention:** RSpec/VariableName: Use snake_case for variable names.

    ```rb
      let(:codAut) { "AB" }
    ```

  * **Line # 55 - convention:** RSpec/VariableName: Use snake_case for variable names.

    ```rb
      let(:codTrans) { payment.external_id }
    ```

  * **Line # 76 - convention:** RSpec/VariableName: Use snake_case for variable names.

    ```rb
      let(:languageId) { "ITA" }
    ```

  * **Line # 79 - convention:** RSpec/VariableName: Use snake_case for variable names.

    ```rb
      let(:tipoTransazione) { "3DS_FULL" }
    ```

  * **Line # 94 - convention:** RSpec/ExpectChange: Prefer `change(Nexi::OrderOutcomeRequest, :count)`.

    ```rb
      it { expect { req }.to(change { Nexi::OrderOutcomeRequest.count }.by(1)) }
    ```

  * **Line # 95 - convention:** RSpec/ExpectChange: Prefer `change(Log::ReservationEvent, :count)`.

    ```rb
      it { expect { req }.to(change { Log::ReservationEvent.count }.by(1)) }
    ```

  * **Line # 99 - convention:** RSpec/ExpectChange: Prefer `change(Log::DeliveredEmail, :count)`.

    ```rb
        it { expect { req }.to change { Log::DeliveredEmail.count }.by(1) }
    ```

  * **Line # 101 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it do
    ```

  * **Line # 108 - convention:** RSpec/ExampleLength: Example has too many lines. [7/5]

    ```rb
        it do ...
    ```

  * **Line # 108 - convention:** RSpec/MultipleExpectations: Example has too many expectations [5/1].

    ```rb
        it do
    ```

  * **Line # 149 - convention:** RSpec/ExpectChange: Prefer `change(Nexi::OrderOutcomeRequest, :count)`.

    ```rb
          it { expect { req }.to(change { Nexi::OrderOutcomeRequest.count }.by(1)) }
    ```

  * **Line # 169 - convention:** RSpec/ExpectChange: Prefer `change(Nexi::OrderOutcomeRequest, :count)`.

    ```rb
        it { expect { req }.to(change { Nexi::OrderOutcomeRequest.count }.by(1)) }
    ```

### spec/requests/v1/profile_controller/profile_controller.destroy_spec.rb - (1 offense)
  * **Line # 29 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it do
    ```

### spec/requests/v1/profile_controller/profile_controller.update_password_spec.rb - (3 offenses)
  * **Line # 63 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it do
    ```

  * **Line # 73 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
        it do
    ```

  * **Line # 77 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
          expect(current_user.reload.authenticate(current_password)).to eq(false)
    ```

### spec/requests/v1/reservations_controller/do_payment_spec.rb - (3 offenses)
  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.context "GET /v1/reservations/:secret/do_payment", type: :request do
    ```

  * **Line # 22 - convention:** RSpec/ExpectChange: Prefer `change(Log::ReservationEvent, :count)`.

    ```rb
        it { expect { req }.to change { Log::ReservationEvent.count }.from(0).to(1) }
    ```

  * **Line # 31 - convention:** RSpec/ExampleLength: Example has too many lines. [6/5]

    ```rb
        it do ...
    ```

### spec/requests/v1/reservations_controller/resend_confirmation_email_spec.rb - (1 offense)
  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.context "POST /v1/reservations/:secret/resend_confirmation_email", type: :request do
    ```

### spec/requests/v1/reservations_controller/valid_dates_spec.rb - (1 offense)
  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.context "GET /v1/reservations/valid_dates", type: :request do
    ```

### spec/requests/v1/reservations_controller/valid_times_spec.rb - (9 offenses)
  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.context "GET /v1/reservations/valid_times", type: :request do
    ```

  * **Line # 35 - convention:** Layout/LineLength: Line is too long. [133/120]

    ```rb
        context "when got holidays on all weekdays but they are expired (to_timestamp is in the past): should see all times available" do
    ```

  * **Line # 252 - convention:** Rails/TimeZone: Do not use `Time.now` without zone. Use one of `Time.zone.now`, `Time.current`, `Time.now.in_time_zone`, `Time.now.utc`, `Time.now.getlocal`, `Time.now.xmlschema`, `Time.now.iso8601`, `Time.now.jisx0301`, `Time.now.rfc3339`, `Time.now.httpdate`, `Time.now.to_i`, `Time.now.to_f` instead.

    ```rb
          create(:reservation_turn, starts_at: "12:00", ends_at: "15:00", weekday: Time.now.wday)
    ```

  * **Line # 270 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
        it do
    ```

  * **Line # 290 - convention:** Rails/TimeZone: Do not use `Time.now` without zone. Use one of `Time.zone.now`, `Time.current`, `Time.now.in_time_zone`, `Time.now.utc`, `Time.now.getlocal`, `Time.now.xmlschema`, `Time.now.iso8601`, `Time.now.jisx0301`, `Time.now.rfc3339`, `Time.now.httpdate`, `Time.now.to_i`, `Time.now.to_f` instead.

    ```rb
            ReservationTurn.create!(name: "Day", weekday: Time.now.wday, starts_at: "12:00", ends_at: "14:00", step: 30)
    ```

  * **Line # 293 - convention:** Rails/TimeZone: Do not use `Time.now` without zone. Use one of `Time.zone.now`, `Time.current`, `Time.now.in_time_zone`, `Time.now.utc`, `Time.now.getlocal`, `Time.now.xmlschema`, `Time.now.iso8601`, `Time.now.jisx0301`, `Time.now.rfc3339`, `Time.now.httpdate`, `Time.now.to_i`, `Time.now.to_f` instead.

    ```rb
          ReservationTurn.create!(name: "Night", weekday: Time.now.wday, starts_at: "19:00", ends_at: "21:00", step: 30)
    ```

  * **Line # 303 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
        it do
    ```

  * **Line # 323 - convention:** Rails/TimeZone: Do not use `Time.now` without zone. Use one of `Time.zone.now`, `Time.current`, `Time.now.in_time_zone`, `Time.now.utc`, `Time.now.getlocal`, `Time.now.xmlschema`, `Time.now.iso8601`, `Time.now.jisx0301`, `Time.now.rfc3339`, `Time.now.httpdate`, `Time.now.to_i`, `Time.now.to_f` instead.

    ```rb
            ReservationTurn.create!(name: "Day", weekday: Time.now.wday, starts_at: "12:00", ends_at: "14:00", step: 30)
    ```

  * **Line # 326 - convention:** Rails/TimeZone: Do not use `Time.now` without zone. Use one of `Time.zone.now`, `Time.current`, `Time.now.in_time_zone`, `Time.now.utc`, `Time.now.getlocal`, `Time.now.xmlschema`, `Time.now.iso8601`, `Time.now.jisx0301`, `Time.now.rfc3339`, `Time.now.httpdate`, `Time.now.to_i`, `Time.now.to_f` instead.

    ```rb
          ReservationTurn.create!(name: "Night", weekday: Time.now.wday, starts_at: "19:00", ends_at: "21:00", step: 30)
    ```

### spec/requests/v2/reservations_controller/valid_times_spec.rb - (13 offenses)
  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.context "GET /v2/reservations/valid_times", type: :request do
    ```

  * **Line # 38 - convention:** Layout/LineLength: Line is too long. [133/120]

    ```rb
        context "when got holidays on all weekdays but they are expired (to_timestamp is in the past): should see all times available" do
    ```

  * **Line # 178 - convention:** Layout/LineLength: Line is too long. [124/120]

    ```rb
          expect(json[:turns]).to all(include("id" => Integer, "starts_at" => String, "ends_at" => String, "weekday" => Integer,
    ```

  * **Line # 204 - convention:** Layout/LineLength: Line is too long. [124/120]

    ```rb
          expect(json[:turns]).to all(include("id" => Integer, "starts_at" => String, "ends_at" => String, "weekday" => Integer,
    ```

  * **Line # 287 - convention:** Rails/TimeZone: Do not use `Time.now` without zone. Use one of `Time.zone.now`, `Time.current`, `Time.now.in_time_zone`, `Time.now.utc`, `Time.now.getlocal`, `Time.now.xmlschema`, `Time.now.iso8601`, `Time.now.jisx0301`, `Time.now.rfc3339`, `Time.now.httpdate`, `Time.now.to_i`, `Time.now.to_f` instead.

    ```rb
          create(:reservation_turn, starts_at: "12:00", ends_at: "15:00", weekday: Time.now.wday)
    ```

  * **Line # 305 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
        it do
    ```

  * **Line # 325 - convention:** Rails/TimeZone: Do not use `Time.now` without zone. Use one of `Time.zone.now`, `Time.current`, `Time.now.in_time_zone`, `Time.now.utc`, `Time.now.getlocal`, `Time.now.xmlschema`, `Time.now.iso8601`, `Time.now.jisx0301`, `Time.now.rfc3339`, `Time.now.httpdate`, `Time.now.to_i`, `Time.now.to_f` instead.

    ```rb
            ReservationTurn.create!(name: "Day", weekday: Time.now.wday, starts_at: "12:00", ends_at: "14:00", step: 30)
    ```

  * **Line # 328 - convention:** Rails/TimeZone: Do not use `Time.now` without zone. Use one of `Time.zone.now`, `Time.current`, `Time.now.in_time_zone`, `Time.now.utc`, `Time.now.getlocal`, `Time.now.xmlschema`, `Time.now.iso8601`, `Time.now.jisx0301`, `Time.now.rfc3339`, `Time.now.httpdate`, `Time.now.to_i`, `Time.now.to_f` instead.

    ```rb
          ReservationTurn.create!(name: "Night", weekday: Time.now.wday, starts_at: "19:00", ends_at: "21:00", step: 30)
    ```

  * **Line # 338 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
        it do
    ```

  * **Line # 358 - convention:** Rails/TimeZone: Do not use `Time.now` without zone. Use one of `Time.zone.now`, `Time.current`, `Time.now.in_time_zone`, `Time.now.utc`, `Time.now.getlocal`, `Time.now.xmlschema`, `Time.now.iso8601`, `Time.now.jisx0301`, `Time.now.rfc3339`, `Time.now.httpdate`, `Time.now.to_i`, `Time.now.to_f` instead.

    ```rb
            ReservationTurn.create!(name: "Day", weekday: Time.now.wday, starts_at: "12:00", ends_at: "14:00", step: 30)
    ```

  * **Line # 361 - convention:** Rails/TimeZone: Do not use `Time.now` without zone. Use one of `Time.zone.now`, `Time.current`, `Time.now.in_time_zone`, `Time.now.utc`, `Time.now.getlocal`, `Time.now.xmlschema`, `Time.now.iso8601`, `Time.now.jisx0301`, `Time.now.rfc3339`, `Time.now.httpdate`, `Time.now.to_i`, `Time.now.to_f` instead.

    ```rb
          ReservationTurn.create!(name: "Night", weekday: Time.now.wday, starts_at: "19:00", ends_at: "21:00", step: 30)
    ```

  * **Line # 542 - convention:** RSpec/RepeatedExample: Don't repeat examples within an example group.

    ```rb
        it { expect(json.dig(:turns, 0, :messages)).to all(include(message: String)) }
    ```

  * **Line # 543 - convention:** RSpec/RepeatedExample: Don't repeat examples within an example group.

    ```rb
        it { expect(json.dig(:turns, 0, :messages)).to all(include(message: String)) }
    ```

### spec/routing/v1/admin/menu/categories_routing_spec.rb - (5 offenses)
  * **Line # 35 - convention:** Layout/LineLength: Line is too long. [126/120]

    ```rb
                                                                                                          id: "22", to_index: "1")
    ```

  * **Line # 40 - convention:** Layout/LineLength: Line is too long. [126/120]

    ```rb
                                                                                                          id: "22", to_index: "0")
    ```

  * **Line # 49 - convention:** Layout/LineLength: Line is too long. [122/120]

    ```rb
        expect(post: "/v1/admin/menu/categories/22/dishes/98").to route_to("v1/admin/menu/categories#add_dish", format: :json,
    ```

  * **Line # 50 - convention:** Layout/LineLength: Line is too long. [132/120]

    ```rb
                                                                                                                id: "22", dish_id: "98")
    ```

  * **Line # 60 - convention:** Layout/LineLength: Line is too long. [126/120]

    ```rb
                                                                                 format: :json, id: "22", category_child_id: "98")
    ```

### spec/routing/v1/admin/menu/dishes_routing_spec.rb - (9 offenses)
  * **Line # 53 - convention:** Layout/LineLength: Line is too long. [132/120]

    ```rb
                                                                                     format: :json, id: "52", status: "some-new-status")
    ```

  * **Line # 63 - convention:** Layout/LineLength: Line is too long. [123/120]

    ```rb
                                                                                  format: :json, id: "52", ingredient_id: "71")
    ```

  * **Line # 72 - convention:** Layout/LineLength: Line is too long. [121/120]

    ```rb
        expect(post: "/v1/admin/menu/dishes/52/tags/71").to route_to("v1/admin/menu/dishes#add_tag", format: :json, id: "52",
    ```

  * **Line # 78 - convention:** Layout/LineLength: Line is too long. [127/120]

    ```rb
                                                                                                            id: "52", tag_id: "71")
    ```

  * **Line # 83 - convention:** Layout/LineLength: Line is too long. [125/120]

    ```rb
                                                                                                          id: "52", tag_id: "71")
    ```

  * **Line # 87 - convention:** Layout/LineLength: Line is too long. [121/120]

    ```rb
        expect(post: "/v1/admin/menu/dishes/52/allergens/71").to route_to("v1/admin/menu/dishes#add_allergen", format: :json,
    ```

  * **Line # 88 - convention:** Layout/LineLength: Line is too long. [135/120]

    ```rb
                                                                                                               id: "52", allergen_id: "71")
    ```

  * **Line # 103 - convention:** Layout/LineLength: Line is too long. [126/120]

    ```rb
                                                                                                         id: "52", image_id: "71")
    ```

  * **Line # 108 - convention:** Layout/LineLength: Line is too long. [131/120]

    ```rb
                                                                                                              id: "52", image_id: "71")
    ```

### spec/routing/v1/admin/reservations_routing_spec.rb - (3 offenses)
  * **Line # 15 - convention:** Layout/LineLength: Line is too long. [125/120]

    ```rb
                                                                                                                   format: :json)
    ```

  * **Line # 26 - convention:** Layout/LineLength: Line is too long. [122/120]

    ```rb
                                                                                format: :json, id: "33", status: "new-status")
    ```

  * **Line # 31 - convention:** Layout/LineLength: Line is too long. [124/120]

    ```rb
                                                                                                         id: "33", tag_id: "29")
    ```

### spec/routing/v1/nexi_routing_spec.rb - (1 offense)
  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe "POST /v1/nexi/receive_order_outcome", type: :routing do
    ```

### spec/shared_examples/admin_menu_category.rb - (1 offense)
  * **Line # 9 - convention:** RSpec/ExampleLength: Example has too many lines. [9/5]

    ```rb
      it { ...
    ```

### spec/shared_examples/has_image_helper.rb - (1 offense)
  * **Line # 138 - convention:** RSpec/ExpectChange: Prefer `change(ImageToRecord, :count)`.

    ```rb
          expect { subject.image = image }.to change { ImageToRecord.count }.by(1)
    ```

### spec/shared_examples/menu_category_structure.rb - (1 offense)
  * **Line # 9 - convention:** RSpec/ExampleLength: Example has too many lines. [8/5]

    ```rb
      it do ...
    ```

### spec/shared_examples/model_mobility_examples.rb - (11 offenses)
  * **Line # 12 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
      it "checking mock data: should be a existing instance" do
    ```

  * **Line # 19 - convention:** RSpec/ExampleLength: Example has too many lines. [11/5]

    ```rb
      it "can be translated" do ...
    ```

  * **Line # 19 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
      it "can be translated" do
    ```

  * **Line # 27 - warning:** Lint/NonLocalExitFromIterator: Non-local exit from iterator, without return value. `next`, `break`, `Array#find`, `Array#any?`, etc. is preferred.

    ```rb
        return if i18n.nil?
    ```

  * **Line # 30 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
          expect(subject.send(args[:field])).to eq nil
    ```

  * **Line # 31 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
          expect(subject.send(:"#{args[:field]}_backend").read(i18n)).to eq nil
    ```

  * **Line # 35 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
      it "has locale_accessors for #{args[:field]}" do
    ```

  * **Line # 42 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
      it "has attribute_methods for #{args[:field]}" do
    ```

  * **Line # 48 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
      it "can find elements with exact match for #{args[:field]}" do
    ```

  * **Line # 56 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
      pending "can find elements with ilike match for #{args[:field]}" do
    ```

  * **Line # 56 - convention:** RSpec/PendingWithoutReason: Give the reason for pending.

    ```rb
      pending "can find elements with ilike match for #{args[:field]}" do
    ```

### spec/shared_examples/test_model_change_inclusion.rb - (9 offenses)
  * **Line # 21 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
        it do
    ```

  * **Line # 29 - convention:** RSpec/EmptyExampleGroup: Empty example group detected.

    ```rb
      context "on update" do
    ```

  * **Line # 29 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [41]

    ```rb
      context "on update" do ...
    ```

  * **Line # 34 - convention:** Rails/SkipsModelValidations: Avoid using `touch` because it skips validations.

    ```rb
            record.touch
    ```

  * **Line # 37 - convention:** RSpec/ExpectInHook: Do not use `expect` in `before` hook

    ```rb
          it { expect(SaveModelChangeJob).to have_received(:perform_async) }
    ```

  * **Line # 41 - convention:** RSpec/EmptyExampleGroup: Empty example group detected.

    ```rb
      context "on update" do
    ```

  * **Line # 41 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [29]

    ```rb
      context "on update" do ...
    ```

  * **Line # 46 - convention:** Rails/SkipsModelValidations: Avoid using `touch` because it skips validations.

    ```rb
            record.touch
    ```

  * **Line # 50 - convention:** RSpec/ExpectInHook: Do not use `expect` in `before` hook

    ```rb
          it { expect(SaveModelChangeJob).to have_received(:perform_async).exactly(3).times }
    ```

### spec/spec_helper.rb - (1 offense)
  * **Line # 1 - convention:** Style/FrozenStringLiteralComment: Missing frozen string literal comment.

    ```rb
    # This file was generated by the `rails generate rspec:install` command. Conventionally, all
    ```

