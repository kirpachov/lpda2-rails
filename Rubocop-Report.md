# RuboCop Inspection Report

545 files inspected, 4715 offenses detected:

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

### app/controllers/application_controller.rb - (10 offenses)
  * **Line # 3 - convention:** Metrics/ClassLength: Class has too many lines. [113/100]

    ```rb
    class ApplicationController < ActionController::API ...
    ```

  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class ApplicationController`.

    ```rb
    class ApplicationController < ActionController::API
    ```

  * **Line # 22 - convention:** Metrics/AbcSize: Assignment Branch Condition size for cache_action_response is too high. [<4, 33, 2> 33.3/17]

    ```rb
      def cache_action_response ...
    ```

  * **Line # 22 - convention:** Metrics/MethodLength: Method has too many lines. [16/10]

    ```rb
      def cache_action_response ...
    ```

  * **Line # 29 - convention:** Style/RedundantInterpolation: Prefer `to_s` over string interpolation.

    ```rb
        cache_params_key = Digest::SHA1.hexdigest("#{cache_params.merge( ...
    ```

  * **Line # 94 - convention:** Style/SafeNavigation: Use safe navigation (`&.`) instead of checking if an object exists before calling the method.

    ```rb
          record.image_to_record.destroy! if record.image_to_record
    ```

  * **Line # 128 - convention:** Metrics/AbcSize: Assignment Branch Condition size for json_metadata is too high. [<1, 21, 11> 23.73/17]

    ```rb
      def json_metadata(resources) ...
    ```

  * **Line # 128 - convention:** Metrics/CyclomaticComplexity: Cyclomatic complexity for json_metadata is too high. [9/7]

    ```rb
      def json_metadata(resources) ...
    ```

  * **Line # 128 - convention:** Metrics/MethodLength: Method has too many lines. [17/10]

    ```rb
      def json_metadata(resources) ...
    ```

  * **Line # 128 - convention:** Metrics/PerceivedComplexity: Perceived complexity for json_metadata is too high. [9/8]

    ```rb
      def json_metadata(resources) ...
    ```

### app/controllers/v1/admin/menu/allergens_controller.rb - (4 offenses)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class V1::Admin::Menu::AllergensController`.

    ```rb
      class AllergensController < ApplicationController
    ```

  * **Line # 29 - convention:** Metrics/AbcSize: Assignment Branch Condition size for create is too high. [<2, 26, 6> 26.76/17]

    ```rb
        def create ...
    ```

  * **Line # 41 - convention:** Metrics/AbcSize: Assignment Branch Condition size for update is too high. [<0, 22, 7> 23.09/17]

    ```rb
        def update ...
    ```

  * **Line # 41 - convention:** Metrics/CyclomaticComplexity: Cyclomatic complexity for update is too high. [8/7]

    ```rb
        def update ...
    ```

### app/controllers/v1/admin/menu/categories_controller.rb - (17 offenses)
  * **Line # 5 - convention:** Metrics/ClassLength: Class has too many lines. [187/100]

    ```rb
        class CategoriesController < ApplicationController ...
    ```

  * **Line # 5 - convention:** Style/Documentation: Missing top-level documentation comment for `class V1::Admin::Menu::CategoriesController`.

    ```rb
        class CategoriesController < ApplicationController
    ```

  * **Line # 41 - convention:** Metrics/AbcSize: Assignment Branch Condition size for create is too high. [<1, 20, 5> 20.64/17]

    ```rb
          def create ...
    ```

  * **Line # 51 - convention:** Metrics/AbcSize: Assignment Branch Condition size for update is too high. [<0, 18, 5> 18.68/17]

    ```rb
          def update ...
    ```

  * **Line # 82 - convention:** Metrics/AbcSize: Assignment Branch Condition size for add_dish is too high. [<3, 20, 3> 20.45/17]

    ```rb
          def add_dish ...
    ```

  * **Line # 82 - convention:** Metrics/MethodLength: Method has too many lines. [12/10]

    ```rb
          def add_dish ...
    ```

  * **Line # 98 - convention:** Metrics/AbcSize: Assignment Branch Condition size for move is too high. [<0, 18, 7> 19.31/17]

    ```rb
          def move ...
    ```

  * **Line # 120 - convention:** Metrics/AbcSize: Assignment Branch Condition size for copy is too high. [<3, 22, 2> 22.29/17]

    ```rb
          def copy ...
    ```

  * **Line # 120 - convention:** Metrics/MethodLength: Method has too many lines. [14/10]

    ```rb
          def copy ...
    ```

  * **Line # 129 - convention:** Performance/RedundantMerge: Use `copy_params[:parent_id] = params[:parent_id]` instead of `copy_params.merge!(parent_id: params[:parent_id])`.

    ```rb
            copy_params.merge!(parent_id: params[:parent_id]) if params.key?(:parent_id)
    ```

  * **Line # 150 - convention:** Metrics/MethodLength: Method has too many lines. [12/10]

    ```rb
          def add_category ...
    ```

  * **Line # 171 - warning:** Lint/BooleanSymbol: Symbol with a boolean name - you probably meant to use `true`.

    ```rb
            publishing_now = [true, 1, "true", "1", :true].include?(params[:public_visible])
    ```

  * **Line # 185 - warning:** Lint/BooleanSymbol: Symbol with a boolean name - you probably meant to use `true`.

    ```rb
            [true, 1, "true", "1", :true].include? params[:force]
    ```

  * **Line # 200 - convention:** Performance/RedundantMerge: Use `update_params[:visibility_id] = nil` instead of `update_params.merge!(visibility_id: nil)`.

    ```rb
              update_params.merge!(visibility_id: nil)
    ```

  * **Line # 224 - convention:** Layout/LineLength: Line is too long. [146/120]

    ```rb
                                            :text_translations, menu_dishes_in_categories: [:menu_dish], images: [:attached_image_blob]).map do |item|
    ```

  * **Line # 235 - convention:** Metrics/AbcSize: Assignment Branch Condition size for single_item_full_json is too high. [<0, 21, 6> 21.84/17]

    ```rb
          def single_item_full_json(item) ...
    ```

  * **Line # 235 - convention:** Metrics/MethodLength: Method has too many lines. [13/10]

    ```rb
          def single_item_full_json(item) ...
    ```

### app/controllers/v1/admin/menu/dishes_controller.rb - (19 offenses)
  * **Line # 5 - convention:** Metrics/ClassLength: Class has too many lines. [266/100]

    ```rb
        class DishesController < ApplicationController ...
    ```

  * **Line # 5 - convention:** Style/Documentation: Missing top-level documentation comment for `class V1::Admin::Menu::DishesController`.

    ```rb
        class DishesController < ApplicationController
    ```

  * **Line # 41 - convention:** Metrics/AbcSize: Assignment Branch Condition size for create is too high. [<1, 34, 7> 34.73/17]

    ```rb
          def create ...
    ```

  * **Line # 41 - convention:** Metrics/CyclomaticComplexity: Cyclomatic complexity for create is too high. [8/7]

    ```rb
          def create ...
    ```

  * **Line # 41 - convention:** Metrics/MethodLength: Method has too many lines. [11/10]

    ```rb
          def create ...
    ```

  * **Line # 49 - convention:** Layout/LineLength: Line is too long. [127/120]

    ```rb
                                                 menu_category_id: params[:category_id].present? ? params[:category_id].to_i : nil)
    ```

  * **Line # 58 - convention:** Metrics/AbcSize: Assignment Branch Condition size for update is too high. [<1, 28, 6> 28.65/17]

    ```rb
          def update ...
    ```

  * **Line # 104 - convention:** Layout/LineLength: Line is too long. [131/120]

    ```rb
                                           menu_category_id: params[:category_id].blank? ? nil : params[:category_id].to_i).destroy_all
    ```

  * **Line # 148 - convention:** Metrics/AbcSize: Assignment Branch Condition size for copy is too high. [<2, 19, 1> 19.13/17]

    ```rb
          def copy ...
    ```

  * **Line # 148 - convention:** Metrics/MethodLength: Method has too many lines. [14/10]

    ```rb
          def copy ...
    ```

  * **Line # 167 - convention:** Metrics/AbcSize: Assignment Branch Condition size for add_ingredient is too high. [<3, 20, 3> 20.45/17]

    ```rb
          def add_ingredient ...
    ```

  * **Line # 167 - convention:** Metrics/MethodLength: Method has too many lines. [12/10]

    ```rb
          def add_ingredient ...
    ```

  * **Line # 193 - convention:** Metrics/AbcSize: Assignment Branch Condition size for move_ingredient is too high. [<2, 18, 2> 18.22/17]

    ```rb
          def move_ingredient ...
    ```

  * **Line # 209 - convention:** Metrics/AbcSize: Assignment Branch Condition size for add_tag is too high. [<3, 20, 3> 20.45/17]

    ```rb
          def add_tag ...
    ```

  * **Line # 230 - convention:** Metrics/AbcSize: Assignment Branch Condition size for move_tag is too high. [<2, 18, 2> 18.22/17]

    ```rb
          def move_tag ...
    ```

  * **Line # 246 - convention:** Metrics/AbcSize: Assignment Branch Condition size for add_allergen is too high. [<3, 20, 3> 20.45/17]

    ```rb
          def add_allergen ...
    ```

  * **Line # 246 - convention:** Metrics/MethodLength: Method has too many lines. [12/10]

    ```rb
          def add_allergen ...
    ```

  * **Line # 271 - convention:** Metrics/AbcSize: Assignment Branch Condition size for move_allergen is too high. [<2, 18, 2> 18.22/17]

    ```rb
          def move_allergen ...
    ```

  * **Line # 287 - convention:** Metrics/AbcSize: Assignment Branch Condition size for add_image is too high. [<3, 20, 3> 20.45/17]

    ```rb
          def add_image ...
    ```

### app/controllers/v1/admin/menu/ingredients_controller.rb - (3 offenses)
  * **Line # 5 - convention:** Style/Documentation: Missing top-level documentation comment for `class V1::Admin::Menu::IngredientsController`.

    ```rb
        class IngredientsController < ApplicationController
    ```

  * **Line # 30 - convention:** Metrics/AbcSize: Assignment Branch Condition size for create is too high. [<2, 27, 5> 27.53/17]

    ```rb
          def create ...
    ```

  * **Line # 44 - convention:** Metrics/AbcSize: Assignment Branch Condition size for update is too high. [<0, 25, 6> 25.71/17]

    ```rb
          def update ...
    ```

### app/controllers/v1/admin/menu/tags_controller.rb - (4 offenses)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class V1::Admin::Menu::TagsController`.

    ```rb
      class TagsController < ApplicationController
    ```

  * **Line # 29 - convention:** Metrics/AbcSize: Assignment Branch Condition size for create is too high. [<2, 26, 6> 26.76/17]

    ```rb
        def create ...
    ```

  * **Line # 41 - convention:** Metrics/AbcSize: Assignment Branch Condition size for update is too high. [<0, 22, 7> 23.09/17]

    ```rb
        def update ...
    ```

  * **Line # 41 - convention:** Metrics/CyclomaticComplexity: Cyclomatic complexity for update is too high. [8/7]

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

  * **Line # 24 - convention:** Layout/LineLength: Line is too long. [153/120]

    ```rb
            # render json: current_user.preference(params[:key]).as_json(except: %i[id created_at]).merge(value: current_user.preference_value(params[:key]))
    ```

### app/controllers/v1/admin/preorder_reservation_groups_controller.rb - (5 offenses)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class V1::Admin::PreorderReservationGroupsController`.

    ```rb
      class PreorderReservationGroupsController < ApplicationController
    ```

  * **Line # 9 - convention:** Metrics/AbcSize: Assignment Branch Condition size for index is too high. [<4, 18, 2> 18.55/17]

    ```rb
        def index ...
    ```

  * **Line # 70 - convention:** Layout/LineLength: Line is too long. [127/120]

    ```rb
                                                              table_type_to_preorder_reservation_groups: :table_type).map do |item|
    ```

  * **Line # 78 - convention:** Layout/LineLength: Line is too long. [123/120]

    ```rb
                "Invalid params. PreorderReservationGroup or ActiveRecord::Relation expected, but #{item_or_items.class} given"
    ```

  * **Line # 89 - convention:** Layout/LineLength: Line is too long. [129/120]

    ```rb
            table_type_to_preorder_reservation_groups: item.table_type_to_preorder_reservation_groups.as_json(include: [:table_type])
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

### app/controllers/v1/admin/reservations_controller.rb - (7 offenses)
  * **Line # 4 - convention:** Metrics/ClassLength: Class has too many lines. [175/100]

    ```rb
      class ReservationsController < ApplicationController ...
    ```

  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class V1::Admin::ReservationsController`.

    ```rb
      class ReservationsController < ApplicationController
    ```

  * **Line # 6 - convention:** Layout/LineLength: Line is too long. [157/120]

    ```rb
                      only: %i[show refund_payment record_deferred_payment refresh_payment_status deliver_confirmation_email update destroy update_status add_tag
    ```

  * **Line # 160 - convention:** Metrics/AbcSize: Assignment Branch Condition size for export is too high. [<2, 20, 2> 20.2/17]

    ```rb
        def export ...
    ```

  * **Line # 160 - convention:** Metrics/MethodLength: Method has too many lines. [12/10]

    ```rb
        def export ...
    ```

  * **Line # 190 - convention:** Layout/LineLength: Line is too long. [139/120]

    ```rb
                                                            table_type: [:text_translations, { images: [:attached_image_blob] }]).map do |item|
    ```

  * **Line # 201 - convention:** Metrics/MethodLength: Method has too many lines. [19/10]

    ```rb
        def single_item_full_json(item) ...
    ```

### app/controllers/v1/admin/settings_controller.rb - (1 offense)
  * **Line # 5 - convention:** Style/Documentation: Missing top-level documentation comment for `class V1::Admin::SettingsController`.

    ```rb
        class SettingsController < ApplicationController
    ```

### app/controllers/v1/admin/table_types_controller.rb - (4 offenses)
  * **Line # 32 - convention:** Metrics/AbcSize: Assignment Branch Condition size for create is too high. [<1, 20, 5> 20.64/17]

    ```rb
        def create ...
    ```

  * **Line # 43 - convention:** Metrics/AbcSize: Assignment Branch Condition size for update is too high. [<0, 18, 5> 18.68/17]

    ```rb
        def update ...
    ```

  * **Line # 92 - convention:** Layout/LineLength: Line is too long. [127/120]

    ```rb
                                            table_type_to_preorder_reservation_groups: :preorder_reservation_group }).map do |item|
    ```

  * **Line # 109 - convention:** Layout/LineLength: Line is too long. [145/120]

    ```rb
            table_type_to_preorder_reservation_groups: item.table_type_to_preorder_reservation_groups.as_json(include: [:preorder_reservation_group])
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

### app/controllers/v1/menu/categories_controller.rb - (2 offenses)
  * **Line # 9 - convention:** Metrics/MethodLength: Method has too many lines. [11/10]

    ```rb
        def index ...
    ```

  * **Line # 39 - convention:** Layout/LineLength: Line is too long. [147/120]

    ```rb
          @item = Menu::Category.visible.public_visible.find_by(id: params[:id]) || Menu::Category.visible.private_visible.find_by(secret: params[:id])
    ```

### app/controllers/v1/menu/dishes_controller.rb - (3 offenses)
  * **Line # 9 - convention:** Metrics/MethodLength: Method has too many lines. [11/10]

    ```rb
        def index ...
    ```

  * **Line # 34 - convention:** Metrics/AbcSize: Assignment Branch Condition size for full_json is too high. [<0, 25, 2> 25.08/17]

    ```rb
        def full_json(item_or_items) ...
    ```

  * **Line # 34 - convention:** Metrics/MethodLength: Method has too many lines. [11/10]

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

### app/controllers/v1/public_data_controller.rb - (2 offenses)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class V1::PublicDataController`.

    ```rb
      class PublicDataController < ApplicationController
    ```

  * **Line # 7 - convention:** Metrics/MethodLength: Method has too many lines. [19/10]

    ```rb
        def index ...
    ```

### app/controllers/v1/reservations_controller.rb - (14 offenses)
  * **Line # 4 - convention:** Metrics/ClassLength: Class has too many lines. [106/100]

    ```rb
      class ReservationsController < ApplicationController ...
    ```

  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class V1::ReservationsController`.

    ```rb
      class ReservationsController < ApplicationController
    ```

  * **Line # 17 - convention:** Metrics/AbcSize: Assignment Branch Condition size for do_payment is too high. [<0, 22, 5> 22.56/17]

    ```rb
        def do_payment ...
    ```

  * **Line # 33 - convention:** Metrics/AbcSize: Assignment Branch Condition size for create is too high. [<3, 20, 1> 20.25/17]

    ```rb
        def create ...
    ```

  * **Line # 33 - convention:** Metrics/MethodLength: Method has too many lines. [12/10]

    ```rb
        def create ...
    ```

  * **Line # 87 - convention:** Metrics/AbcSize: Assignment Branch Condition size for datetime_requires_payment is too high. [<2, 32, 5> 32.45/17]

    ```rb
        def datetime_requires_payment ...
    ```

  * **Line # 87 - convention:** Metrics/MethodLength: Method has too many lines. [20/10]

    ```rb
        def datetime_requires_payment ...
    ```

  * **Line # 95 - convention:** Style/IfUnlessModifier: Favor modifier `if` usage when having a single-line body. Another good alternative is the usage of control flow `&&`/`||`.

    ```rb
          if call.result.nil?
    ```

  * **Line # 101 - convention:** Layout/LineLength: Line is too long. [151/120]

    ```rb
                                                              table_type_to_preorder_reservation_groups: :preorder_reservation_group }).map do |table_type|
    ```

  * **Line # 102 - convention:** Layout/ArgumentAlignment: Align the arguments of a method call if they span more than one line.

    ```rb
              { images: :attached_image_blob, ...
    ```

  * **Line # 102 - convention:** Layout/IndentationWidth: Use 2 (not -11) spaces for indentation.

    ```rb
                table_type.as_json.merge(
    ```

  * **Line # 107 - convention:** Layout/LineLength: Line is too long. [172/120]

    ```rb
                               # table_type_to_preorder_reservation_groups: table_type.table_type_to_preorder_reservation_groups.as_json(include: [:preorder_reservation_group])
    ```

  * **Line # 108 - convention:** Style/TrailingCommaInArguments: Avoid comma after the last parameter of a method call.

    ```rb
                  images: table_type.images.map(&:full_json),
    ```

  * **Line # 111 - convention:** Layout/BlockAlignment: `end` at 111, 10 is not aligned with `call.result.table_types.includes(:text_translations,` at 101, 23 or `table_type_to_preorder_reservation_groups: :preorder_reservation_group }).map do |table_type|` at 103, 12.

    ```rb
              end
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

  * **Line # 8 - convention:** Metrics/MethodLength: Method has too many lines. [15/10]

    ```rb
        def valid_times ...
    ```

### app/interactions/admin_create_reservation_payment.rb - (2 offenses)
  * **Line # 14 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<0, 17, 5> 17.72/17]

    ```rb
      def execute ...
    ```

  * **Line # 21 - convention:** Rails/SkipsModelValidations: Avoid using `touch` because it skips validations.

    ```rb
        reservation.touch if errors.empty?
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

### app/interactions/available_seats_for_reservation_turn_and_pgroup.rb - (1 offense)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class AvailableSeatsForReservationTurnAndPgroup`.

    ```rb
    class AvailableSeatsForReservationTurnAndPgroup < ActiveInteraction::Base
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

### app/interactions/create_preorder_group.rb - (8 offenses)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class CreatePreorderGroup`.

    ```rb
    class CreatePreorderGroup < ActiveInteraction::Base
    ```

  * **Line # 26 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<0, 21, 6> 21.84/17]

    ```rb
      def execute ...
    ```

  * **Line # 42 - convention:** Metrics/AbcSize: Assignment Branch Condition size for create_group is too high. [<1, 25, 2> 25.1/17]

    ```rb
      def create_group ...
    ```

  * **Line # 42 - convention:** Metrics/MethodLength: Method has too many lines. [17/10]

    ```rb
      def create_group ...
    ```

  * **Line # 51 - convention:** Style/TrailingCommaInHashLiteral: Avoid comma after the last item of a hash.

    ```rb
            status: params.delete(:status),
    ```

  * **Line # 97 - convention:** Metrics/AbcSize: Assignment Branch Condition size for initialize_table_types is too high. [<3, 19, 4> 19.65/17]

    ```rb
      def initialize_table_types ...
    ```

  * **Line # 97 - convention:** Metrics/MethodLength: Method has too many lines. [12/10]

    ```rb
      def initialize_table_types ...
    ```

  * **Line # 98 - convention:** Style/PreferredHashMethods: Use `Hash#key?` instead of `Hash#has_key?`.

    ```rb
        return [] unless params.has_key?(:table_types)
    ```

### app/interactions/create_reservation_payment.rb - (1 offense)
  * **Line # 16 - convention:** Layout/LineLength: Line is too long. [122/120]

    ```rb
      # If the reservation is a payment or an authorization. When deferred is a authorization, the payment will be done later.
    ```

### app/interactions/date_time_requires_payment.rb - (5 offenses)
  * **Line # 10 - convention:** Rails/I18nLocaleTexts: Move locale texts to the locale files in the `config/locales` directory.

    ```rb
      validates :date, format: { with: /\A\d{4}-\d{1,2}-\d{1,2}\z/, message: "must be in YYYY-MM-DD format" }
    ```

  * **Line # 11 - convention:** Rails/I18nLocaleTexts: Move locale texts to the locale files in the `config/locales` directory.

    ```rb
      validates :time, format: { with: /\A\d{1,2}:\d{1,2}\z/, message: "must be in HH:MM format" }
    ```

  * **Line # 18 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<0, 34, 9> 35.17/17]

    ```rb
      def execute ...
    ```

  * **Line # 18 - convention:** Metrics/MethodLength: Method has too many lines. [15/10]

    ```rb
      def execute ...
    ```

  * **Line # 30 - convention:** Layout/LineLength: Line is too long. [135/120]

    ```rb
            raise "Expected one group for turn #{matching_turns.first.id}, got #{matching_turns.first.preorder_reservation_groups.as_json}"
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

### app/interactions/dev/detach_all_from_old.rb - (7 offenses)
  * **Line # 7 - convention:** Rails/SkipsModelValidations: Avoid using `update_all` because it skips validations.

    ```rb
          Menu::Category.update_all(member_id: nil)
    ```

  * **Line # 8 - convention:** Rails/SkipsModelValidations: Avoid using `update_all` because it skips validations.

    ```rb
          Menu::Tag.update_all(member_id: nil)
    ```

  * **Line # 9 - convention:** Rails/SkipsModelValidations: Avoid using `update_all` because it skips validations.

    ```rb
          Menu::Ingredient.update_all(member_id: nil)
    ```

  * **Line # 10 - convention:** Rails/SkipsModelValidations: Avoid using `update_all` because it skips validations.

    ```rb
          Menu::Allergen.update_all(member_id: nil)
    ```

  * **Line # 11 - convention:** Rails/SkipsModelValidations: Avoid using `update_all` because it skips validations.

    ```rb
          Menu::Dish.update_all(member_id: nil)
    ```

  * **Line # 12 - convention:** Rails/SkipsModelValidations: Avoid using `update_all` because it skips validations.

    ```rb
          Image.update_all(member_id: nil)
    ```

  * **Line # 13 - convention:** Rails/SkipsModelValidations: Avoid using `update_all` because it skips validations.

    ```rb
          Reservation.update_all(member_id: nil)
    ```

### app/interactions/dev/fast_export_reservations.rb - (3 offenses)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class Dev::FastExportReservations`.

    ```rb
      class FastExportReservations < ActiveInteraction::Base
    ```

  * **Line # 9 - convention:** Layout/LineLength: Line is too long. [201/120]

    ```rb
          command = %(psql -d #{ActiveRecord::Base.connection_db_config.database} -c "COPY (SELECT * FROM #{Reservation.table_name}) TO STDOUT WITH CSV HEADER DELIMITER ';' ;" > #{outdir}/reservations.csv)
    ```

  * **Line # 10 - convention:** Rails/Output: Do not write to stdout. Use Rails's logger if you want to log.

    ```rb
          puts command
    ```

### app/interactions/dev/fast_import_reservations.rb - (3 offenses)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class Dev::FastImportReservations`.

    ```rb
      class FastImportReservations < ActiveInteraction::Base
    ```

  * **Line # 10 - convention:** Layout/LineLength: Line is too long. [163/120]

    ```rb
          command = %(psql -d #{ActiveRecord::Base.connection_db_config.database} -c "COPY #{Reservation.table_name} FROM '#{csv_location}' DELIMITER ';' CSV HEADER;")
    ```

  * **Line # 11 - convention:** Rails/Output: Do not write to stdout. Use Rails's logger if you want to log.

    ```rb
          puts command
    ```

### app/interactions/dev/import_all.rb - (1 offense)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class Dev::ImportAll`.

    ```rb
      class ImportAll < ActiveInteraction::Base
    ```

### app/interactions/dev/import_images.rb - (4 offenses)
  * **Line # 10 - convention:** Rails/FilePath: Prefer `Rails.root.join('path/to')`.

    ```rb
        string :csv_location, default: Rails.root.join("migration", "records", "media.csv").to_s
    ```

  * **Line # 11 - convention:** Rails/FilePath: Prefer `Rails.root.join('path/to')`.

    ```rb
        string :images_location, default: Rails.root.join("migration", "images").to_s
    ```

  * **Line # 14 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<7, 28, 4> 29.14/17]

    ```rb
        def execute ...
    ```

  * **Line # 14 - convention:** Metrics/MethodLength: Method has too many lines. [15/10]

    ```rb
        def execute ...
    ```

### app/interactions/dev/import_reservations.rb - (9 offenses)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class Dev::ImportReservations`.

    ```rb
      class ImportReservations < ActiveInteraction::Base
    ```

  * **Line # 5 - convention:** Rails/FilePath: Prefer `Rails.root.join('path/to')`.

    ```rb
        string :csv_location, default: Rails.root.join("migration", "records", "reservations.csv").to_s
    ```

  * **Line # 8 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<5, 58, 11> 59.25/17]

    ```rb
        def execute ...
    ```

  * **Line # 8 - convention:** Metrics/CyclomaticComplexity: Cyclomatic complexity for execute is too high. [10/7]

    ```rb
        def execute ...
    ```

  * **Line # 8 - convention:** Metrics/MethodLength: Method has too many lines. [28/10]

    ```rb
        def execute ...
    ```

  * **Line # 8 - convention:** Metrics/PerceivedComplexity: Perceived complexity for execute is too high. [10/8]

    ```rb
        def execute ...
    ```

  * **Line # 39 - convention:** Layout/LineLength: Line is too long. [136/120]

    ```rb
              Rails.logger.error("Error saving reservation: #{reservation.errors.full_messages} at line #{row_index} (old id #{row["id"]})")
    ```

  * **Line # 48 - convention:** Style/HashTransformValues: Prefer `transform_values` over `to_h {...}`.

    ```rb
          @tokens ||= CSV.open( ...
    ```

  * **Line # 58 - convention:** Rails/Output: Do not write to stdout. Use Rails's logger if you want to log.

    ```rb
          puts message
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

### app/interactions/dev/menu/import_all.rb - (1 offense)
  * **Line # 5 - convention:** Style/Documentation: Missing top-level documentation comment for `class Dev::Menu::ImportAll`.

    ```rb
        class ImportAll < ActiveInteraction::Base
    ```

### app/interactions/dev/menu/import_allergens.rb - (3 offenses)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class Dev::Menu::ImportAllergens`.

    ```rb
      class ImportAllergens < ActiveInteraction::Base
    ```

  * **Line # 10 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<6, 30, 5> 31/17]

    ```rb
        def execute ...
    ```

  * **Line # 10 - convention:** Metrics/MethodLength: Method has too many lines. [17/10]

    ```rb
        def execute ...
    ```

### app/interactions/dev/menu/import_categories.rb - (7 offenses)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class Dev::Menu::ImportCategories`.

    ```rb
      class ImportCategories < ActiveInteraction::Base
    ```

  * **Line # 10 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<10, 45, 7> 46.63/17]

    ```rb
        def execute ...
    ```

  * **Line # 10 - convention:** Metrics/MethodLength: Method has too many lines. [25/10]

    ```rb
        def execute ...
    ```

  * **Line # 28 - convention:** Layout/LineLength: Line is too long. [132/120]

    ```rb
                Rails.logger.warn "Parent not found for category #{category.member_id}. Old parent id: #{categories[row["id"]].inspect}"
    ```

  * **Line # 34 - convention:** Layout/LineLength: Line is too long. [123/120]

    ```rb
                Rails.logger.warn "Image not found for category #{category.member_id}. Old image id: #{row["imageId"].inspect}"
    ```

  * **Line # 47 - convention:** Layout/LineLength: Line is too long. [127/120]

    ```rb
                                                                                            liberal_parsing: true).to_a.map(&:to_h)
    ```

  * **Line # 49 - convention:** Style/MapToHash: Pass a block to `to_h` instead of calling `map.to_h`.

    ```rb
          @categories = data.map { |j| [j["categoryId"], j["menuId"]] }.to_h
    ```

### app/interactions/dev/menu/import_dishes.rb - (18 offenses)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class Dev::Menu::ImportDishes`.

    ```rb
      class ImportDishes < ActiveInteraction::Base
    ```

  * **Line # 10 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<14, 84, 18> 87.04/17]

    ```rb
        def execute ...
    ```

  * **Line # 10 - convention:** Metrics/CyclomaticComplexity: Cyclomatic complexity for execute is too high. [17/7]

    ```rb
        def execute ...
    ```

  * **Line # 10 - convention:** Metrics/MethodLength: Method has too many lines. [39/10]

    ```rb
        def execute ...
    ```

  * **Line # 10 - convention:** Metrics/PerceivedComplexity: Perceived complexity for execute is too high. [19/8]

    ```rb
        def execute ...
    ```

  * **Line # 11 - convention:** Metrics/BlockLength: Block has too many lines. [37/25]

    ```rb
          Rails.logger.silence(verbose ? Logger::DEBUG : Logger::WARN) do ...
    ```

  * **Line # 12 - convention:** Metrics/BlockLength: Block has too many lines. [34/25]

    ```rb
            CSV.foreach(file, headers: true, col_sep: ";", quote_char: '"', force_quotes: true, ...
    ```

  * **Line # 34 - convention:** Layout/LineLength: Line is too long. [128/120]

    ```rb
                  Rails.logger.warn "Category not found for dish #{dish.member_id}. Old category id: #{menu_ids[row["id"]].inspect}"
    ```

  * **Line # 68 - convention:** Layout/LineLength: Line is too long. [122/120]

    ```rb
                                                                                     liberal_parsing: true).to_a.each do |row|
    ```

  * **Line # 81 - convention:** Layout/LineLength: Line is too long. [123/120]

    ```rb
                                                                                        liberal_parsing: true).to_a.map(&:to_h)
    ```

  * **Line # 83 - convention:** Style/HashTransformValues: Prefer `transform_values` over `map {...}.to_h`.

    ```rb
          @tag_ids = data.group_by { |j| j["foodItemId"] }.map { |k, v| [k, v.map { |j| j["tagId"] }] }.to_h
    ```

  * **Line # 83 - convention:** Style/MapToHash: Pass a block to `to_h` instead of calling `map.to_h`.

    ```rb
          @tag_ids = data.group_by { |j| j["foodItemId"] }.map { |k, v| [k, v.map { |j| j["tagId"] }] }.to_h
    ```

  * **Line # 90 - convention:** Layout/LineLength: Line is too long. [128/120]

    ```rb
                                                                                             liberal_parsing: true).to_a.map(&:to_h)
    ```

  * **Line # 92 - convention:** Style/HashTransformValues: Prefer `transform_values` over `map {...}.to_h`.

    ```rb
          @allergen_ids = data.group_by { |j| j["foodItemId"] }.map { |k, v| [k, v.map { |j| j["allergenId"] }] }.to_h
    ```

  * **Line # 92 - convention:** Style/MapToHash: Pass a block to `to_h` instead of calling `map.to_h`.

    ```rb
          @allergen_ids = data.group_by { |j| j["foodItemId"] }.map { |k, v| [k, v.map { |j| j["allergenId"] }] }.to_h
    ```

  * **Line # 99 - convention:** Layout/LineLength: Line is too long. [130/120]

    ```rb
                                                                                               liberal_parsing: true).to_a.map(&:to_h)
    ```

  * **Line # 101 - convention:** Style/HashTransformValues: Prefer `transform_values` over `map {...}.to_h`.

    ```rb
          @ingredient_ids = data.group_by { |j| j["foodItemId"] }.map { |k, v| [k, v.map { |j| j["ingredientId"] }] }.to_h
    ```

  * **Line # 101 - convention:** Style/MapToHash: Pass a block to `to_h` instead of calling `map.to_h`.

    ```rb
          @ingredient_ids = data.group_by { |j| j["foodItemId"] }.map { |k, v| [k, v.map { |j| j["ingredientId"] }] }.to_h
    ```

### app/interactions/dev/menu/import_ingredients.rb - (4 offenses)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class Dev::Menu::ImportIngredients`.

    ```rb
      class ImportIngredients < ActiveInteraction::Base
    ```

  * **Line # 10 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<8, 34, 5> 35.28/17]

    ```rb
        def execute ...
    ```

  * **Line # 10 - convention:** Metrics/MethodLength: Method has too many lines. [19/10]

    ```rb
        def execute ...
    ```

  * **Line # 29 - convention:** Layout/LineLength: Line is too long. [121/120]

    ```rb
                Rails.logger.warn "Image not found for ingredient #{ingredient.member_id}. Old image id: #{image_id.inspect}"
    ```

### app/interactions/dev/menu/import_menus.rb - (3 offenses)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class Dev::Menu::ImportMenus`.

    ```rb
      class ImportMenus < ActiveInteraction::Base
    ```

  * **Line # 10 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<7, 39, 7> 40.24/17]

    ```rb
        def execute ...
    ```

  * **Line # 10 - convention:** Metrics/MethodLength: Method has too many lines. [20/10]

    ```rb
        def execute ...
    ```

### app/interactions/dev/menu/import_tags.rb - (3 offenses)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class Dev::Menu::ImportTags`.

    ```rb
      class ImportTags < ActiveInteraction::Base
    ```

  * **Line # 10 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<7, 34, 6> 35.23/17]

    ```rb
        def execute ...
    ```

  * **Line # 10 - convention:** Metrics/MethodLength: Method has too many lines. [18/10]

    ```rb
        def execute ...
    ```

### app/interactions/dev/split_and_import_reservations.rb - (9 offenses)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class Dev::SplitAndImportReservations`.

    ```rb
      class SplitAndImportReservations < ActiveInteraction::Base
    ```

  * **Line # 8 - convention:** Rails/FilePath: Prefer `Rails.root.join('path/to')`.

    ```rb
        string :csv_location, default: Rails.root.join("migration", "records", "reservations.csv").to_s
    ```

  * **Line # 9 - convention:** Rails/FilePath: Prefer `Rails.root.join('path/to')`.

    ```rb
        string :output_dir, default: Rails.root.join("tmp", "lpda-import").to_s
    ```

  * **Line # 16 - convention:** Rails/Output: Do not write to stdout. Use Rails's logger if you want to log.

    ```rb
          puts "Preparing output directory..."
    ```

  * **Line # 18 - convention:** Rails/Output: Do not write to stdout. Use Rails's logger if you want to log.

    ```rb
          puts "Splitting CSV..."
    ```

  * **Line # 20 - convention:** Rails/Output: Do not write to stdout. Use Rails's logger if you want to log.

    ```rb
          puts "Importing files in parallel..."
    ```

  * **Line # 31 - convention:** Metrics/AbcSize: Assignment Branch Condition size for split_csv is too high. [<9, 23, 4> 25.02/17]

    ```rb
        def split_csv ...
    ```

  * **Line # 31 - convention:** Metrics/MethodLength: Method has too many lines. [17/10]

    ```rb
        def split_csv ...
    ```

  * **Line # 59 - convention:** Rails/Output: Do not write to stdout. Use Rails's logger if you want to log.

    ```rb
            puts "Importing #{file}..."
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
  * **Line # 22 - convention:** Metrics/AbcSize: Assignment Branch Condition size for write_all is too high. [<3, 32, 3> 32.28/17]

    ```rb
      def write_all(sheet) ...
    ```

  * **Line # 22 - convention:** Metrics/MethodLength: Method has too many lines. [15/10]

    ```rb
      def write_all(sheet) ...
    ```

  * **Line # 33 - convention:** Layout/LineLength: Line is too long. [163/120]

    ```rb
                    [reservation.id, reservation.fullname, ignore_dst(reservation.datetime).strftime("%e/%m/%Y %k:%M").strip, reservation.children, reservation.adults,
    ```

  * **Line # 34 - convention:** Layout/LineLength: Line is too long. [132/120]

    ```rb
                     reservation.email, reservation.phone, reservation.table, reservation.notes, reservation.status, reservation.secret,
    ```

  * **Line # 35 - convention:** Layout/LineLength: Line is too long. [130/120]

    ```rb
                     reservation.created_at.strftime("%e/%m/%Y %k:%M").strip, reservation.updated_at.strftime("%e/%m/%Y %k:%M").strip,
    ```

### app/interactions/fetch_reservation_payment_status.rb - (13 offenses)
  * **Line # 8 - convention:** Rails/Blank: Use `if reservation_payment.external_id.blank?` instead of `unless reservation_payment.external_id.present?`.

    ```rb
        errors.add(:reservation_payment, "does not have an 'external_id'") unless reservation_payment.external_id.present?
    ```

  * **Line # 18 - warning:** Lint/DuplicateBranch: Duplicate branch body detected.

    ```rb
        when "html_nexi_authorization" then fetch_nexi_status
    ```

  * **Line # 24 - convention:** Metrics/AbcSize: Assignment Branch Condition size for fetch_nexi_status is too high. [<3, 52, 17> 54.79/17]

    ```rb
      def fetch_nexi_status ...
    ```

  * **Line # 24 - convention:** Metrics/CyclomaticComplexity: Cyclomatic complexity for fetch_nexi_status is too high. [14/7]

    ```rb
      def fetch_nexi_status ...
    ```

  * **Line # 24 - convention:** Metrics/MethodLength: Method has too many lines. [28/10]

    ```rb
      def fetch_nexi_status ...
    ```

  * **Line # 24 - convention:** Metrics/PerceivedComplexity: Perceived complexity for fetch_nexi_status is too high. [13/8]

    ```rb
      def fetch_nexi_status ...
    ```

  * **Line # 41 - convention:** Performance/Casecmp: Use `call.result["esito"].to_s.casecmp("ko").zero?` instead of `call.result["esito"].to_s.downcase == "ko"`.

    ```rb
        return if reservation_payment.todo? && call.result["esito"].to_s.downcase == "ko" && call.result.dig("errore",
    ```

  * **Line # 42 - convention:** Layout/LineLength: Line is too long. [126/120]

    ```rb
                                                                                                             "codice").to_s == "2"
    ```

  * **Line # 45 - convention:** Rails/Blank: Use `if item.blank?` instead of `unless item.present?`.

    ```rb
        unless item.present?
    ```

  * **Line # 50 - convention:** Rails/Blank: Use `if item["stato"].blank?` instead of `unless item["stato"].present?`.

    ```rb
        unless item["stato"].present?
    ```

  * **Line # 57 - convention:** Layout/LineLength: Line is too long. [170/120]

    ```rb
        # Non Creato: il pagamento non è arrivato all’autorizzazione, si è verificato un problema sulle fasi precedenti (es.: interruzione del 3dSecure da parte dell’utente).
    ```

  * **Line # 58 - convention:** Layout/LineLength: Line is too long. [185/120]

    ```rb
        # Autorizzato: il pagamento è stato autorizzato, non ancora contabilizzato. La contabilizzazione avviene di default automaticamente da parte di NEXI, alle ore 24 dello stesso giorno
    ```

  * **Line # 60 - convention:** Layout/LineLength: Line is too long. [168/120]

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

### app/interactions/menu/export_menu.rb - (22 offenses)
  * **Line # 10 - convention:** Metrics/ClassLength: Class has too many lines. [112/100]

    ```rb
      class ExportMenu < ActiveInteraction::Base ...
    ```

  * **Line # 13 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<2, 25, 2> 25.16/17]

    ```rb
        def execute ...
    ```

  * **Line # 13 - convention:** Metrics/MethodLength: Method has too many lines. [11/10]

    ```rb
        def execute ...
    ```

  * **Line # 30 - convention:** Metrics/AbcSize: Assignment Branch Condition size for write_all is too high. [<10, 81, 10> 82.23/17]

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

  * **Line # 56 - convention:** Metrics/AbcSize: Assignment Branch Condition size for write_menu is too high. [<2, 20, 2> 20.2/17]

    ```rb
        def write_menu(sheet) ...
    ```

  * **Line # 61 - convention:** Layout/LineLength: Line is too long. [179/120]

    ```rb
                      [cat.id, cat.name_it, cat.name_en, cat.description_it, cat.description_en, cat.status, cat.price, cat.updated_at, cat.created_at, cat.images.map(&:url)].flatten)
    ```

  * **Line # 65 - convention:** Metrics/AbcSize: Assignment Branch Condition size for write_dishes is too high. [<2, 19, 2> 19.21/17]

    ```rb
        def write_dishes(sheet) ...
    ```

  * **Line # 70 - convention:** Layout/LineLength: Line is too long. [189/120]

    ```rb
                      [dish.id, dish.name_it, dish.name_en, dish.description_it, dish.description_en, dish.status, dish.price, dish.updated_at, dish.created_at, dish.images.map(&:url)].flatten)
    ```

  * **Line # 74 - convention:** Metrics/AbcSize: Assignment Branch Condition size for write_allergens is too high. [<2, 17, 2> 17.23/17]

    ```rb
        def write_allergens(sheet) ...
    ```

  * **Line # 78 - convention:** Layout/LineLength: Line is too long. [198/120]

    ```rb
                      [allergen.id, allergen.name_it, allergen.name_en, allergen.description_it, allergen.description_en, allergen.status, allergen.image&.url, allergen.updated_at, allergen.created_at])
    ```

  * **Line # 82 - convention:** Metrics/AbcSize: Assignment Branch Condition size for write_tags is too high. [<2, 18, 2> 18.22/17]

    ```rb
        def write_tags(sheet) ...
    ```

  * **Line # 87 - convention:** Layout/LineLength: Line is too long. [164/120]

    ```rb
                      [tag.id, tag.name_it, tag.name_en, tag.description_it, tag.description_en, tag.status, tag.color, tag.image&.url, tag.updated_at, tag.created_at])
    ```

  * **Line # 91 - convention:** Metrics/AbcSize: Assignment Branch Condition size for write_ingredients is too high. [<2, 17, 2> 17.23/17]

    ```rb
        def write_ingredients(sheet) ...
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

### app/interactions/menu/relocate_dishes.rb - (1 offense)
  * **Line # 18 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<2, 22, 5> 22.65/17]

    ```rb
        def execute ...
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

  * **Line # 10 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<14, 84, 18> 87.04/17]

    ```rb
        def execute ...
    ```

  * **Line # 10 - convention:** Metrics/CyclomaticComplexity: Cyclomatic complexity for execute is too high. [18/7]

    ```rb
        def execute ...
    ```

  * **Line # 10 - convention:** Metrics/MethodLength: Method has too many lines. [38/10]

    ```rb
        def execute ...
    ```

  * **Line # 10 - convention:** Metrics/PerceivedComplexity: Perceived complexity for execute is too high. [18/8]

    ```rb
        def execute ...
    ```

  * **Line # 55 - convention:** Style/PreferredHashMethods: Use `Hash#key?` instead of `Hash#has_key?`.

    ```rb
          categories = categories.where(parent_id: params[:parent_id].presence) if params.has_key?(:parent_id)
    ```

  * **Line # 62 - convention:** Performance/Casecmp: Use `params[:fixed_price].to_s.casecmp("true").zero?` instead of `params[:fixed_price].to_s.downcase == "true"`.

    ```rb
            value = params[:fixed_price].to_s.downcase == "true"
    ```

### app/interactions/menu/search_dishes.rb - (8 offenses)
  * **Line # 4 - convention:** Metrics/ClassLength: Class has too many lines. [111/100]

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

  * **Line # 99 - convention:** Metrics/AbcSize: Assignment Branch Condition size for filter_by_price is too high. [<8, 72, 20> 75.15/17]

    ```rb
        def filter_by_price(items) ...
    ```

  * **Line # 99 - convention:** Metrics/CyclomaticComplexity: Cyclomatic complexity for filter_by_price is too high. [21/7]

    ```rb
        def filter_by_price(items) ...
    ```

  * **Line # 99 - convention:** Metrics/MethodLength: Method has too many lines. [20/10]

    ```rb
        def filter_by_price(items) ...
    ```

  * **Line # 99 - convention:** Metrics/PerceivedComplexity: Perceived complexity for filter_by_price is too high. [21/8]

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
  * **Line # 8 - convention:** Metrics/ClassLength: Class has too many lines. [124/100]

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

  * **Line # 118 - convention:** Metrics/AbcSize: Assignment Branch Condition size for validate_response is too high. [<6, 39, 9> 40.47/17]

    ```rb
        def validate_response ...
    ```

  * **Line # 118 - convention:** Metrics/CyclomaticComplexity: Cyclomatic complexity for validate_response is too high. [9/7]

    ```rb
        def validate_response ...
    ```

  * **Line # 118 - convention:** Metrics/MethodLength: Method has too many lines. [19/10]

    ```rb
        def validate_response ...
    ```

  * **Line # 118 - convention:** Metrics/PerceivedComplexity: Perceived complexity for validate_response is too high. [9/8]

    ```rb
        def validate_response ...
    ```

  * **Line # 135 - convention:** Performance/CollectionLiteralInLoop: Avoid immutable Array literals in loops. It is better to extract it into a local variable or a constant.

    ```rb
            ["", "-", ".", "_"].each do |separator|
    ```

  * **Line # 136 - convention:** Performance/CollectionLiteralInLoop: Avoid immutable Array literals in loops. It is better to extract it into a local variable or a constant.

    ```rb
              ["", "msg", "message", "spec", "code"].each do |spec|
    ```

  * **Line # 155 - convention:** Metrics/MethodLength: Method has too many lines. [14/10]

    ```rb
        def create_http_request ...
    ```

### app/interactions/nexi/create_reservation_payment.rb - (4 offenses)
  * **Line # 18 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<1, 29, 4> 29.29/17]

    ```rb
        def execute ...
    ```

  * **Line # 18 - convention:** Metrics/MethodLength: Method has too many lines. [16/10]

    ```rb
        def execute ...
    ```

  * **Line # 54 - convention:** Metrics/AbcSize: Assignment Branch Condition size for create_payment is too high. [<1, 17, 2> 17.15/17]

    ```rb
        def create_payment ...
    ```

  * **Line # 54 - convention:** Metrics/MethodLength: Method has too many lines. [13/10]

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

  * **Line # 7 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<0, 39, 4> 39.2/17]

    ```rb
        def execute ...
    ```

  * **Line # 7 - convention:** Metrics/MethodLength: Method has too many lines. [15/10]

    ```rb
        def execute ...
    ```

  * **Line # 29 - convention:** Layout/LineLength: Line is too long. [134/120]

    ```rb
          Rails.logger.warn "Nexi::ReceiveOrderOutcome: Don't know what to do with params: #{params.inspect}, headers: #{headers.inspect}"
    ```

### app/interactions/nexi/record_deferred_payment.rb - (6 offenses)
  * **Line # 32 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<1, 25, 3> 25.2/17]

    ```rb
        def execute ...
    ```

  * **Line # 32 - convention:** Metrics/MethodLength: Method has too many lines. [12/10]

    ```rb
        def execute ...
    ```

  * **Line # 40 - convention:** Layout/LineLength: Line is too long. [175/120]

    ```rb
            mac_part: "apiKey=#{params[:apiKey]}codiceTransazione=#{params[:codiceTransazione]}divisa=#{params[:divisa]}importo=#{params[:importo]}timeStamp=#{params[:timeStamp]}"
    ```

  * **Line # 62 - convention:** Metrics/AbcSize: Assignment Branch Condition size for validate_response is too high. [<1, 39, 8> 39.82/17]

    ```rb
        def validate_response ...
    ```

  * **Line # 62 - convention:** Metrics/CyclomaticComplexity: Cyclomatic complexity for validate_response is too high. [8/7]

    ```rb
        def validate_response ...
    ```

  * **Line # 67 - convention:** Performance/Casecmp: Use `!client.json["esito"].to_s.casecmp("ok").zero?` instead of `client.json["esito"].to_s.downcase != "ok"`.

    ```rb
          if client.json.is_a?(Hash) && client.json["esito"].to_s.downcase != "ok"
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

### app/interactions/nexi/simple_payment.rb - (8 offenses)
  * **Line # 4 - convention:** Style/Documentation: Missing top-level documentation comment for `class Nexi::SimplePayment`.

    ```rb
      class SimplePayment < ActiveInteraction::Base
    ```

  * **Line # 22 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<1, 22, 3> 22.23/17]

    ```rb
        def execute ...
    ```

  * **Line # 22 - convention:** Metrics/MethodLength: Method has too many lines. [11/10]

    ```rb
        def execute ...
    ```

  * **Line # 54 - convention:** Layout/LineLength: Line is too long. [130/120]

    ```rb
            # Il campo identifica la modalità di incasso che l'esercente vuole applicare alla singola transazione, se valorizzato con:
    ```

  * **Line # 55 - convention:** Layout/LineLength: Line is too long. [191/120]

    ```rb
            # - C (immediata) la transazione se autorizzata viene anche incassata senza altri interventi da parte dell'esercente e senza considerare il profilo di default impostato sul terminale.
    ```

  * **Line # 56 - convention:** Layout/LineLength: Line is too long. [151/120]

    ```rb
            # - D (differita) o non viene inserito il campo, la transazione se autorizzata viene gestita secondo quanto definito dal profilo del terminale.
    ```

  * **Line # 57 - convention:** Layout/LineLength: Line is too long. [360/120]

    ```rb
            # L'incasso immediato è quello stabilito come standard da Nexi. Se vuoi gestire incassi differiti richiedi al supporto tecnico l'abilitazione. Una volta abilitato, in caso di incasso differito la riscossione è in carico all'esercente che può gestirla da back office, tramite API o a scadenza automatica comunicata in fase di configurazione del profilo.
    ```

  * **Line # 62 - convention:** Metrics/AbcSize: Assignment Branch Condition size for validate_response is too high. [<1, 20, 5> 20.64/17]

    ```rb
        def validate_response ...
    ```

### app/interactions/profile/change_email.rb - (1 offense)
  * **Line # 25 - convention:** Layout/LineLength: Line is too long. [122/120]

    ```rb
          # user.events << User::Event.new(event_type: :email_changed, data: { old_email: @old_email, new_email: user.email })
    ```

### app/interactions/public_cancel_reservation.rb - (1 offense)
  * **Line # 14 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<0, 21, 3> 21.21/17]

    ```rb
      def execute ...
    ```

### app/interactions/public_create_reservation.rb - (12 offenses)
  * **Line # 3 - convention:** Metrics/ClassLength: Class has too many lines. [240/100]

    ```rb
    class PublicCreateReservation < ActiveInteraction::Base ...
    ```

  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class PublicCreateReservation`.

    ```rb
    class PublicCreateReservation < ActiveInteraction::Base
    ```

  * **Line # 38 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<1, 38, 9> 39.06/17]

    ```rb
      def execute ...
    ```

  * **Line # 38 - convention:** Metrics/CyclomaticComplexity: Cyclomatic complexity for execute is too high. [9/7]

    ```rb
      def execute ...
    ```

  * **Line # 38 - convention:** Metrics/MethodLength: Method has too many lines. [17/10]

    ```rb
      def execute ...
    ```

  * **Line # 38 - convention:** Metrics/PerceivedComplexity: Perceived complexity for execute is too high. [10/8]

    ```rb
      def execute ...
    ```

  * **Line # 132 - convention:** Metrics/MethodLength: Method has too many lines. [15/10]

    ```rb
      def initialize_reservation ...
    ```

  * **Line # 166 - convention:** Metrics/AbcSize: Assignment Branch Condition size for create_reservation_payment_if_needed is too high. [<4, 30, 8> 31.3/17]

    ```rb
      def create_reservation_payment_if_needed ...
    ```

  * **Line # 166 - convention:** Metrics/MethodLength: Method has too many lines. [23/10]

    ```rb
      def create_reservation_payment_if_needed ...
    ```

  * **Line # 182 - convention:** Style/NumericPredicate: Use `call.result.negative?` instead of `call.result < 0`.

    ```rb
          if call.valid? && call.result < 0
    ```

  * **Line # 282 - convention:** Metrics/AbcSize: Assignment Branch Condition size for datetime_format_is_valid is too high. [<0, 17, 3> 17.26/17]

    ```rb
      def datetime_format_is_valid ...
    ```

  * **Line # 334 - convention:** Style/NumericPredicate: Use `(datetime.to_i % reservation_turn.step).zero?` instead of `datetime.to_i % reservation_turn.step == 0`.

    ```rb
        return if datetime.to_i % reservation_turn.step == 0
    ```

### app/interactions/record_deferred_payment.rb - (5 offenses)
  * **Line # 17 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<1, 45, 9> 45.9/17]

    ```rb
      def execute ...
    ```

  * **Line # 17 - convention:** Metrics/CyclomaticComplexity: Cyclomatic complexity for execute is too high. [10/7]

    ```rb
      def execute ...
    ```

  * **Line # 17 - convention:** Metrics/MethodLength: Method has too many lines. [15/10]

    ```rb
      def execute ...
    ```

  * **Line # 17 - convention:** Metrics/PerceivedComplexity: Perceived complexity for execute is too high. [10/8]

    ```rb
      def execute ...
    ```

  * **Line # 27 - convention:** Rails/SkipsModelValidations: Avoid using `touch` because it skips validations.

    ```rb
        reservation.touch
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

### app/interactions/reservation_ics.rb - (3 offenses)
  * **Line # 7 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<12, 35, 2> 37.05/17]

    ```rb
      def execute ...
    ```

  * **Line # 7 - convention:** Metrics/MethodLength: Method has too many lines. [17/10]

    ```rb
      def execute ...
    ```

  * **Line # 18 - convention:** Layout/LineLength: Line is too long. [124/120]

    ```rb
          e.attendee = ["mailto:#{organization_email}", "mailto:#{reservation.email}"] # one or more email recipients (required)
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

### app/interactions/search_reservations.rb - (25 offenses)
  * **Line # 3 - convention:** Metrics/ClassLength: Class has too many lines. [180/100]

    ```rb
    class SearchReservations < ActiveInteraction::Base ...
    ```

  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class SearchReservations`.

    ```rb
    class SearchReservations < ActiveInteraction::Base
    ```

  * **Line # 17 - convention:** Metrics/MethodLength: Method has too many lines. [23/10]

    ```rb
      def execute ...
    ```

  * **Line # 49 - convention:** Style/NumericPredicate: Use `exact.count.positive?` instead of `exact.count > 0`.

    ```rb
        return items.where(id: exact.select(:reservation_id)) if exact.count > 0
    ```

  * **Line # 58 - convention:** Layout/LineLength: Line is too long. [124/120]

    ```rb
        items.where(id: ReservationPayment.where(preorder_type: params[:preorder_type].to_s.split(",")).select(:reservation_id))
    ```

  * **Line # 69 - convention:** Metrics/AbcSize: Assignment Branch Condition size for filter_by_table_types is too high. [<1, 25, 8> 26.27/17]

    ```rb
      def filter_by_table_types(items) ...
    ```

  * **Line # 69 - convention:** Metrics/CyclomaticComplexity: Cyclomatic complexity for filter_by_table_types is too high. [9/7]

    ```rb
      def filter_by_table_types(items) ...
    ```

  * **Line # 69 - convention:** Metrics/PerceivedComplexity: Perceived complexity for filter_by_table_types is too high. [9/8]

    ```rb
      def filter_by_table_types(items) ...
    ```

  * **Line # 91 - convention:** Metrics/AbcSize: Assignment Branch Condition size for filter_by_people is too high. [<9, 54, 9> 55.48/17]

    ```rb
      def filter_by_people(items) ...
    ```

  * **Line # 91 - convention:** Metrics/CyclomaticComplexity: Cyclomatic complexity for filter_by_people is too high. [10/7]

    ```rb
      def filter_by_people(items) ...
    ```

  * **Line # 91 - convention:** Metrics/PerceivedComplexity: Perceived complexity for filter_by_people is too high. [10/8]

    ```rb
      def filter_by_people(items) ...
    ```

  * **Line # 108 - convention:** Metrics/AbcSize: Assignment Branch Condition size for order is too high. [<10, 43, 23> 49.78/17]

    ```rb
      def order(items) ...
    ```

  * **Line # 108 - convention:** Metrics/CyclomaticComplexity: Cyclomatic complexity for order is too high. [23/7]

    ```rb
      def order(items) ...
    ```

  * **Line # 108 - convention:** Metrics/MethodLength: Method has too many lines. [25/10]

    ```rb
      def order(items) ...
    ```

  * **Line # 108 - convention:** Metrics/PerceivedComplexity: Perceived complexity for order is too high. [23/8]

    ```rb
      def order(items) ...
    ```

  * **Line # 128 - convention:** Style/RedundantArgument: Argument " " is redundant because it is implied by default.

    ```rb
        if order_by.is_a?(String) && order_by.present? && items.column_names.include?(order_by.split(" ").first)
    ```

  * **Line # 138 - convention:** Performance/Casecmp: Use `direction.to_s.casecmp("desc").zero?` instead of `direction.to_s.downcase == "desc"`.

    ```rb
            return items.order(attribute => direction.to_s.downcase == "desc" ? :desc : :asc)
    ```

  * **Line # 150 - convention:** Metrics/AbcSize: Assignment Branch Condition size for filter_by_time is too high. [<2, 20, 5> 20.71/17]

    ```rb
      def filter_by_time(items) ...
    ```

  * **Line # 150 - convention:** Metrics/MethodLength: Method has too many lines. [17/10]

    ```rb
      def filter_by_time(items) ...
    ```

  * **Line # 198 - convention:** Metrics/AbcSize: Assignment Branch Condition size for datetime_range is too high. [<7, 32, 6> 33.3/17]

    ```rb
      def datetime_range(options = params) ...
    ```

  * **Line # 198 - convention:** Metrics/MethodLength: Method has too many lines. [12/10]

    ```rb
      def datetime_range(options = params) ...
    ```

  * **Line # 218 - convention:** Naming/PredicateName: Rename `is_true?` to `true?`.

    ```rb
      def is_true?(value)
    ```

  * **Line # 236 - convention:** Layout/LineLength: Line is too long. [253/120]

    ```rb
          "lower(#{Reservation.table_name}.fullname) ILIKE ? OR lower(#{Reservation.table_name}.notes) ILIKE ? or lower(#{Reservation.table_name}.email) ILIKE ?", "%#{params[:query].downcase}%", "%#{params[:query].downcase}%", "%#{params[:query].downcase}%"
    ```

  * **Line # 241 - convention:** Performance/MapMethodChain: Use `map { |x| x.downcase.strip }` instead of `map` method chain.

    ```rb
        statuses = status_params.map(&:downcase).map(&:strip).uniq.filter { |status| Reservation.statuses.key?(status) }
    ```

  * **Line # 249 - convention:** Metrics/AbcSize: Assignment Branch Condition size for status_params is too high. [<0, 24, 4> 24.33/17]

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

  * **Line # 38 - convention:** Style/ReturnNilInPredicateMethodDefinition: Return `false` instead of `nil` in predicate methods.

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

### app/interactions/stats/reservations_count.rb - (6 offenses)
  * **Line # 12 - convention:** Metrics/AbcSize: Assignment Branch Condition size for calc_stats is too high. [<0, 24, 0> 24/17]

    ```rb
        def calc_stats ...
    ```

  * **Line # 12 - convention:** Metrics/MethodLength: Method has too many lines. [12/10]

    ```rb
        def calc_stats ...
    ```

  * **Line # 70 - convention:** Layout/LineLength: Line is too long. [136/120]

    ```rb
            reservations.select("SUM(adults + children), to_char(datetime, #{format}) as time").group("to_char(datetime, #{format})").to_sql
    ```

  * **Line # 80 - convention:** Layout/LineLength: Line is too long. [127/120]

    ```rb
          @reservations ||= Reservation.where(id: SearchReservations.run!(params: search_params).visible.not_cancelled.select(:id))
    ```

  * **Line # 88 - convention:** Style/MultilineBlockChain: Avoid multi-line chains of blocks.

    ```rb
                           end.map do |key|
    ```

  * **Line # 88 - convention:** Style/MapToHash: Pass a block to `to_h` instead of calling `map.to_h`.

    ```rb
                           end.map do |key|
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

### app/interactions/update_preorder_group.rb - (10 offenses)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class UpdatePreorderGroup`.

    ```rb
    class UpdatePreorderGroup < ActiveInteraction::Base
    ```

  * **Line # 29 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<0, 22, 6> 22.8/17]

    ```rb
      def execute ...
    ```

  * **Line # 44 - convention:** Metrics/AbcSize: Assignment Branch Condition size for update_group is too high. [<2, 24, 3> 24.27/17]

    ```rb
      def update_group ...
    ```

  * **Line # 44 - convention:** Metrics/MethodLength: Method has too many lines. [11/10]

    ```rb
      def update_group ...
    ```

  * **Line # 64 - convention:** Style/PreferredHashMethods: Use `Hash#key?` instead of `Hash#has_key?`.

    ```rb
        return [] unless params.has_key?(:dates)
    ```

  * **Line # 74 - convention:** Metrics/AbcSize: Assignment Branch Condition size for update_turns is too high. [<4, 17, 5> 18.17/17]

    ```rb
      def update_turns ...
    ```

  * **Line # 75 - convention:** Style/PreferredHashMethods: Use `Hash#key?` instead of `Hash#has_key?`.

    ```rb
        return true unless params.has_key?(:turns)
    ```

  * **Line # 102 - convention:** Metrics/AbcSize: Assignment Branch Condition size for initialize_table_types is too high. [<3, 22, 4> 22.56/17]

    ```rb
      def initialize_table_types ...
    ```

  * **Line # 102 - convention:** Metrics/MethodLength: Method has too many lines. [14/10]

    ```rb
      def initialize_table_types ...
    ```

  * **Line # 103 - convention:** Style/PreferredHashMethods: Use `Hash#key?` instead of `Hash#has_key?`.

    ```rb
        return [] unless params.has_key?(:table_types)
    ```

### app/interactions/valid_dates_for_reservation.rb - (6 offenses)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class ValidDatesForReservation`.

    ```rb
    class ValidDatesForReservation < ActiveInteraction::Base
    ```

  * **Line # 6 - convention:** Metrics/AbcSize: Assignment Branch Condition size for execute is too high. [<10, 60, 11> 61.81/17]

    ```rb
      def execute ...
    ```

  * **Line # 6 - convention:** Metrics/CyclomaticComplexity: Cyclomatic complexity for execute is too high. [9/7]

    ```rb
      def execute ...
    ```

  * **Line # 6 - convention:** Metrics/MethodLength: Method has too many lines. [16/10]

    ```rb
      def execute ...
    ```

  * **Line # 6 - convention:** Metrics/PerceivedComplexity: Perceived complexity for execute is too high. [9/8]

    ```rb
      def execute ...
    ```

  * **Line # 13 - convention:** Layout/LineLength: Line is too long. [188/120]

    ```rb
        if Setting.where(key: :reservation_max_days_in_advance).first.present? && (to_date > Time.zone.now.to_date + Setting.where(key: :reservation_max_days_in_advance).first.value.to_i.days)
    ```

### app/interactions/valid_times_group_by_turn.rb - (4 offenses)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class ValidTimesGroupByTurn`.

    ```rb
    class ValidTimesGroupByTurn < ActiveInteraction::Base
    ```

  * **Line # 61 - convention:** Metrics/AbcSize: Assignment Branch Condition size for group_json is too high. [<4, 27, 7> 28.18/17]

    ```rb
      def group_json(turn) ...
    ```

  * **Line # 61 - convention:** Metrics/MethodLength: Method has too many lines. [24/10]

    ```rb
      def group_json(turn) ...
    ```

  * **Line # 66 - convention:** Layout/LineLength: Line is too long. [160/120]

    ```rb
                                                                                                              :text_translations, { images: [:attached_image_blob] }
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

### app/mailers/reservation_mailer.rb - (2 offenses)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class ReservationMailer`.

    ```rb
    class ReservationMailer < ApplicationMailer
    ```

  * **Line # 10 - convention:** Layout/LineLength: Line is too long. [122/120]

    ```rb
      # In case a payment is required, we won't send confirmation immediately; it will be sent after the payment is confirmed.
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

### app/models/holiday.rb - (4 offenses)
  * **Line # 17 - convention:** Layout/LineLength: Line is too long. [127/120]

    ```rb
    # So, if one of `weekly_from`, `weekly_to` and `weekday` is specified, all are required. If none is specified, they can be nil.
    ```

  * **Line # 54 - convention:** Layout/LineLength: Line is too long. [139/120]

    ```rb
        base = visible.active_at_date(time.to_date).where("from_timestamp <= :time AND (to_timestamp IS NULL OR to_timestamp >= :time)", time:)
    ```

  * **Line # 56 - convention:** Layout/LineLength: Line is too long. [136/120]

    ```rb
          base.where("weekly_from <= :hour AND weekly_to >= :hour AND weekday = :weekday", hour: time.strftime("%k:%M"), weekday: time.wday)
    ```

  * **Line # 63 - convention:** Layout/LineLength: Line is too long. [128/120]

    ```rb
        base = visible.where("from_timestamp::date <= :date AND (to_timestamp::date IS NULL OR to_timestamp::date >= :date)", date:)
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

  * **Line # 142 - convention:** Naming/PredicateName: Rename `has_original?` to `original?`.

    ```rb
      def has_original?
    ```

  * **Line # 168 - convention:** Naming/PredicateName: Rename `is_original?` to `original?`.

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

### app/models/menu/category.rb - (18 offenses)
  * **Line # 4 - convention:** Metrics/ClassLength: Class has too many lines. [215/100]

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

  * **Line # 29 - convention:** Rails/HasManyOrHasOneDependent: Specify a `:dependent` option.

    ```rb
        has_many :visible_children, -> { visible }, class_name: "Menu::Category", foreign_key: :parent_id
    ```

  * **Line # 29 - convention:** Rails/InverseOf: Specify an `:inverse_of` option.

    ```rb
        has_many :visible_children, -> { visible }, class_name: "Menu::Category", foreign_key: :parent_id
    ```

  * **Line # 31 - convention:** Rails/HasManyOrHasOneDependent: Specify a `:dependent` option.

    ```rb
        has_many :menu_dishes_in_categories, class_name: "Menu::DishesInCategory", foreign_key: :menu_category_id
    ```

  * **Line # 31 - convention:** Rails/InverseOf: Specify an `:inverse_of` option.

    ```rb
        has_many :menu_dishes_in_categories, class_name: "Menu::DishesInCategory", foreign_key: :menu_category_id
    ```

  * **Line # 39 - convention:** Layout/LineLength: Line is too long. [121/120]

    ```rb
                                       }, through: :menu_dishes_in_categories, class_name: "Menu::Dish", dependent: :destroy,
    ```

  * **Line # 46 - convention:** Rails/UniqueValidationWithoutIndex: Uniqueness validation should have a unique index on the database column.

    ```rb
        validates :secret, presence: true, length: { minimum: SECRET_MIN_LENGTH }, uniqueness: { case_sensitive: false }, ...
    ```

  * **Line # 140 - convention:** Rails/Blank: Use `if query.blank?` instead of `unless query.present?`.

    ```rb
            return all unless query.present?
    ```

  * **Line # 142 - convention:** Layout/LineLength: Line is too long. [130/120]

    ```rb
            where(id: ransack(name_cont: query).result.select(:id)).or(where(id: ransack(description_cont: query).result.select(:id)))
    ```

  * **Line # 203 - convention:** Rails/Blank: Use `if Category.where(parent_id:, index:).blank?` instead of `unless Category.where(parent_id:, index:).present?`.

    ```rb
          return unless Category.where(parent_id:, index:).present?
    ```

  * **Line # 216 - convention:** Naming/PredicateName: Rename `has_children?` to `children?`.

    ```rb
        def has_children?
    ```

  * **Line # 226 - convention:** Metrics/AbcSize: Assignment Branch Condition size for move is too high. [<8, 36, 11> 38.48/17]

    ```rb
        def move(to_index) ...
    ```

  * **Line # 226 - convention:** Metrics/MethodLength: Method has too many lines. [14/10]

    ```rb
        def move(to_index) ...
    ```

  * **Line # 234 - convention:** Rails/SkipsModelValidations: Avoid using `update_all` because it skips validations.

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

### app/models/menu/dishes_in_category.rb - (1 offense)
  * **Line # 36 - convention:** Metrics/AbcSize: Assignment Branch Condition size for assign_valid_index is too high. [<3, 22, 5> 22.76/17]

    ```rb
        def assign_valid_index ...
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

  * **Line # 49 - convention:** Layout/LineLength: Line is too long. [133/120]

    ```rb
                                                                      PAYMENT_VALUE_MANDATORY_PREORDER_TYPES.include?(preorder_type.to_s)
    ```

  * **Line # 68 - convention:** Rails/InverseOf: Specify an `:inverse_of` option.

    ```rb
      has_many :dates, class_name: "PreorderReservationDate", foreign_key: :group_id, dependent: :destroy
    ```

  * **Line # 74 - convention:** Layout/LineLength: Line is too long. [151/120]

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

### app/models/reservation.rb - (7 offenses)
  * **Line # 3 - convention:** Metrics/ClassLength: Class has too many lines. [106/100]

    ```rb
    class Reservation < ApplicationRecord ...
    ```

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

  * **Line # 57 - convention:** Rails/UniqueValidationWithoutIndex: Uniqueness validation should have a unique index on the database column.

    ```rb
      validates :secret, uniqueness: { case_sensitive: false }
    ```

  * **Line # 79 - convention:** Layout/LineLength: Line is too long. [166/120]

    ```rb
        ch = Log::ModelChange.select(:record_id, :created_at).where(record_type: "Reservation", change_type: "update").where("record_changes->'status'->>1 = 'cancelled'")
    ```

  * **Line # 80 - convention:** Layout/LineLength: Line is too long. [126/120]

    ```rb
        select("reservations.*, ch.created_at as cancelled_at").joins("LEFT OUTER JOIN (#{ch.to_sql}) as ch ON ch.record_id = id")
    ```

### app/models/reservation_payment.rb - (1 offense)
  * **Line # 13 - convention:** Layout/LineLength: Line is too long. [129/120]

    ```rb
      # Initially "paid" was used for "authorized" too. Then we needed to distinguish when a payment was authorized but not yet paid,
    ```

### app/models/reservation_tag.rb - (1 offense)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class ReservationTag`.

    ```rb
    class ReservationTag < ApplicationRecord
    ```

### app/models/reservation_turn.rb - (17 offenses)
  * **Line # 5 - convention:** Metrics/ClassLength: Class has too many lines. [107/100]

    ```rb
    class ReservationTurn < ApplicationRecord ...
    ```

  * **Line # 62 - convention:** Metrics/AbcSize: Assignment Branch Condition size for preorder_reservation_groups is too high. [<4, 19, 4> 19.82/17]

    ```rb
      def preorder_reservation_groups(date: nil, people: nil) ...
    ```

  * **Line # 62 - convention:** Metrics/MethodLength: Method has too many lines. [28/10]

    ```rb
      def preorder_reservation_groups(date: nil, people: nil) ...
    ```

  * **Line # 69 - convention:** Style/ConditionalAssignment: Use the return of the conditional for variable assignment and comparison.

    ```rb
        if date.present? ...
    ```

  * **Line # 70 - convention:** Layout/IndentationWidth: Use 2 (not -6) spaces for indentation.

    ```rb
          dates.where(date: date)
    ```

  * **Line # 70 - convention:** Style/HashSyntax: Omit the hash value.

    ```rb
          dates.where(date: date)
    ```

  * **Line # 70 - convention:** Style/HashSyntax: Omit the hash value.

    ```rb
          dates = dates.where(date: date)
    ```

  * **Line # 71 - convention:** Layout/ElseAlignment: Align `else` with `if`.

    ```rb
        else
    ```

  * **Line # 72 - convention:** Layout/IndentationWidth: Use 2 (not -6) spaces for indentation.

    ```rb
          dates.where("date >= ?", Time.zone.now.to_date)
    ```

  * **Line # 121 - convention:** Metrics/AbcSize: Assignment Branch Condition size for starts_at_overlaps_other_turn is too high. [<2, 17, 4> 17.58/17]

    ```rb
      def starts_at_overlaps_other_turn ...
    ```

  * **Line # 131 - convention:** Metrics/AbcSize: Assignment Branch Condition size for ends_at_overlaps_other_turn is too high. [<2, 17, 4> 17.58/17]

    ```rb
      def ends_at_overlaps_other_turn ...
    ```

  * **Line # 141 - convention:** Metrics/AbcSize: Assignment Branch Condition size for other_starts_at_overlaps is too high. [<2, 23, 5> 23.62/17]

    ```rb
      def other_starts_at_overlaps ...
    ```

  * **Line # 152 - convention:** Metrics/AbcSize: Assignment Branch Condition size for other_ends_at_overlaps is too high. [<2, 23, 5> 23.62/17]

    ```rb
      def other_ends_at_overlaps ...
    ```

  * **Line # 168 - convention:** Layout/LineLength: Line is too long. [179/120]

    ```rb
      #   overlapping = self.class.where('? BETWEEN starts_at AND ends_at', starts_at).where(weekday:).or(self.class.where(weekday:).where('? BETWEEN starts_at AND ends_at', ends_at))
    ```

  * **Line # 173 - convention:** Layout/LineLength: Line is too long. [156/120]

    ```rb
      #     but #{overlapping.map { |ot| "turn ##{ot.id} starts at #{ot.starts_at.strftime('%k:%M')} and ends at #{ot.ends_at.strftime('%k:%M')}" }.join(", ") }
    ```

  * **Line # 176 - convention:** Layout/LineLength: Line is too long. [134/120]

    ```rb
      #   errors.add(:starts_at, 'should not overlap with other turns' + full_message, overlapping: overlapping.pluck(:id), full_message:)
    ```

  * **Line # 177 - convention:** Layout/LineLength: Line is too long. [132/120]

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

### app/models/table_type.rb - (3 offenses)
  * **Line # 48 - convention:** Rails/Blank: Use `if query.blank?` instead of `unless query.present?`.

    ```rb
          return all unless query.present?
    ```

  * **Line # 54 - convention:** Rails/Blank: Use `if query.blank?` instead of `unless query.present?`.

    ```rb
          return all unless query.present?
    ```

  * **Line # 60 - convention:** Rails/Blank: Use `if query.blank?` instead of `unless query.present?`.

    ```rb
          return all unless query.present?
    ```

### app/models/table_type_to_preorder_reservation_group.rb - (1 offense)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class TableTypeToPreorderReservationGroup`.

    ```rb
    class TableTypeToPreorderReservationGroup < ApplicationRecord
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

### config/application.rb - (4 offenses)
  * **Line # 1 - convention:** Style/FrozenStringLiteralComment: Missing frozen string literal comment.

    ```rb
    require_relative "boot"
    ```

  * **Line # 10 - convention:** Style/Documentation: Missing top-level documentation comment for `class Lpda2::Application`.

    ```rb
      class Application < Rails::Application
    ```

  * **Line # 13 - convention:** Style/RegexpLiteral: Use `%r` around regular expression.

    ```rb
        config.action_cable.allowed_request_origins = [/http:\/\/*/, /https:\/\/*/]
    ```

  * **Line # 13 - convention:** Style/RegexpLiteral: Use `%r` around regular expression.

    ```rb
        config.action_cable.allowed_request_origins = [/http:\/\/*/, /https:\/\/*/]
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

### config/environments/development.rb - (2 offenses)
  * **Line # 1 - convention:** Style/FrozenStringLiteralComment: Missing frozen string literal comment.

    ```rb
    require "active_support/core_ext/integer/time"
    ```

  * **Line # 3 - convention:** Metrics/BlockLength: Block has too many lines. [30/25]

    ```rb
    Rails.application.configure do ...
    ```

### config/environments/production.rb - (2 offenses)
  * **Line # 1 - convention:** Style/FrozenStringLiteralComment: Missing frozen string literal comment.

    ```rb
    require "active_support/core_ext/integer/time"
    ```

  * **Line # 82 - convention:** Style/GlobalStdStream: Use `$stdout` instead of `STDOUT`.

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

### config/routes.rb - (6 offenses)
  * **Line # 6 - convention:** Metrics/BlockLength: Block has too many lines. [182/25]

    ```rb
    Rails.application.routes.draw do ...
    ```

  * **Line # 17 - convention:** Metrics/BlockLength: Block has too many lines. [170/25]

    ```rb
      defaults format: :json do ...
    ```

  * **Line # 26 - convention:** Metrics/BlockLength: Block has too many lines. [161/25]

    ```rb
        scope module: :v1, path: "v1" do ...
    ```

  * **Line # 96 - convention:** Metrics/BlockLength: Block has too many lines. [110/25]

    ```rb
          scope module: :admin, path: "admin" do ...
    ```

  * **Line # 157 - convention:** Metrics/BlockLength: Block has too many lines. [56/25]

    ```rb
            scope module: :menu, path: "menu" do ...
    ```

  * **Line # 193 - convention:** Metrics/BlockLength: Block has too many lines. [26/25]

    ```rb
              resources :dishes do ...
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

### db/migrate/20250212153521_add_member_id_to_reservations.rb - (2 offenses)
  * **Line # 1 - convention:** Style/Documentation: Missing top-level documentation comment for `class AddMemberIdToReservations`.

    ```rb
    class AddMemberIdToReservations < ActiveRecord::Migration[7.0]
    ```

  * **Line # 1 - convention:** Style/FrozenStringLiteralComment: Missing frozen string literal comment.

    ```rb
    class AddMemberIdToReservations < ActiveRecord::Migration[7.0]
    ```

### db/migrate/20250317074958_create_table_types.rb - (3 offenses)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class CreateTableTypes`.

    ```rb
    class CreateTableTypes < ActiveRecord::Migration[7.0]
    ```

  * **Line # 7 - convention:** Layout/LineLength: Line is too long. [194/120]

    ```rb
                    comment: %(Default number of people that can reserve a table of this type during a turn. Can be overwritten on the join table between table_types and preorder_reservation_groups)
    ```

  * **Line # 9 - convention:** Layout/LineLength: Line is too long. [159/120]

    ```rb
                  comment: %(Default price per person for the table type. Can be overwritten on the join table between table_types and preorder_reservation_groups)
    ```

### db/migrate/20250317090839_create_table_type_to_preorder_reservation_groups.rb - (2 offenses)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class CreateTableTypeToPreorderReservationGroups`.

    ```rb
    class CreateTableTypeToPreorderReservationGroups < ActiveRecord::Migration[7.0]
    ```

  * **Line # 9 - convention:** Layout/LineLength: Line is too long. [128/120]

    ```rb
                                                    index: { name: "index_table_type_to_prgroups_on_preorder_reservation_group_id" }
    ```

### db/migrate/20250318112104_add_table_type_to_reservations.rb - (1 offense)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class AddTableTypeToReservations`.

    ```rb
    class AddTableTypeToReservations < ActiveRecord::Migration[7.0]
    ```

### db/migrate/20250419001805_migrate_authorizations_from_paid_to_authorized.rb - (1 offense)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class MigrateAuthorizationsFromPaidToAuthorized`.

    ```rb
    class MigrateAuthorizationsFromPaidToAuthorized < ActiveRecord::Migration[7.0]
    ```

### db/migrate/20250428212025_add_min_people_to_preorder_reservation_group.rb - (5 offenses)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class AddMinPeopleToPreorderReservationGroup`.

    ```rb
    class AddMinPeopleToPreorderReservationGroup < ActiveRecord::Migration[7.0]
    ```

  * **Line # 5 - convention:** Layout/TrailingWhitespace: Trailing whitespace detected.

    ```rb
        add_column :preorder_reservation_groups, :min_people, :integer, 
    ```

  * **Line # 5 - convention:** Layout/LineLength: Line is too long. [210/120]

    ```rb
        add_column :preorder_reservation_groups, :min_people, :integer, comment: %(When creating a reservation and this value is set, payment will be required for reservations with more (>=) than this value people)
    ```

  * **Line # 6 - convention:** Layout/ArgumentAlignment: Align the arguments of a method call if they span more than one line.

    ```rb
    comment: %(When creating a reservation and this value is set, payment will be required for reservations with more (>=) than this value people)
    ```

  * **Line # 6 - convention:** Layout/LineLength: Line is too long. [157/120]

    ```rb
                   comment: %(When creating a reservation and this value is set, payment will be required for reservations with more (>=) than this value people)
    ```

### db/seeds.rb - (4 offenses)
  * **Line # 6 - convention:** Rails/Output: Do not write to stdout. Use Rails's logger if you want to log.

    ```rb
      puts message
    ```

  * **Line # 108 - convention:** Performance/CollectionLiteralInLoop: Avoid immutable Array literals in loops. It is better to extract it into a local variable or a constant.

    ```rb
        Reservation.create!(adults: [2, 2, 2, 3, 4, 5, 6, 7, 8, 9, 10].sample, fullname: Faker::Name.first_name,
    ```

  * **Line # 109 - convention:** Performance/CollectionLiteralInLoop: Avoid immutable Array literals in loops. It is better to extract it into a local variable or a constant.

    ```rb
                            email: "sasha+#{SecureRandom.hex}@opinioni.net", datetime: day_ago.days.ago.beginning_of_day + [10, 11, 12, 18, 19, 20].sample.hours)
    ```

  * **Line # 109 - convention:** Layout/LineLength: Line is too long. [157/120]

    ```rb
                            email: "sasha+#{SecureRandom.hex}@opinioni.net", datetime: day_ago.days.ago.beginning_of_day + [10, 11, 12, 18, 19, 20].sample.hours)
    ```

### lib/routes_basic_auth.rb - (6 offenses)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class RoutesBasicAuth`.

    ```rb
    class RoutesBasicAuth
    ```

  * **Line # 5 - convention:** Metrics/AbcSize: Assignment Branch Condition size for call is too high. [<2, 15, 8> 17.12/17]

    ```rb
        def call(klass, username:, password:) ...
    ```

  * **Line # 5 - convention:** Metrics/CyclomaticComplexity: Cyclomatic complexity for call is too high. [8/7]

    ```rb
        def call(klass, username:, password:) ...
    ```

  * **Line # 5 - convention:** Metrics/MethodLength: Method has too many lines. [15/10]

    ```rb
        def call(klass, username:, password:) ...
    ```

  * **Line # 5 - convention:** Metrics/PerceivedComplexity: Perceived complexity for call is too high. [9/8]

    ```rb
        def call(klass, username:, password:) ...
    ```

  * **Line # 15 - convention:** Rails/Output: Do not write to stdout. Use Rails's logger if you want to log.

    ```rb
              puts "No username or password provided. Basic auth is disabled for #{klass}."
    ```

### lib/sidekiq_admin_constraint.rb - (1 offense)
  * **Line # 3 - convention:** Style/Documentation: Missing top-level documentation comment for `class SidekiqAdminConstraint`.

    ```rb
    class SidekiqAdminConstraint
    ```

### lib/tasks/dbreboot.rake - (1 offense)
  * **Line # 5 - convention:** Rails/RakeEnvironment: Include `:environment` task as a dependency for all Rake tasks.

    ```rb
      task :reboot, [:seed] do |_, args|
    ```

### lib/tasks/import.rake - (4 offenses)
  * **Line # 6 - convention:** Rails/RakeEnvironment: Include `:environment` task as a dependency for all Rake tasks.

    ```rb
      task :all do
    ```

  * **Line # 10 - convention:** Rails/RakeEnvironment: Include `:environment` task as a dependency for all Rake tasks.

    ```rb
      task :images do
    ```

  * **Line # 14 - convention:** Rails/RakeEnvironment: Include `:environment` task as a dependency for all Rake tasks.

    ```rb
      task :menu do
    ```

  * **Line # 18 - convention:** Rails/RakeEnvironment: Include `:environment` task as a dependency for all Rake tasks.

    ```rb
      task :reservations do
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

### spec/controllers/v1/admin/menu/categories_controller_spec.rb - (479 offenses)
  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe V1::Admin::Menu::CategoriesController, type: :controller do
    ```

  * **Line # 76 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:items].size).to eq 10 }
    ```

  * **Line # 77 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:total_count]).to eq 30 }
    ```

  * **Line # 78 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:current_page]).to eq 1 }
    ```

  * **Line # 79 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:per_page]).to eq 10 }
    ```

  * **Line # 87 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:items].size).to eq 3 }
    ```

  * **Line # 88 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:total_count]).to eq 10 }
    ```

  * **Line # 89 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:current_page]).to eq 1 }
    ```

  * **Line # 90 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:per_page]).to eq 3 }
    ```

  * **Line # 98 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:items].size).to eq 3 }
    ```

  * **Line # 99 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:total_count]).to eq 10 }
    ```

  * **Line # 100 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:current_page]).to eq 2 }
    ```

  * **Line # 101 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:per_page]).to eq 3 }
    ```

  * **Line # 110 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              it { expect(@page1).to eq @offset0 }
    ```

  * **Line # 110 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              it { expect(@page1).to eq @offset0 }
    ```

  * **Line # 119 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:items].size).to eq 1 }
    ```

  * **Line # 120 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:total_count]).to eq 10 }
    ```

  * **Line # 121 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:current_page]).to eq 4 }
    ```

  * **Line # 122 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:per_page]).to eq 3 }
    ```

  * **Line # 130 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:items].size).to eq 0 }
    ```

  * **Line # 131 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:total_count]).to eq 10 }
    ```

  * **Line # 132 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:current_page]).to eq 10 }
    ```

  * **Line # 133 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:per_page]).to eq 3 }
    ```

  * **Line # 144 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              @items
    ```

  * **Line # 147 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.length).to eq 10 }
    ```

  * **Line # 148 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject).to all(be_a(Hash)) }
    ```

  * **Line # 149 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.pluck(:id).uniq.count).to eq 10 }
    ```

  * **Line # 168 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject).to be_a(Array) }
    ```

  * **Line # 169 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.count).to eq 2 }
    ```

  * **Line # 170 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject[0][:index]).to eq 0 }
    ```

  * **Line # 171 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject[1][:index]).to eq 1 }
    ```

  * **Line # 191 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject).to be_a(Array) }
    ```

  * **Line # 192 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.pluck(:id)).to eq Menu::Category.order(:index).pluck(:id) }
    ```

  * **Line # 202 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              req(except: @excluded.id)
    ```

  * **Line # 208 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.count).to eq 1 }
    ```

  * **Line # 209 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.pluck(:id).uniq.count).to eq 1 }
    ```

  * **Line # 210 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.first[:id]).to eq Menu::Category.last.id }
    ```

  * **Line # 228 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject).to be_a(Hash) }
    ```

  * **Line # 229 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(Menu::Category.find(subject[:id])).to be_a(Menu::Category) }
    ```

  * **Line # 236 - convention:** RSpec/ExampleLength: Example has too many lines. [6/5]

    ```rb
            it { ...
    ```

  * **Line # 237 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to include(
    ```

  * **Line # 245 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:images].count).to eq 2 }
    ```

  * **Line # 251 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              create_list(:menu_category, 2, visibility: nil, parent: @parent)
    ```

  * **Line # 262 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              before { req(parent_id: @parent.id) }
    ```

  * **Line # 267 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                it { expect(subject.count).to eq 2 }
    ```

  * **Line # 268 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                it { expect(subject.pluck(:id).uniq.count).to eq 2 }
    ```

  * **Line # 271 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                  expect(Menu::Category.where(id: subject.pluck(:id).uniq).pluck(:id)).to match_array(Menu::Category.where(parent: @parent).pluck(:id))
    ```

  * **Line # 271 - convention:** Layout/LineLength: Line is too long. [147/120]

    ```rb
                  expect(Menu::Category.where(id: subject.pluck(:id).uniq).pluck(:id)).to match_array(Menu::Category.where(parent: @parent).pluck(:id))
    ```

  * **Line # 271 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
                  expect(Menu::Category.where(id: subject.pluck(:id).uniq).pluck(:id)).to match_array(Menu::Category.where(parent: @parent).pluck(:id))
    ```

  * **Line # 278 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                it { expect(subject[:total_count]).to eq 2 }
    ```

  * **Line # 279 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                it { expect(subject[:current_page]).to eq 1 }
    ```

  * **Line # 280 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                it { expect(subject[:per_page]).to eq 10 }
    ```

  * **Line # 281 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                it { expect(subject[:params]).to be_a(Hash) }
    ```

  * **Line # 282 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                it { expect(subject[:params]).to include("parent_id" => @parent.id) }
    ```

  * **Line # 282 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
                it { expect(subject[:params]).to include("parent_id" => @parent.id) }
    ```

  * **Line # 292 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                it { expect(subject.count).to eq 3 }
    ```

  * **Line # 293 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                it { expect(subject.pluck(:id).uniq.count).to eq 3 }
    ```

  * **Line # 296 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                  expect(Menu::Category.where(id: subject.pluck(:id).uniq).pluck(:id)).to match_array(Menu::Category.where(parent_id: nil).pluck(:id))
    ```

  * **Line # 296 - convention:** Layout/LineLength: Line is too long. [146/120]

    ```rb
                  expect(Menu::Category.where(id: subject.pluck(:id).uniq).pluck(:id)).to match_array(Menu::Category.where(parent_id: nil).pluck(:id))
    ```

  * **Line # 303 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                it { expect(subject[:total_count]).to eq 3 }
    ```

  * **Line # 304 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                it { expect(subject[:current_page]).to eq 1 }
    ```

  * **Line # 305 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                it { expect(subject[:per_page]).to eq 10 }
    ```

  * **Line # 306 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                it { expect(subject[:params]).to be_a(Hash) }
    ```

  * **Line # 307 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                it { expect(subject[:params]).to include("parent_id" => "") }
    ```

  * **Line # 316 - convention:** Performance/CollectionLiteralInLoop: Avoid immutable Array literals in loops. It is better to extract it into a local variable or a constant.

    ```rb
                create(:menu_category, status: %i[active inactive].sample, name: "Category ##{i + 1}!!!",
    ```

  * **Line # 338 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.count).to eq 5 }
    ```

  * **Line # 339 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.pluck(:id).uniq.count).to eq 5 }
    ```

  * **Line # 348 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.count).to eq 5 }
    ```

  * **Line # 349 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.pluck(:id).uniq.count).to eq 5 }
    ```

  * **Line # 358 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.count).to eq 1 }
    ```

  * **Line # 359 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.pluck(:id).uniq.count).to eq 1 }
    ```

  * **Line # 360 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.first[:name]).to eq "Category #1!!!" }
    ```

  * **Line # 369 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.count).to eq 1 }
    ```

  * **Line # 370 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.pluck(:id).uniq.count).to eq 1 }
    ```

  * **Line # 371 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.first[:name]).to eq "Category #1!!!" }
    ```

  * **Line # 372 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.first[:description]).to eq "Description for #1!!!" }
    ```

  * **Line # 381 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.count).to eq 1 }
    ```

  * **Line # 382 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.pluck(:id).uniq.count).to eq 1 }
    ```

  * **Line # 383 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.first[:name]).to eq "Category #5!!!" }
    ```

  * **Line # 384 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.first[:description]).to eq "Description for #5!!!" }
    ```

  * **Line # 391 - convention:** Performance/TimesMap: Use `Array.new(5)` with a block instead of `.times.map`.

    ```rb
              5.times.map do |i| ...
    ```

  * **Line # 403 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
              it do
    ```

  * **Line # 404 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject.map(&:price).uniq).to contain_exactly(nil, 10, 20, 30, 40, 50)
    ```

  * **Line # 405 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject.map(&:price?)).to match_array(([false] * 5) + ([true] * 5))
    ```

  * **Line # 406 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject.count).to eq 10
    ```

  * **Line # 416 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                it { expect(subject.count).to eq 5 }
    ```

  * **Line # 417 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                it { expect(subject.pluck(:id).uniq.count).to eq 5 }
    ```

  * **Line # 418 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                it { expect(subject.pluck(:price).uniq).to all(be_positive) }
    ```

  * **Line # 419 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                it { expect(subject.pluck(:price).uniq).to all(be_a(Numeric)) }
    ```

  * **Line # 434 - convention:** Performance/TimesMap: Use `Array.new(5)` with a block instead of `.times.map`.

    ```rb
              5.times.map do |i| ...
    ```

  * **Line # 446 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
              it do
    ```

  * **Line # 447 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject.map(&:price).uniq).to contain_exactly(nil, 10, 20, 30, 40, 50)
    ```

  * **Line # 448 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject.map(&:price?)).to match_array(([false] * 5) + ([true] * 5))
    ```

  * **Line # 449 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject.count).to eq 10
    ```

  * **Line # 459 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                it { expect(subject.count).to eq 5 }
    ```

  * **Line # 460 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                it { expect(subject.pluck(:id).uniq.count).to eq 5 }
    ```

  * **Line # 461 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                it { expect(subject.pluck(:price).uniq).to eq [nil] }
    ```

  * **Line # 485 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                it { expect(subject.count).to eq 1 }
    ```

  * **Line # 486 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                it { expect(subject.pluck(:status)).to contain_exactly(filter_status) }
    ```

  * **Line # 505 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.pluck(:status)).to match_array(%w[active inactive]) }
    ```

  * **Line # 506 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.size).to eq 2 }
    ```

  * **Line # 518 - convention:** Style/MapToHash: Pass a block to `to_h` instead of calling `map.to_h`.

    ```rb
              json[:items].map do |item|
    ```

  * **Line # 575 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
            it { expect(public_visible_by_id[root_visible.id]).to eq true }
    ```

  * **Line # 576 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
            it { expect(public_visible_by_id[root_inactive.id]).to eq nil }
    ```

  * **Line # 577 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
            it { expect(public_visible_by_id[root_not_public.id]).to eq nil }
    ```

  * **Line # 578 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
            it { expect(public_visible_by_id[root_empty.id]).to eq nil }
    ```

  * **Line # 579 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
            it { expect(public_visible_by_id[not_root_inactive.id]).to eq nil }
    ```

  * **Line # 580 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
            it { expect(public_visible_by_id[not_root_active.id]).to eq true }
    ```

  * **Line # 581 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
            it { expect(public_visible_by_id[not_root_empty.id]).to eq nil }
    ```

  * **Line # 619 - convention:** RSpec/ExampleLength: Example has too many lines. [7/5]

    ```rb
            it { ...
    ```

  * **Line # 620 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to include(
    ```

  * **Line # 629 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:images].count).to eq 0 }
    ```

  * **Line # 642 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
            it do
    ```

  * **Line # 643 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to include(translations: Hash)
    ```

  * **Line # 644 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject[:translations]).to include(name: Hash)
    ```

  * **Line # 645 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject.dig(:translations, :name)).to include(en: "test-en")
    ```

  * **Line # 646 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject.dig(:translations, :name)).to include(it: "test-it")
    ```

  * **Line # 650 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [658]

    ```rb
          context "when passing a invalid id" do ...
    ```

  * **Line # 658 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [650]

    ```rb
          context "when passing a invalid id" do ...
    ```

  * **Line # 678 - convention:** RSpec/ExampleLength: Example has too many lines. [6/5]

    ```rb
            it { ...
    ```

  * **Line # 679 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to include(
    ```

  * **Line # 687 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:images].count).to eq 2 }
    ```

  * **Line # 704 - convention:** RSpec/ExampleLength: Example has too many lines. [7/5]

    ```rb
            it { ...
    ```

  * **Line # 705 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to include(
    ```

  * **Line # 737 - convention:** Rails/I18nLocaleAssignment: Use `I18n.with_locale` with block instead of `I18n.locale=`.

    ```rb
              I18n.locale = (I18n.available_locales - [I18n.default_locale]).sample
    ```

  * **Line # 743 - convention:** Rails/I18nLocaleAssignment: Use `I18n.with_locale` with block instead of `I18n.locale=`.

    ```rb
            after { I18n.locale = I18n.default_locale }
    ```

  * **Line # 786 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [794]

    ```rb
          context "when passing a invalid id" do ...
    ```

  * **Line # 794 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [786]

    ```rb
          context "when passing a invalid id" do ...
    ```

  * **Line # 807 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              create_list(:menu_category, 2, visibility: nil, parent: @grandparent)
    ```

  * **Line # 809 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              @parent = create(:menu_category, visibility: nil, parent: @grandparent)
    ```

  * **Line # 810 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              create_list(:menu_category, 2, visibility: nil, parent: @parent)
    ```

  * **Line # 812 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              @child = create(:menu_category, visibility: nil, parent: @parent)
    ```

  * **Line # 813 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              create_list(:menu_category, 2, visibility: nil, parent: @child)
    ```

  * **Line # 814 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              req(id: @child.id)
    ```

  * **Line # 818 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject).not_to include(message: String) }
    ```

  * **Line # 820 - convention:** RSpec/ExampleLength: Example has too many lines. [7/5]

    ```rb
            it do ...
    ```

  * **Line # 820 - convention:** RSpec/MultipleExpectations: Example has too many expectations [7/1].

    ```rb
            it do
    ```

  * **Line # 821 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to include(breadcrumbs: Array)
    ```

  * **Line # 822 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject[:breadcrumbs]).not_to be_empty
    ```

  * **Line # 823 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject[:breadcrumbs].count).to eq 3
    ```

  * **Line # 824 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject[:breadcrumbs].first).to be_a(Hash)
    ```

  * **Line # 825 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject[:breadcrumbs].last).to include(id: @child.id)
    ```

  * **Line # 825 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              expect(subject[:breadcrumbs].last).to include(id: @child.id)
    ```

  * **Line # 826 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject[:breadcrumbs].second).to include(id: @parent.id)
    ```

  * **Line # 826 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              expect(subject[:breadcrumbs].second).to include(id: @parent.id)
    ```

  * **Line # 827 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject[:breadcrumbs].first).to include(id: @grandparent.id)
    ```

  * **Line # 827 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              expect(subject[:breadcrumbs].first).to include(id: @grandparent.id)
    ```

  * **Line # 862 - convention:** RSpec/ExampleLength: Example has too many lines. [7/5]

    ```rb
            it { ...
    ```

  * **Line # 863 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to include(
    ```

  * **Line # 872 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:images].count).to eq 0 }
    ```

  * **Line # 883 - convention:** RSpec/MultipleExpectations: Example has too many expectations [5/1].

    ```rb
            it "request should create a category child" do
    ```

  * **Line # 884 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.to change(Menu::Category, :count).by(1)
    ```

  * **Line # 902 - convention:** RSpec/ExampleLength: Example has too many lines. [6/5]

    ```rb
              it { ...
    ```

  * **Line # 903 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject).to include(
    ```

  * **Line # 911 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject[:images].count).to eq 0 }
    ```

  * **Line # 923 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                subject
    ```

  * **Line # 928 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                subject
    ```

  * **Line # 932 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change { Menu::Category.visible.count }.by(1) }
    ```

  * **Line # 933 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change { Menu::Category.where(status: param_status).count }.by(1) }
    ```

  * **Line # 938 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject).to include(
    ```

  * **Line # 951 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
            it "request should create a category" do
    ```

  * **Line # 952 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.to change(Menu::Category, :count).by(1)
    ```

  * **Line # 969 - convention:** RSpec/ExampleLength: Example has too many lines. [6/5]

    ```rb
              it { ...
    ```

  * **Line # 970 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject).to include(
    ```

  * **Line # 978 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject[:images].count).to eq 0 }
    ```

  * **Line # 988 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
            it "request should create a category" do
    ```

  * **Line # 989 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.to change(Menu::Category, :count).by(1)
    ```

  * **Line # 1006 - convention:** RSpec/ExampleLength: Example has too many lines. [6/5]

    ```rb
              it { ...
    ```

  * **Line # 1007 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject).to include(
    ```

  * **Line # 1015 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject[:images].count).to eq 0 }
    ```

  * **Line # 1025 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
            it "request should create a category" do
    ```

  * **Line # 1026 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.to change(Menu::Category, :count).by(1)
    ```

  * **Line # 1043 - convention:** RSpec/ExampleLength: Example has too many lines. [6/5]

    ```rb
              it { ...
    ```

  * **Line # 1044 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject).to include(
    ```

  * **Line # 1052 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject[:images].count).to eq 0 }
    ```

  * **Line # 1064 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
            it "request should create a category" do
    ```

  * **Line # 1065 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.to change(Menu::Category, :count).by(1)
    ```

  * **Line # 1082 - convention:** RSpec/ExampleLength: Example has too many lines. [6/5]

    ```rb
              it { ...
    ```

  * **Line # 1083 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject).to include(
    ```

  * **Line # 1091 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject[:images].count).to eq 0 }
    ```

  * **Line # 1101 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
            it "request should create a category" do
    ```

  * **Line # 1102 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.to change(Menu::Category, :count).by(1)
    ```

  * **Line # 1119 - convention:** RSpec/ExampleLength: Example has too many lines. [6/5]

    ```rb
              it { ...
    ```

  * **Line # 1120 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject).to include(
    ```

  * **Line # 1128 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject[:images].count).to eq 0 }
    ```

  * **Line # 1138 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
            it "request should create a category" do
    ```

  * **Line # 1139 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.to change(Menu::Category, :count).by(1)
    ```

  * **Line # 1156 - convention:** RSpec/ExampleLength: Example has too many lines. [6/5]

    ```rb
              it { ...
    ```

  * **Line # 1157 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject).to include(
    ```

  * **Line # 1165 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject[:images].count).to eq 0 }
    ```

  * **Line # 1175 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 1176 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.not_to change(Menu::Category, :count)
    ```

  * **Line # 1261 - convention:** RSpec/ExampleLength: Example has too many lines. [7/5]

    ```rb
            it { ...
    ```

  * **Line # 1262 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to include(
    ```

  * **Line # 1338 - convention:** RSpec/ExampleLength: Example has too many lines. [7/5]

    ```rb
            it { ...
    ```

  * **Line # 1339 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to include(
    ```

  * **Line # 1361 - convention:** RSpec/ExampleLength: Example has too many lines. [7/5]

    ```rb
            it { ...
    ```

  * **Line # 1362 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to include(
    ```

  * **Line # 1380 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 1381 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              subject
    ```

  * **Line # 1387 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to include(price: 15.2)
    ```

  * **Line # 1390 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { category.reload.price }.to(15.2) }
    ```

  * **Line # 1405 - convention:** RSpec/ExampleLength: Example has too many lines. [7/5]

    ```rb
            it { ...
    ```

  * **Line # 1406 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to include(
    ```

  * **Line # 1428 - convention:** RSpec/ExampleLength: Example has too many lines. [7/5]

    ```rb
            it { ...
    ```

  * **Line # 1429 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to include(
    ```

  * **Line # 1451 - convention:** RSpec/ExampleLength: Example has too many lines. [7/5]

    ```rb
            it { ...
    ```

  * **Line # 1452 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to include(
    ```

  * **Line # 1466 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.name).to eq "Hello" }
    ```

  * **Line # 1467 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.name_it).to eq "Ciao" }
    ```

  * **Line # 1468 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.name_en).to eq "Hello" }
    ```

  * **Line # 1484 - convention:** RSpec/ExampleLength: Example has too many lines. [7/5]

    ```rb
            it { ...
    ```

  * **Line # 1485 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to include(
    ```

  * **Line # 1499 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.description).to eq "Hello" }
    ```

  * **Line # 1500 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.description_it).to eq "Ciao" }
    ```

  * **Line # 1501 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.description_en).to eq "Hello" }
    ```

  * **Line # 1514 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to change(Menu::Category, :count) }
    ```

  * **Line # 1515 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { category.reload.parent }.from(nil).to(parent) }
    ```

  * **Line # 1516 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { category.reload.visibility_id }.from(category.visibility_id).to(nil) }
    ```

  * **Line # 1528 - convention:** RSpec/ExampleLength: Example has too many lines. [7/5]

    ```rb
              it { ...
    ```

  * **Line # 1529 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject).to include(
    ```

  * **Line # 1544 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.parent).to eq parent }
    ```

  * **Line # 1557 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to change(Menu::Category, :count) }
    ```

  * **Line # 1558 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { category.reload.parent }.from(parent).to(nil) }
    ```

  * **Line # 1563 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              subject
    ```

  * **Line # 1575 - convention:** RSpec/ExampleLength: Example has too many lines. [7/5]

    ```rb
              it { ...
    ```

  * **Line # 1576 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject).to include(
    ```

  * **Line # 1591 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.parent).to eq nil }
    ```

  * **Line # 1591 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
              it { expect(subject.parent).to eq nil }
    ```

  * **Line # 1604 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 1605 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.not_to change(Menu::Category, :count)
    ```

  * **Line # 1671 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "checking mock data" do
    ```

  * **Line # 1672 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
              expect(category.secret_desc).to eq nil
    ```

  * **Line # 1673 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
              expect(category.description).to eq nil
    ```

  * **Line # 1766 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:name]).to eq nil }
    ```

  * **Line # 1766 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
            it { expect(subject[:name]).to eq nil }
    ```

  * **Line # 1773 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.name).to eq nil }
    ```

  * **Line # 1773 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
              it { expect(subject.name).to eq nil }
    ```

  * **Line # 1774 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.name_en).to eq nil }
    ```

  * **Line # 1774 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
              it { expect(subject.name_en).to eq nil }
    ```

  * **Line # 1775 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.name_it).to eq "test-it" }
    ```

  * **Line # 1832 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Menu::Category.visible.count }.by(-1) }
    ```

  * **Line # 1845 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
            before { allow_any_instance_of(Menu::Category).to receive(:deleted!).and_return(false) }
    ```

  * **Line # 1847 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Menu::Category.visible.count }) }
    ```

  * **Line # 1860 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
            before { allow_any_instance_of(Menu::Category).to receive(:deleted!).and_raise(ActiveRecord::RecordInvalid) }
    ```

  * **Line # 1862 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Menu::Category.visible.count }) }
    ```

  * **Line # 1909 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
            it { expect(category.visibility.public_visible).to eq false }
    ```

  * **Line # 1910 - convention:** RSpec/BeEq: Prefer `be` over `eq`.

    ```rb
            it { expect(category.visibility.private_visible).to eq false }
    ```

  * **Line # 1922 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to(change { category.reload.visibility.daily_from }) }
    ```

  * **Line # 1923 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to(change { category.reload.visibility.daily_to }) }
    ```

  * **Line # 1926 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              before { subject }
    ```

  * **Line # 1946 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to(change { category.reload.visibility.daily_from }) }
    ```

  * **Line # 1947 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { category.reload.visibility.daily_to }) }
    ```

  * **Line # 1958 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { category.reload.visibility.daily_from }) }
    ```

  * **Line # 1959 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to(change { category.reload.visibility.daily_to }) }
    ```

  * **Line # 1962 - convention:** Layout/LineLength: Line is too long. [156/120]

    ```rb
          context "when category was already public should not stop from updating any other field: should check if can publish only if publishing right now." do
    ```

  * **Line # 1970 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { category.reload.visibility.public_visible }) }
    ```

  * **Line # 1973 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.to change {
    ```

  * **Line # 1978 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "updates public_from and return 200" do
    ```

  * **Line # 1979 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to have_http_status(:ok)
    ```

  * **Line # 1980 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to be_successful
    ```

  * **Line # 1990 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "does not update public_visible to true" do
    ```

  * **Line # 1991 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.not_to(change { category.reload.visibility.public_visible })
    ```

  * **Line # 1992 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to have_http_status(:unprocessable_entity)
    ```

  * **Line # 1993 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).not_to be_successful
    ```

  * **Line # 1996 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 1997 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              subject
    ```

  * **Line # 2009 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "is able to update public_visible to true" do
    ```

  * **Line # 2010 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.to change { category.reload.visibility.public_visible }.from(false).to(true)
    ```

  * **Line # 2011 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to have_http_status(:ok)
    ```

  * **Line # 2012 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to be_successful
    ```

  * **Line # 2022 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "is able to update public_visible to true" do
    ```

  * **Line # 2023 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.to change { category.reload.visibility.public_visible }.from(false).to(true)
    ```

  * **Line # 2024 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to have_http_status(:ok)
    ```

  * **Line # 2025 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to be_successful
    ```

  * **Line # 2035 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "does not update public_visible to true" do
    ```

  * **Line # 2036 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.not_to(change { category.reload.visibility.public_visible })
    ```

  * **Line # 2037 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to have_http_status(:unprocessable_entity)
    ```

  * **Line # 2038 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).not_to be_successful
    ```

  * **Line # 2048 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "does not update public_visible to true" do
    ```

  * **Line # 2049 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.not_to(change { category.reload.visibility.public_visible })
    ```

  * **Line # 2050 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to have_http_status(:unprocessable_entity)
    ```

  * **Line # 2051 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).not_to be_successful
    ```

  * **Line # 2055 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [2068]

    ```rb
          context "when category hasnt any dish" do ...
    ```

  * **Line # 2061 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "updates private_visible to true" do
    ```

  * **Line # 2062 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.to change { category.reload.visibility.private_visible }.from(false).to(true)
    ```

  * **Line # 2063 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to have_http_status(:ok)
    ```

  * **Line # 2064 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to be_successful
    ```

  * **Line # 2068 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [2055]

    ```rb
          context "when category hasnt any dish" do ...
    ```

  * **Line # 2074 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "is not able to update private_visible or public_visible to true" do
    ```

  * **Line # 2075 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.not_to(change { category.reload.visibility.private_visible })
    ```

  * **Line # 2076 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to have_http_status(:unprocessable_entity)
    ```

  * **Line # 2077 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).not_to be_successful
    ```

  * **Line # 2088 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.to change {
    ```

  * **Line # 2094 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.to change {
    ```

  * **Line # 2099 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "is able to update public_from or private_to and return 200" do
    ```

  * **Line # 2100 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to have_http_status(:ok)
    ```

  * **Line # 2101 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to be_successful
    ```

  * **Line # 2105 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              before { subject }
    ```

  * **Line # 2117 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { category.reload.visibility.public_from }) }
    ```

  * **Line # 2119 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { category.reload.visibility.public_to }) }
    ```

  * **Line # 2121 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "is not able to update public_from or public_to and return 422" do
    ```

  * **Line # 2122 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to have_http_status(:unprocessable_entity)
    ```

  * **Line # 2123 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).not_to be_successful
    ```

  * **Line # 2127 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              before { subject }
    ```

  * **Line # 2139 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { category.reload.visibility.private_from }) }
    ```

  * **Line # 2141 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { category.reload.visibility.private_to }) }
    ```

  * **Line # 2143 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "is not able to update private_from or private_to and return 422" do
    ```

  * **Line # 2144 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to have_http_status(:unprocessable_entity)
    ```

  * **Line # 2145 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).not_to be_successful
    ```

  * **Line # 2149 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              before { subject }
    ```

  * **Line # 2161 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { category.reload.visibility.public_from }) }
    ```

  * **Line # 2163 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { category.reload.visibility.public_to }) }
    ```

  * **Line # 2165 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "is not able to update public_from or public_to and return 422" do
    ```

  * **Line # 2166 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to have_http_status(:unprocessable_entity)
    ```

  * **Line # 2167 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).not_to be_successful
    ```

  * **Line # 2171 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              before { subject }
    ```

  * **Line # 2183 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { category.reload.visibility.private_from }) }
    ```

  * **Line # 2185 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { category.reload.visibility.private_to }) }
    ```

  * **Line # 2187 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "is not able to update private_from or public_to and return 422" do
    ```

  * **Line # 2188 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).to have_http_status(:unprocessable_entity)
    ```

  * **Line # 2189 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject).not_to be_successful
    ```

  * **Line # 2193 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              before { subject }
    ```

  * **Line # 2206 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
              it "updates public_from correctly" do
    ```

  * **Line # 2207 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect { subject }.to change {
    ```

  * **Line # 2210 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject).to have_http_status(:ok)
    ```

  * **Line # 2211 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject).to be_successful
    ```

  * **Line # 2221 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
              it "updates public_to correctly" do
    ```

  * **Line # 2222 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect { subject }.to change {
    ```

  * **Line # 2225 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject).to have_http_status(:ok)
    ```

  * **Line # 2226 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject).to be_successful
    ```

  * **Line # 2236 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
              it "updates private_from correctly" do
    ```

  * **Line # 2237 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect { subject }.to change {
    ```

  * **Line # 2240 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject).to have_http_status(:ok)
    ```

  * **Line # 2241 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject).to be_successful
    ```

  * **Line # 2251 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
              it "updates private_to correctly" do
    ```

  * **Line # 2252 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect { subject }.to change {
    ```

  * **Line # 2255 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject).to have_http_status(:ok)
    ```

  * **Line # 2256 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject).to be_successful
    ```

  * **Line # 2272 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:post, "/v1/admin/menu/categories/22/dishes/55").to(format: :json, action: :add_dish,
    ```

  * **Line # 2273 - convention:** Layout/LineLength: Line is too long. [143/120]

    ```rb
                                                                                       controller: "v1/admin/menu/categories", id: 22, dish_id: 55)
    ```

  * **Line # 2292 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { category.reload.dishes.count }.by(1) }
    ```

  * **Line # 2293 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { Menu::DishesInCategory.count }.by(1) }
    ```

  * **Line # 2293 - convention:** RSpec/ExpectChange: Prefer `change(Menu::DishesInCategory, :count)`.

    ```rb
          it { expect { subject }.to change { Menu::DishesInCategory.count }.by(1) }
    ```

  * **Line # 2294 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { Menu::Dish.count }) }
    ```

  * **Line # 2294 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Dish, :count)`.

    ```rb
          it { expect { subject }.not_to(change { Menu::Dish.count }) }
    ```

  * **Line # 2295 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.not_to(change { Menu::Category.count }) }
    ```

  * **Line # 2295 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Category, :count)`.

    ```rb
          it { expect { subject }.not_to(change { Menu::Category.count }) }
    ```

  * **Line # 2301 - convention:** RSpec/ExpectChange: Prefer `change(Menu::DishesInCategory, :count)`.

    ```rb
            it { expect { req }.not_to(change { Menu::DishesInCategory.count }) }
    ```

  * **Line # 2344 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { category.reload.dishes.count }.by(1) }
    ```

  * **Line # 2345 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Menu::DishesInCategory.count }.by(1) }
    ```

  * **Line # 2345 - convention:** RSpec/ExpectChange: Prefer `change(Menu::DishesInCategory, :count)`.

    ```rb
            it { expect { subject }.to change { Menu::DishesInCategory.count }.by(1) }
    ```

  * **Line # 2346 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Menu::Dish.count }.by(1) }
    ```

  * **Line # 2346 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Dish, :count)`.

    ```rb
            it { expect { subject }.to change { Menu::Dish.count }.by(1) }
    ```

  * **Line # 2347 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Menu::Category.count }) }
    ```

  * **Line # 2347 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Category, :count)`.

    ```rb
            it { expect { subject }.not_to(change { Menu::Category.count }) }
    ```

  * **Line # 2350 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              before { subject }
    ```

  * **Line # 2360 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
                allow_any_instance_of(Menu::DishesInCategory).to receive(:valid?).and_return(false)
    ```

  * **Line # 2366 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { category.reload.dishes.count }) }
    ```

  * **Line # 2367 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { Menu::DishesInCategory.count }) }
    ```

  * **Line # 2367 - convention:** RSpec/ExpectChange: Prefer `change(Menu::DishesInCategory, :count)`.

    ```rb
              it { expect { subject }.not_to(change { Menu::DishesInCategory.count }) }
    ```

  * **Line # 2368 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { Menu::Dish.count }) }
    ```

  * **Line # 2368 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Dish, :count)`.

    ```rb
              it { expect { subject }.not_to(change { Menu::Dish.count }) }
    ```

  * **Line # 2377 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
        let!(:dish0) { create(:menu_dish).tap { |d| d.update!(name: "Dish0") } }
    ```

  * **Line # 2378 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
        let!(:dish1) { create(:menu_dish).tap { |d| d.update!(name: "Dish1") } }
    ```

  * **Line # 2379 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
        let!(:dish2) { create(:menu_dish).tap { |d| d.update!(name: "Dish2") } }
    ```

  * **Line # 2393 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:patch, "/v1/admin/menu/categories/22/order_dishes").to(format: :json, action: :order_dishes,
    ```

  * **Line # 2393 - convention:** Layout/LineLength: Line is too long. [124/120]

    ```rb
          expect(subject).to route(:patch, "/v1/admin/menu/categories/22/order_dishes").to(format: :json, action: :order_dishes,
    ```

  * **Line # 2394 - convention:** Layout/LineLength: Line is too long. [134/120]

    ```rb
                                                                                           controller: "v1/admin/menu/categories", id: 22)
    ```

  * **Line # 2415 - convention:** RSpec/ExampleLength: Example has too many lines. [9/5]

    ```rb
            it do ...
    ```

  * **Line # 2415 - convention:** RSpec/MultipleExpectations: Example has too many expectations [6/1].

    ```rb
            it do
    ```

  * **Line # 2428 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 2445 - convention:** RSpec/ExampleLength: Example has too many lines. [9/5]

    ```rb
            it do ...
    ```

  * **Line # 2445 - convention:** RSpec/MultipleExpectations: Example has too many expectations [6/1].

    ```rb
            it do
    ```

  * **Line # 2458 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 2478 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:delete, "/v1/admin/menu/categories/22/dishes/55").to(format: :json, action: :remove_dish,
    ```

  * **Line # 2478 - convention:** Layout/LineLength: Line is too long. [121/120]

    ```rb
          expect(subject).to route(:delete, "/v1/admin/menu/categories/22/dishes/55").to(format: :json, action: :remove_dish,
    ```

  * **Line # 2479 - convention:** Layout/LineLength: Line is too long. [145/120]

    ```rb
                                                                                         controller: "v1/admin/menu/categories", id: 22, dish_id: 55)
    ```

  * **Line # 2507 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { category.reload.dishes.count }.by(-1) }
    ```

  * **Line # 2508 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { Menu::DishesInCategory.count }.by(-1) }
    ```

  * **Line # 2508 - convention:** RSpec/ExpectChange: Prefer `change(Menu::DishesInCategory, :count)`.

    ```rb
          it { expect { subject }.to change { Menu::DishesInCategory.count }.by(-1) }
    ```

  * **Line # 2537 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:post, "/v1/admin/menu/categories/22/add_category/55").to(format: :json, action: :add_category,
    ```

  * **Line # 2537 - convention:** Layout/LineLength: Line is too long. [126/120]

    ```rb
          expect(subject).to route(:post, "/v1/admin/menu/categories/22/add_category/55").to(format: :json, action: :add_category,
    ```

  * **Line # 2538 - convention:** Layout/LineLength: Line is too long. [159/120]

    ```rb
                                                                                             controller: "v1/admin/menu/categories", id: 22, category_child_id: 55)
    ```

  * **Line # 2557 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { category.reload.children.count }.by(1) }
    ```

  * **Line # 2558 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { Menu::Category.count }.by(1) }
    ```

  * **Line # 2558 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Category, :count)`.

    ```rb
          it { expect { subject }.to change { Menu::Category.count }.by(1) }
    ```

  * **Line # 2602 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:post, "/v1/admin/menu/categories/22/copy").to(format: :json, action: :copy,
    ```

  * **Line # 2603 - convention:** Layout/LineLength: Line is too long. [125/120]

    ```rb
                                                                                  controller: "v1/admin/menu/categories", id: 22)
    ```

  * **Line # 2622 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect { subject }.to change { Menu::Category.count }.by(1) }
    ```

  * **Line # 2622 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Category, :count)`.

    ```rb
          it { expect { subject }.to change { Menu::Category.count }.by(1) }
    ```

  * **Line # 2625 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            subject
    ```

  * **Line # 2641 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change { Menu::Category.count }.by(1) }
    ```

  * **Line # 2641 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Category, :count)`.

    ```rb
              it { expect { subject }.to change { Menu::Category.count }.by(1) }
    ```

  * **Line # 2642 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { category.reload.parent }) }
    ```

  * **Line # 2643 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { category.reload.parent.children.count }) }
    ```

  * **Line # 2646 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                subject
    ```

  * **Line # 2650 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
              it "returns 200" do
    ```

  * **Line # 2651 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                subject
    ```

  * **Line # 2669 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change { Menu::Category.count }.by(1) }
    ```

  * **Line # 2669 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Category, :count)`.

    ```rb
              it { expect { subject }.to change { Menu::Category.count }.by(1) }
    ```

  * **Line # 2670 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { category.reload.parent }) }
    ```

  * **Line # 2671 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { category.reload.parent.children.count }) }
    ```

  * **Line # 2672 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change { parent.reload.children.count }.by(1) }
    ```

  * **Line # 2675 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                subject
    ```

  * **Line # 2679 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
              it "returns 200" do
    ```

  * **Line # 2680 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                subject
    ```

  * **Line # 2698 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 2698 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
            it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 2699 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { ImageToRecord.count }) }
    ```

  * **Line # 2699 - convention:** RSpec/ExpectChange: Prefer `change(ImageToRecord, :count)`.

    ```rb
            it { expect { subject }.not_to(change { ImageToRecord.count }) }
    ```

  * **Line # 2701 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 2702 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              subject
    ```

  * **Line # 2719 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 2719 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
            it { expect { subject }.not_to(change { Image.count }) }
    ```

  * **Line # 2720 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { category.reload.images.count }) }
    ```

  * **Line # 2721 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { ImageToRecord.count }.by(1) }
    ```

  * **Line # 2721 - convention:** RSpec/ExpectChange: Prefer `change(ImageToRecord, :count)`.

    ```rb
            it { expect { subject }.to change { ImageToRecord.count }.by(1) }
    ```

  * **Line # 2723 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 2724 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              subject
    ```

  * **Line # 2741 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Image.count }.by(1) }
    ```

  * **Line # 2741 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
            it { expect { subject }.to change { Image.count }.by(1) }
    ```

  * **Line # 2742 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { ImageToRecord.count }.by(1) }
    ```

  * **Line # 2742 - convention:** RSpec/ExpectChange: Prefer `change(ImageToRecord, :count)`.

    ```rb
            it { expect { subject }.to change { ImageToRecord.count }.by(1) }
    ```

  * **Line # 2744 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 2745 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              subject
    ```

  * **Line # 2762 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Menu::Dish.count }) }
    ```

  * **Line # 2762 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Dish, :count)`.

    ```rb
            it { expect { subject }.not_to(change { Menu::Dish.count }) }
    ```

  * **Line # 2763 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Menu::DishesInCategory.count }) }
    ```

  * **Line # 2763 - convention:** RSpec/ExpectChange: Prefer `change(Menu::DishesInCategory, :count)`.

    ```rb
            it { expect { subject }.not_to(change { Menu::DishesInCategory.count }) }
    ```

  * **Line # 2765 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 2766 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              subject
    ```

  * **Line # 2783 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { Menu::Dish.count }) }
    ```

  * **Line # 2783 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Dish, :count)`.

    ```rb
            it { expect { subject }.not_to(change { Menu::Dish.count }) }
    ```

  * **Line # 2784 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { category.reload.dishes.count }) }
    ```

  * **Line # 2785 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Menu::DishesInCategory.count }.by(3) }
    ```

  * **Line # 2785 - convention:** RSpec/ExpectChange: Prefer `change(Menu::DishesInCategory, :count)`.

    ```rb
            it { expect { subject }.to change { Menu::DishesInCategory.count }.by(3) }
    ```

  * **Line # 2787 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 2788 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              subject
    ```

  * **Line # 2805 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Menu::Dish.count }.by(3) }
    ```

  * **Line # 2805 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Dish, :count)`.

    ```rb
            it { expect { subject }.to change { Menu::Dish.count }.by(3) }
    ```

  * **Line # 2806 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { category.reload.dishes.count }) }
    ```

  * **Line # 2807 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Menu::DishesInCategory.count }.by(3) }
    ```

  * **Line # 2807 - convention:** RSpec/ExpectChange: Prefer `change(Menu::DishesInCategory, :count)`.

    ```rb
            it { expect { subject }.to change { Menu::DishesInCategory.count }.by(3) }
    ```

  * **Line # 2809 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 2810 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              subject
    ```

  * **Line # 2827 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Menu::Category.count }.by(1) }
    ```

  * **Line # 2827 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Category, :count)`.

    ```rb
            it { expect { subject }.to change { Menu::Category.count }.by(1) }
    ```

  * **Line # 2828 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { category.reload.children.count }) }
    ```

  * **Line # 2830 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 2831 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              subject
    ```

  * **Line # 2848 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Menu::Category.count }.by(3 + 1) }
    ```

  * **Line # 2848 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Category, :count)`.

    ```rb
            it { expect { subject }.to change { Menu::Category.count }.by(3 + 1) }
    ```

  * **Line # 2849 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.not_to(change { category.reload.children.count }) }
    ```

  * **Line # 2851 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 2852 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              subject
    ```

  * **Line # 2886 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [2896]

    ```rb
          context "when passing a invalid id" do ...
    ```

  * **Line # 2896 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [2886]

    ```rb
          context "when passing a invalid id" do ...
    ```

  * **Line # 2913 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:category0) { create(:menu_category, index: 0) }
    ```

  * **Line # 2914 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:category1) { create(:menu_category, index: 1) }
    ```

  * **Line # 2915 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:category2) { create(:menu_category, index: 2) }
    ```

  * **Line # 2917 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it do
    ```

  * **Line # 2918 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.to change { category.reload.index }.from(0).to(1)
    ```

  * **Line # 2926 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
              it do
    ```

  * **Line # 2927 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect { subject }.to change { category.reload.index }.from(0).to(2)
    ```

  * **Line # 2933 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect { subject }.to change { category1.reload.index }.from(1).to(0)
    ```

  * **Line # 2937 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect { subject }.to change { category2.reload.index }.from(2).to(1)
    ```

  * **Line # 2941 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                subject
    ```

  * **Line # 2950 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change { category0.reload.index }.from(0).to(1) }
    ```

  * **Line # 2951 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change { category1.reload.index }.from(1).to(2) }
    ```

  * **Line # 2952 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change { category2.reload.index }.from(2).to(0) }
    ```

  * **Line # 2955 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                subject
    ```

  * **Line # 2964 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { category0.reload.index }) }
    ```

  * **Line # 2966 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change { category1.reload.index }.from(1).to(2) }
    ```

  * **Line # 2967 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to(change { category1.reload.updated_at }) }
    ```

  * **Line # 2968 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to change { category2.reload.index }.from(2).to(1) }
    ```

  * **Line # 2969 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.to(change { category2.reload.updated_at }) }
    ```

  * **Line # 2976 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect { subject }.not_to(change { Menu::Category.order(:id).pluck(:updated_at) }) }
    ```

  * **Line # 2977 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

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

  * **Line # 18 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:post, "/v1/admin/menu/dishes").to(format: :json, action: :create,
    ```

  * **Line # 75 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              subject
    ```

  * **Line # 79 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Menu::Dish.count }.by(1) }
    ```

  * **Line # 79 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Dish, :count)`.

    ```rb
            it { expect { subject }.to change { Menu::Dish.count }.by(1) }
    ```

  * **Line # 80 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Menu::DishesInCategory.count }.by(1) }
    ```

  * **Line # 80 - convention:** RSpec/ExpectChange: Prefer `change(Menu::DishesInCategory, :count)`.

    ```rb
            it { expect { subject }.to change { Menu::DishesInCategory.count }.by(1) }
    ```

  * **Line # 81 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Menu::DishesInCategory.where(menu_category_id: nil).count }.by(1) }
    ```

  * **Line # 95 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Menu::Dish.count }.by(1) }
    ```

  * **Line # 95 - convention:** RSpec/ExpectChange: Prefer `change(Menu::Dish, :count)`.

    ```rb
            it { expect { subject }.to change { Menu::Dish.count }.by(1) }
    ```

  * **Line # 96 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Menu::DishesInCategory.count }.by(1) }
    ```

  * **Line # 96 - convention:** RSpec/ExpectChange: Prefer `change(Menu::DishesInCategory, :count)`.

    ```rb
            it { expect { subject }.to change { Menu::DishesInCategory.count }.by(1) }
    ```

  * **Line # 97 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Menu::DishesInCategory.where(menu_category_id: category.id).count }.by(1) }
    ```

  * **Line # 192 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject).to include(translations: Hash) }
    ```

  * **Line # 193 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:translations]).to include(name: Hash) }
    ```

  * **Line # 194 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.dig(:translations, :name)).to include(en: "wassa-en") }
    ```

  * **Line # 195 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.dig(:translations, :name)).to include(it: "wassa-it") }
    ```

  * **Line # 196 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.dig(:translations, :description)).to include(it: "bratan-it") }
    ```

  * **Line # 197 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

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

  * **Line # 92 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
              it do
    ```

  * **Line # 93 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject).not_to include(message: String)
    ```

  * **Line # 94 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject).to include(items: Array)
    ```

  * **Line # 95 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject[:items].count).to eq 1
    ```

  * **Line # 158 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.size).to eq 1 }
    ```

  * **Line # 182 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.size).to eq 1 }
    ```

  * **Line # 200 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.size).to eq 1 }
    ```

  * **Line # 201 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.first[:status]).to eq "active" }
    ```

  * **Line # 235 - convention:** Rails/UniqBeforePluck: Use `distinct` before `pluck`.

    ```rb
            it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(15, 16) }
    ```

  * **Line # 236 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.size).to eq 2 }
    ```

  * **Line # 240 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [258]

    ```rb
          context 'when filtering by price {price: "15.5"}' do ...
    ```

  * **Line # 254 - convention:** Rails/UniqBeforePluck: Use `distinct` before `pluck`.

    ```rb
            it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(15, 16) }
    ```

  * **Line # 255 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.size).to eq 0 }
    ```

  * **Line # 258 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [240]

    ```rb
          context 'when filtering by price {price: "15.5"}' do ...
    ```

  * **Line # 272 - convention:** Rails/UniqBeforePluck: Use `distinct` before `pluck`.

    ```rb
            it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(15.5, 15, 16) }
    ```

  * **Line # 273 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.size).to eq 1 }
    ```

  * **Line # 291 - convention:** Rails/UniqBeforePluck: Use `distinct` before `pluck`.

    ```rb
            it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(15, 15.5, 16) }
    ```

  * **Line # 292 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.size).to eq 1 }
    ```

  * **Line # 310 - convention:** Rails/UniqBeforePluck: Use `distinct` before `pluck`.

    ```rb
            it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(8, 10, 12) }
    ```

  * **Line # 311 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.size).to eq 2 }
    ```

  * **Line # 313 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.pluck(:price)).to contain_exactly(8, 10) }
    ```

  * **Line # 330 - convention:** Rails/UniqBeforePluck: Use `distinct` before `pluck`.

    ```rb
            it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(8, 10, 12) }
    ```

  * **Line # 331 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.size).to eq 2 }
    ```

  * **Line # 333 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.pluck(:price)).to contain_exactly(10, 12) }
    ```

  * **Line # 350 - convention:** Rails/UniqBeforePluck: Use `distinct` before `pluck`.

    ```rb
            it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(8, 10, 12) }
    ```

  * **Line # 351 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.size).to eq 1 }
    ```

  * **Line # 369 - convention:** Rails/UniqBeforePluck: Use `distinct` before `pluck`.

    ```rb
            it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(8, 10, 12) }
    ```

  * **Line # 370 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.size).to eq 1 }
    ```

  * **Line # 389 - convention:** Rails/UniqBeforePluck: Use `distinct` before `pluck`.

    ```rb
            it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(8, 10, 12, 14) }
    ```

  * **Line # 390 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.size).to eq 2 }
    ```

  * **Line # 391 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.pluck(:price)).to contain_exactly(10, 12) }
    ```

  * **Line # 409 - convention:** Rails/UniqBeforePluck: Use `distinct` before `pluck`.

    ```rb
            it { expect(Menu::Dish.pluck(:price).uniq).to contain_exactly(8, 10, 12, 14) }
    ```

  * **Line # 410 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.size).to eq 1 }
    ```

  * **Line # 411 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.pluck(:price)).to contain_exactly(10) }
    ```

  * **Line # 415 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let(:category0) { create(:menu_category) }
    ```

  * **Line # 416 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let(:category1) { create(:menu_category) }
    ```

  * **Line # 432 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 441 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let(:dish0) { create(:menu_dish) }
    ```

  * **Line # 442 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let(:dish1) { create(:menu_dish) }
    ```

  * **Line # 457 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 465 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:dish0) { create(:menu_dish, price: 15) }
    ```

  * **Line # 466 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:dish1) { create(:menu_dish, price: nil) }
    ```

  * **Line # 466 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:dish1) { create(:menu_dish, price: nil) }
    ```

  * **Line # 467 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:dish2) { create(:menu_dish, price: 0) }
    ```

  * **Line # 473 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 478 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 485 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:dish0) { create(:menu_dish, price: 15) }
    ```

  * **Line # 485 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:dish0) { create(:menu_dish, price: 15) }
    ```

  * **Line # 486 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:dish2) { create(:menu_dish, price: 0) }
    ```

  * **Line # 487 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:dish3) { create(:menu_dish, price: 25) }
    ```

  * **Line # 488 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:dish4) { create(:menu_dish, price: 14.9) }
    ```

  * **Line # 494 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 499 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 506 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:dish0) { create(:menu_dish, price: 15) }
    ```

  * **Line # 506 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:dish0) { create(:menu_dish, price: 15) }
    ```

  * **Line # 507 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:dish1) { create(:menu_dish, price: nil) }
    ```

  * **Line # 508 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:dish2) { create(:menu_dish, price: 0) }
    ```

  * **Line # 508 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:dish2) { create(:menu_dish, price: 0) }
    ```

  * **Line # 514 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 519 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 526 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:dish0) { create(:menu_dish, price: 15) }
    ```

  * **Line # 527 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:dish1) { create(:menu_dish, price: nil) }
    ```

  * **Line # 527 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:dish1) { create(:menu_dish, price: nil) }
    ```

  * **Line # 528 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:dish2) { create(:menu_dish, price: 0) }
    ```

  * **Line # 528 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:dish2) { create(:menu_dish, price: 0) }
    ```

  * **Line # 529 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:dish3) { create(:menu_dish, price: 25) }
    ```

  * **Line # 529 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:dish3) { create(:menu_dish, price: 25) }
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

  * **Line # 548 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:dish1) { create(:menu_dish, price: nil) }
    ```

  * **Line # 548 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:dish1) { create(:menu_dish, price: nil) }
    ```

  * **Line # 549 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:dish2) { create(:menu_dish, price: 0) }
    ```

  * **Line # 549 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:dish2) { create(:menu_dish, price: 0) }
    ```

  * **Line # 550 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:dish3) { create(:menu_dish, price: 25) }
    ```

  * **Line # 551 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:dish4) { create(:menu_dish, price: 14.9) }
    ```

  * **Line # 551 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:dish4) { create(:menu_dish, price: 14.9) }
    ```

  * **Line # 557 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 562 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 569 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:dish0) { create(:menu_dish, price: 15) }
    ```

  * **Line # 570 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:dish1) { create(:menu_dish, price: nil) }
    ```

  * **Line # 570 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:dish1) { create(:menu_dish, price: nil) }
    ```

  * **Line # 571 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:dish2) { create(:menu_dish, price: 0) }
    ```

  * **Line # 572 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:dish3) { create(:menu_dish, price: 25) }
    ```

  * **Line # 573 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:dish4) { create(:menu_dish, price: 100) }
    ```

  * **Line # 573 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:dish4) { create(:menu_dish, price: 100) }
    ```

  * **Line # 579 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 584 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 614 - convention:** Layout/LineLength: Line is too long. [147/120]

    ```rb
          context "when filtering by {can_suggest: <dish_id>} will return dishes that can be added as suggestions for the dish with the provided id" do
    ```

  * **Line # 617 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:deleted_dish) { create(:menu_dish, status: :deleted) }
    ```

  * **Line # 627 - convention:** Layout/LineLength: Line is too long. [153/120]

    ```rb
          context "when filtering by {except_in_category: <category_id>}, should return all items except those who are added in the provided category id." do
    ```

  * **Line # 628 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:dishes) { create_list(:menu_dish, 3) }
    ```

  * **Line # 641 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it do
    ```

  * **Line # 648 - convention:** Layout/LineLength: Line is too long. [171/120]

    ```rb
          context "when filtering by {except_in_category: \"<category_id>,<category_id>\"}, should return all items except those who are added in the provided category id." do
    ```

  * **Line # 649 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:dishes) { create_list(:menu_dish, 3) }
    ```

  * **Line # 651 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:category0) do ...
    ```

  * **Line # 658 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:category1) do ...
    ```

  * **Line # 669 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

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

### spec/controllers/v1/admin/reservations_controller/reservations_controller.add_tag_spec.rb - (15 offenses)
  * **Line # 5 - convention:** RSpec/FilePath: Spec path should end with `v1/admin/reservations_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::ReservationsController, type: :controller do
    ```

  * **Line # 5 - convention:** RSpec/SpecFilePathFormat: Spec path should end with `v1/admin/reservations_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::ReservationsController, type: :controller do
    ```

  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe V1::Admin::ReservationsController, type: :controller do
    ```

  * **Line # 61 - convention:** RSpec/ExpectChange: Prefer `change(TagInReservation, :count)`.

    ```rb
            it { expect { req }.to change { TagInReservation.count }.by(1) }
    ```

  * **Line # 62 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 63 - convention:** RSpec/ExpectChange: Prefer `change(ReservationTag, :count)`.

    ```rb
            it { expect { req }.not_to(change { ReservationTag.count }) }
    ```

  * **Line # 67 - convention:** RSpec/ExampleLength: Example has too many lines. [6/5]

    ```rb
            it "is successful" do ...
    ```

  * **Line # 67 - convention:** RSpec/MultipleExpectations: Example has too many expectations [5/1].

    ```rb
            it "is successful" do
    ```

  * **Line # 76 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
            it "can try to add twice the tag, will be added just once." do
    ```

  * **Line # 77 - convention:** RSpec/ExpectChange: Prefer `change(TagInReservation, :count)`.

    ```rb
              expect { req }.to change { TagInReservation.count }.by(1)
    ```

  * **Line # 79 - convention:** RSpec/ExpectChange: Prefer `change(TagInReservation, :count)`.

    ```rb
              expect { req }.not_to(change { TagInReservation.count })
    ```

  * **Line # 90 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
              allow_any_instance_of(TagInReservation).to receive(:valid?).and_return(false)
    ```

  * **Line # 93 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
              allow_any_instance_of(TagInReservation).to receive(:errors).and_return(errors)
    ```

  * **Line # 96 - convention:** RSpec/ExpectChange: Prefer `change(TagInReservation, :count)`.

    ```rb
            it { expect { req }.not_to(change { TagInReservation.count }) }
    ```

  * **Line # 98 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "returns 422 with message" do
    ```

### spec/controllers/v1/admin/reservations_controller/reservations_controller.create_spec.rb - (22 offenses)
  * **Line # 5 - convention:** RSpec/FilePath: Spec path should end with `v1/admin/reservations_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::ReservationsController, type: :controller do
    ```

  * **Line # 5 - convention:** RSpec/SpecFilePathFormat: Spec path should end with `v1/admin/reservations_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::ReservationsController, type: :controller do
    ```

  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe V1::Admin::ReservationsController, type: :controller do
    ```

  * **Line # 37 - convention:** RSpec/ExampleLength: Example has too many lines. [19/5]

    ```rb
            it "returns reservation info" do ...
    ```

  * **Line # 37 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "returns reservation info" do
    ```

  * **Line # 64 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "returns 200" do
    ```

  * **Line # 73 - convention:** Performance/CollectionLiteralInLoop: Avoid immutable Array literals in loops. It is better to extract it into a local variable or a constant.

    ```rb
            ["2024-10-12 19:00", "2024-12-25 21:00"].each do |datetime|
    ```

  * **Line # 74 - convention:** Performance/CollectionLiteralInLoop: Avoid immutable Array literals in loops. It is better to extract it into a local variable or a constant.

    ```rb
              [1, 2, 3].each do |adults|
    ```

  * **Line # 75 - convention:** Layout/LineLength: Line is too long. [121/120]

    ```rb
                context "when providing {fullname: #{fullname.inspect}, datetime: #{datetime.inspect}, adults: #{adults}}" do
    ```

  * **Line # 80 - convention:** RSpec/ExampleLength: Example has too many lines. [6/5]

    ```rb
                  it "returns provided info" do ...
    ```

  * **Line # 80 - convention:** RSpec/MultipleExpectations: Example has too many expectations [5/1].

    ```rb
                  it "returns provided info" do
    ```

  * **Line # 84 - convention:** Style/RedundantArgument: Argument " " is redundant because it is implied by default.

    ```rb
                    expect(parsed_response_body.dig(:item, :datetime)).to include(datetime.split(" ").first)
    ```

  * **Line # 85 - convention:** Style/RedundantArgument: Argument " " is redundant because it is implied by default.

    ```rb
                    expect(parsed_response_body.dig(:item, :datetime)).to include(datetime.split(" ").last)
    ```

  * **Line # 90 - convention:** Performance/CollectionLiteralInLoop: Avoid immutable Array literals in loops. It is better to extract it into a local variable or a constant.

    ```rb
                [201, "204 fuori"].each do |table|
    ```

  * **Line # 91 - convention:** Performance/CollectionLiteralInLoop: Avoid immutable Array literals in loops. It is better to extract it into a local variable or a constant.

    ```rb
                  ["bambini", "bella vita"].each do |notes|
    ```

  * **Line # 92 - convention:** Performance/CollectionLiteralInLoop: Avoid immutable Array literals in loops. It is better to extract it into a local variable or a constant.

    ```rb
                    ["sa@ba", "gi@gi"].each do |email|
    ```

  * **Line # 93 - convention:** Performance/CollectionLiteralInLoop: Avoid immutable Array literals in loops. It is better to extract it into a local variable or a constant.

    ```rb
                      ["123 333 333", "456 666 666"].each do |phone|
    ```

  * **Line # 94 - convention:** Layout/LineLength: Line is too long. [229/120]

    ```rb
                        context "when providing {fullname: #{fullname.inspect}, datetime: #{datetime.inspect}, adults: #{adults}, table: #{table.inspect}, notes: #{notes.inspect}, email: #{email.inspect}, phone: #{phone.inspect}}" do
    ```

  * **Line # 97 - convention:** RSpec/ExampleLength: Example has too many lines. [7/5]

    ```rb
                          it "returns provided info" do ...
    ```

  * **Line # 97 - convention:** RSpec/MultipleExpectations: Example has too many expectations [6/1].

    ```rb
                          it "returns provided info" do
    ```

  * **Line # 102 - convention:** Style/RedundantArgument: Argument " " is redundant because it is implied by default.

    ```rb
                            expect(parsed_response_body.dig(:item, :datetime)).to include(datetime.split(" ").first)
    ```

  * **Line # 103 - convention:** Style/RedundantArgument: Argument " " is redundant because it is implied by default.

    ```rb
                            expect(parsed_response_body.dig(:item, :datetime)).to include(datetime.split(" ").last)
    ```

### spec/controllers/v1/admin/reservations_controller/reservations_controller.deliver_confirmation_email_spec.rb - (15 offenses)
  * **Line # 5 - convention:** RSpec/FilePath: Spec path should end with `v1/admin/reservations_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::ReservationsController, type: :controller do
    ```

  * **Line # 5 - convention:** RSpec/SpecFilePathFormat: Spec path should end with `v1/admin/reservations_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::ReservationsController, type: :controller do
    ```

  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe V1::Admin::ReservationsController, type: :controller do
    ```

  * **Line # 33 - warning:** Lint/UnderscorePrefixedVariableName: Do not use prefix `_` for a variable that is used.

    ```rb
        def req(_params = params)
    ```

  * **Line # 61 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "is successful" do
    ```

  * **Line # 69 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
                allow_any_instance_of(Hash).to receive(:dig!).and_call_original
    ```

  * **Line # 77 - convention:** RSpec/ExpectChange: Prefer `change(Log::DeliveredEmail, :count)`.

    ```rb
              it { expect { req }.to change { Log::DeliveredEmail.count }.by(1) }
    ```

  * **Line # 79 - convention:** RSpec/ExpectChange: Prefer `change(Log::ImagePixel, :count)`.

    ```rb
              it { expect { req }.to change { Log::ImagePixel.count }.by(1) }
    ```

  * **Line # 81 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
              it "is successful" do
    ```

  * **Line # 89 - convention:** RSpec/ExampleLength: Example has too many lines. [9/5]

    ```rb
              it "last delivered email should have the correct reservation" do ...
    ```

  * **Line # 89 - convention:** RSpec/MultipleExpectations: Example has too many expectations [6/1].

    ```rb
              it "last delivered email should have the correct reservation" do
    ```

  * **Line # 108 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
              it "is successful" do
    ```

  * **Line # 118 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
              it "returns delivery details" do
    ```

  * **Line # 124 - convention:** RSpec/ExampleLength: Example has too many lines. [7/5]

    ```rb
              it do ...
    ```

  * **Line # 124 - convention:** RSpec/MultipleExpectations: Example has too many expectations [5/1].

    ```rb
              it do
    ```

### spec/controllers/v1/admin/reservations_controller/reservations_controller.destroy_spec.rb - (3 offenses)
  * **Line # 5 - convention:** RSpec/FilePath: Spec path should end with `v1/admin/reservations_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::ReservationsController, type: :controller do
    ```

  * **Line # 5 - convention:** RSpec/SpecFilePathFormat: Spec path should end with `v1/admin/reservations_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::ReservationsController, type: :controller do
    ```

  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe V1::Admin::ReservationsController, type: :controller do
    ```

### spec/controllers/v1/admin/reservations_controller/reservations_controller.export_spec.rb - (14 offenses)
  * **Line # 5 - convention:** RSpec/FilePath: Spec path should end with `v1/admin/reservations_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::ReservationsController, type: :controller do
    ```

  * **Line # 5 - convention:** RSpec/SpecFilePathFormat: Spec path should end with `v1/admin/reservations_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::ReservationsController, type: :controller do
    ```

  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe V1::Admin::ReservationsController, type: :controller do
    ```

  * **Line # 97 - convention:** Layout/LineLength: Line is too long. [133/120]

    ```rb
              expect(file.sheet("Prenotazioni").column(col_index("payment_hpp_url"))).to include(*ReservationPayment.all.pluck(:hpp_url))
    ```

  * **Line # 124 - convention:** Style/RedundantInterpolation: Prefer `to_s` over string interpolation.

    ```rb
          let(:query) { "#{secret[1..15]}" }
    ```

  * **Line # 188 - convention:** RSpec/MissingExampleGroupArgument: The first argument to `context` should not be empty.

    ```rb
          context do ...
    ```

  * **Line # 198 - convention:** RSpec/MissingExampleGroupArgument: The first argument to `context` should not be empty.

    ```rb
          context do ...
    ```

  * **Line # 208 - convention:** RSpec/MissingExampleGroupArgument: The first argument to `context` should not be empty.

    ```rb
          context do ...
    ```

  * **Line # 239 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
            it { expect(col_values("id")).to contain_exactly(@middle.id) }
    ```

  * **Line # 248 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
            it { expect(col_values("id")).to contain_exactly(@middle.id, @new.id) }
    ```

  * **Line # 248 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
            it { expect(col_values("id")).to contain_exactly(@middle.id, @new.id) }
    ```

  * **Line # 257 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
            it { expect(col_values("id")).to contain_exactly(@old.id, @middle.id, @new.id) }
    ```

  * **Line # 257 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
            it { expect(col_values("id")).to contain_exactly(@old.id, @middle.id, @new.id) }
    ```

  * **Line # 257 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
            it { expect(col_values("id")).to contain_exactly(@old.id, @middle.id, @new.id) }
    ```

### spec/controllers/v1/admin/reservations_controller/reservations_controller.index_spec.rb - (64 offenses)
  * **Line # 6 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
      it "has valid structure" do
    ```

  * **Line # 7 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
        expect(subject).to be_a(Hash)
    ```

  * **Line # 8 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
        expect(subject).to include(id: Integer, created_at: String, updated_at: String, datetime: String, adults: Integer,
    ```

  * **Line # 16 - convention:** Style/CaseLikeIf: Convert `if-elsif` to `case-when`.

    ```rb
        if options[field] == true ...
    ```

  * **Line # 18 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject).to include(field.to_sym => String)
    ```

  * **Line # 22 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject[field].to_s).to be_blank
    ```

  * **Line # 26 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject).to include(field.to_sym => options[field])
    ```

  * **Line # 43 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe V1::Admin::ReservationsController, type: :controller do
    ```

  * **Line # 97 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:reservation1) { create(:reservation, adults: 2, children: 0) } # 2 people
    ```

  * **Line # 98 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:reservation2) { create(:reservation, adults: 0, children: 2) } # 2 people
    ```

  * **Line # 99 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:reservation3) { create(:reservation, adults: 1, children: 1) } # 2 people
    ```

  * **Line # 100 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:reservation4) { create(:reservation, adults: 3, children: 0) } # 3 people
    ```

  * **Line # 106 - convention:** RSpec/MatchArray: Prefer `contain_exactly` when matching an array literal.

    ```rb
              it { expect(json[:items].pluck(:id)).to match_array([reservation4.id]) }
    ```

  * **Line # 113 - convention:** RSpec/MatchArray: Prefer `contain_exactly` when matching an array literal.

    ```rb
              it { expect(json[:items].pluck(:id)).to match_array([reservation1.id, reservation4.id]) }
    ```

  * **Line # 120 - convention:** RSpec/MatchArray: Prefer `contain_exactly` when matching an array literal.

    ```rb
              it { expect(json[:items].pluck(:id)).to match_array([reservation2.id]) }
    ```

  * **Line # 127 - convention:** RSpec/MatchArray: Prefer `contain_exactly` when matching an array literal.

    ```rb
              it { expect(json[:items].pluck(:id)).to match_array([reservation2.id, reservation3.id]) }
    ```

  * **Line # 134 - convention:** RSpec/MatchArray: Prefer `contain_exactly` when matching an array literal.

    ```rb
              it { expect(json[:items].pluck(:id)).to match_array([reservation1.id, reservation3.id, reservation4.id]) }
    ```

  * **Line # 141 - convention:** RSpec/MatchArray: Prefer `contain_exactly` when matching an array literal.

    ```rb
              it { expect(json[:items].pluck(:id)).to match_array([reservation1.id, reservation2.id, reservation3.id]) }
    ```

  * **Line # 146 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:payment1) do ...
    ```

  * **Line # 148 - convention:** Layout/LineLength: Line is too long. [149/120]

    ```rb
                                                          preorder_type: %i[html_nexi_authorization html_nexi_payment].sample, reservation: reservation1)
    ```

  * **Line # 150 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:payment2) do ...
    ```

  * **Line # 152 - convention:** Layout/LineLength: Line is too long. [149/120]

    ```rb
                                                          preorder_type: %i[html_nexi_authorization html_nexi_payment].sample, reservation: reservation2)
    ```

  * **Line # 155 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:reservation1) { create(:reservation) }
    ```

  * **Line # 156 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
            let!(:reservation2) { create(:reservation) }
    ```

  * **Line # 159 - convention:** Layout/LineLength: Line is too long. [121/120]

    ```rb
            context "when filtering by payment_external_id: '<exact>', will return reservations that have exactly that id" do
    ```

  * **Line # 169 - convention:** Layout/LineLength: Line is too long. [126/120]

    ```rb
            context "when filtering by payment_external_id: '<first-part>', will return reservations that have exactly that id" do
    ```

  * **Line # 216 - convention:** Layout/LineLength: Line is too long. [152/120]

    ```rb
            context "when filtering by preorder_type: 'html_nexi_authorization', will return reservations that have html_nexi_authorization payment type" do
    ```

  * **Line # 229 - convention:** Layout/LineLength: Line is too long. [140/120]

    ```rb
            context "when filtering by preorder_type: 'html_nexi_payment', will return reservations that have html_nexi_payment payment type" do
    ```

  * **Line # 245 - convention:** Layout/LineLength: Line is too long. [126/120]

    ```rb
                expect(json[:items].pluck(:id)).to contain_exactly(reservation_with_authorization.id, reservation_with_payment.id,
    ```

  * **Line # 293 - convention:** Layout/LineLength: Line is too long. [122/120]

    ```rb
            context "when filtering by payment_status: 'todo,paid', will return reservations that have todo payment status" do
    ```

  * **Line # 312 - convention:** Layout/LineLength: Line is too long. [129/120]

    ```rb
            context "when filtering by payment_status: 'authorized', will return reservations that have authorized payment status" do
    ```

  * **Line # 322 - convention:** Layout/LineLength: Line is too long. [125/120]

    ```rb
            context "when filtering by payment_status: 'refunded', will return reservations that have refunded payment status" do
    ```

  * **Line # 339 - convention:** Layout/LineLength: Line is too long. [146/120]

    ```rb
                                                                   reservation_authorized.id, reservation_refunded.id, reservation_without_payment.id)
    ```

  * **Line # 351 - convention:** Naming/VariableNumber: Use normalcase for symbol numbers.

    ```rb
            let!(:reservation_with_table_type_2) { create(:reservation, table_type: table_types.last) }
    ```

  * **Line # 388 - convention:** Layout/LineLength: Line is too long. [171/120]

    ```rb
            context "when filtering by table_type: '<id-of-table-type>,<id-of-second-table-type>', will return reservations with one of the provided table types associated" do
    ```

  * **Line # 389 - convention:** Performance/MapMethodChain: Use `map { |x| x.id.to_s }` instead of `map` method chain.

    ```rb
              before { req(table_type: table_types.map(&:id).map(&:to_s).join(",")) }
    ```

  * **Line # 402 - convention:** Layout/LineLength: Line is too long. [168/120]

    ```rb
            context "when filtering by table_type: '<id-of-table-type>,<id-some-other-number>', will return reservations with one of the provided table types associated" do
    ```

  * **Line # 427 - convention:** Layout/LineLength: Line is too long. [131/120]

    ```rb
                                                                 default_people_per_turn: Integer, default_price: Float, images: Array)
    ```

  * **Line # 445 - convention:** Performance/InefficientHashSearch: Use `#key?` instead of `#keys.include?`.

    ```rb
              it { expect(json[:items].filter { |j| j.keys.include?("payment") }.filter(&:present?).count).to eq(1) }
    ```

  * **Line # 445 - convention:** Performance/Count: Use `count` instead of `filter...count`.

    ```rb
              it { expect(json[:items].filter { |j| j.keys.include?("payment") }.filter(&:present?).count).to eq(1) }
    ```

  * **Line # 446 - convention:** Performance/Detect: Use `find` instead of `filter.first`.

    ```rb
              it { expect(json[:items].filter { |j| j.keys.include?("payment") }.first).to be_present }
    ```

  * **Line # 446 - convention:** Performance/InefficientHashSearch: Use `#key?` instead of `#keys.include?`.

    ```rb
              it { expect(json[:items].filter { |j| j.keys.include?("payment") }.first).to be_present }
    ```

  * **Line # 453 - convention:** Performance/Detect: Use `find` instead of `filter.first`.

    ```rb
                expect(json[:items].filter do |j| ...
    ```

  * **Line # 454 - convention:** Performance/InefficientHashSearch: Use `#key?` instead of `#keys.include?`.

    ```rb
                         j.keys.include?("payment")
    ```

  * **Line # 494 - convention:** RSpec/ExampleLength: Example has too many lines. [12/5]

    ```rb
            it "ignores param" do ...
    ```

  * **Line # 494 - convention:** RSpec/MultipleExpectations: Example has too many expectations [8/1].

    ```rb
            it "ignores param" do
    ```

  * **Line # 538 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(subject).to all(include(status: "active").or(include(status: "noshow")).or(include(status: "cancelled")))
    ```

  * **Line # 538 - convention:** Layout/LineLength: Line is too long. [124/120]

    ```rb
                expect(subject).to all(include(status: "active").or(include(status: "noshow")).or(include(status: "cancelled")))
    ```

  * **Line # 541 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.count).to eq 3 }
    ```

  * **Line # 570 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.count).to eq 2 }
    ```

  * **Line # 599 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.count).to eq 2 }
    ```

  * **Line # 657 - convention:** Style/RedundantArgument: Argument " " is redundant because it is implied by default.

    ```rb
              let(:query) { reservations.sample.fullname.split(" ").sample }
    ```

  * **Line # 673 - convention:** Style/RedundantArgument: Argument " " is redundant because it is implied by default.

    ```rb
              let(:query) { reservations.sample.notes.split(" ").sample }
    ```

  * **Line # 682 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:reservations) do
    ```

  * **Line # 685 - convention:** Rails/TimeZone: Do not use `Time.now` without zone. Use one of `Time.zone.now`, `Time.current`, `Time.now.in_time_zone`, `Time.now.utc`, `Time.now.getlocal`, `Time.now.xmlschema`, `Time.now.iso8601`, `Time.now.jisx0301`, `Time.now.rfc3339`, `Time.now.httpdate`, `Time.now.to_i`, `Time.now.to_f` instead.

    ```rb
                create(:reservation, status: :active, datetime: Time.now),
    ```

  * **Line # 699 - convention:** Rails/TimeZone: Do not use `Time.now` without zone. Use one of `Time.zone.now`, `Time.current`, `Time.now.in_time_zone`, `Time.now.utc`, `Time.now.getlocal`, `Time.now.xmlschema`, `Time.now.iso8601`, `Time.now.jisx0301`, `Time.now.rfc3339`, `Time.now.httpdate`, `Time.now.to_i`, `Time.now.to_f` instead.

    ```rb
              it { expect(parsed_response_body[:items][0][:datetime].to_date).to eq Time.now.to_date }
    ```

  * **Line # 705 - convention:** Rails/Date: Do not use `Date.today` without zone. Use `Time.zone.today` instead.

    ```rb
              before { req(date: Date.today.to_date) }
    ```

  * **Line # 709 - convention:** Rails/TimeZone: Do not use `Time.now` without zone. Use one of `Time.zone.now`, `Time.current`, `Time.now.in_time_zone`, `Time.now.utc`, `Time.now.getlocal`, `Time.now.xmlschema`, `Time.now.iso8601`, `Time.now.jisx0301`, `Time.now.rfc3339`, `Time.now.httpdate`, `Time.now.to_i`, `Time.now.to_f` instead.

    ```rb
              it { expect(parsed_response_body[:items][0][:datetime].to_date).to eq Time.now.to_date }
    ```

  * **Line # 743 - convention:** Layout/LineLength: Line is too long. [127/120]

    ```rb
            context "when filtering by {date_from: 1.day.from_now.end_of_day.to_datetime.to_s, date_to: 1.day.from_now.to_date}" do
    ```

  * **Line # 759 - convention:** Layout/LineLength: Line is too long. [135/120]

    ```rb
            context "when filtering by {datetime_from: 1.day.from_now.end_of_day.to_datetime.to_s, datetime_to: 1.day.from_now.to_date}" do
    ```

  * **Line # 855 - convention:** Performance/CollectionLiteralInLoop: Avoid immutable Array literals in loops. It is better to extract it into a local variable or a constant.

    ```rb
            %w[order_by_direction order_by_order].each do |order_by_order_name|
    ```

  * **Line # 874 - convention:** Performance/CollectionLiteralInLoop: Avoid immutable Array literals in loops. It is better to extract it into a local variable or a constant.

    ```rb
            %w[attribute column field by].each do |attribute_alias|
    ```

  * **Line # 875 - convention:** Layout/LineLength: Line is too long. [132/120]

    ```rb
              context "when ordering with {order_by: { #{attribute_alias.inspect}: 'datetime', #{direction_alias.inspect}: 'DESC' }}" do
    ```

  * **Line # 883 - convention:** RSpec/MultipleExpectations: Example has too many expectations [5/1].

    ```rb
                it "allows any combination between aliases." do
    ```

### spec/controllers/v1/admin/reservations_controller/reservations_controller.remove_tag_spec.rb - (16 offenses)
  * **Line # 5 - convention:** RSpec/FilePath: Spec path should end with `v1/admin/reservations_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::ReservationsController, type: :controller do
    ```

  * **Line # 5 - convention:** RSpec/SpecFilePathFormat: Spec path should end with `v1/admin/reservations_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::ReservationsController, type: :controller do
    ```

  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe V1::Admin::ReservationsController, type: :controller do
    ```

  * **Line # 21 - convention:** Layout/LineLength: Line is too long. [136/120]

    ```rb
                                                                                                action: :remove_tag, id: "2", format: :json)
    ```

  * **Line # 60 - convention:** RSpec/ExpectChange: Prefer `change(TagInReservation, :count)`.

    ```rb
            it { expect { req }.to change { TagInReservation.count }.by(-1) }
    ```

  * **Line # 61 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 62 - convention:** RSpec/ExpectChange: Prefer `change(ReservationTag, :count)`.

    ```rb
            it { expect { req }.not_to(change { ReservationTag.count }) }
    ```

  * **Line # 67 - convention:** RSpec/ExampleLength: Example has too many lines. [6/5]

    ```rb
            it "is successful" do ...
    ```

  * **Line # 67 - convention:** RSpec/MultipleExpectations: Example has too many expectations [5/1].

    ```rb
            it "is successful" do
    ```

  * **Line # 76 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
            it "when removing same tag twice, should be fine." do
    ```

  * **Line # 92 - convention:** RSpec/ExpectChange: Prefer `change(TagInReservation, :count)`.

    ```rb
            it { expect { req }.to change { TagInReservation.count }.by(-1) }
    ```

  * **Line # 93 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 94 - convention:** RSpec/ExpectChange: Prefer `change(ReservationTag, :count)`.

    ```rb
            it { expect { req }.not_to(change { ReservationTag.count }) }
    ```

  * **Line # 99 - convention:** RSpec/ExampleLength: Example has too many lines. [6/5]

    ```rb
            it "is successful" do ...
    ```

  * **Line # 99 - convention:** RSpec/MultipleExpectations: Example has too many expectations [5/1].

    ```rb
            it "is successful" do
    ```

  * **Line # 108 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
            it "when removing same tag twice, should be fine." do
    ```

### spec/controllers/v1/admin/reservations_controller/reservations_controller.show_spec.rb - (11 offenses)
  * **Line # 6 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
      it "has valid structure" do
    ```

  * **Line # 7 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
        expect(subject).to be_a(Hash)
    ```

  * **Line # 8 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
        expect(subject).to include(id: Integer, created_at: String, updated_at: String, datetime: String, adults: Integer,
    ```

  * **Line # 16 - convention:** Style/CaseLikeIf: Convert `if-elsif` to `case-when`.

    ```rb
        if options[field] == true ...
    ```

  * **Line # 18 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject).to include(field.to_sym => String)
    ```

  * **Line # 22 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject[field].to_s).to be_blank
    ```

  * **Line # 26 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject).to include(field.to_sym => options[field])
    ```

  * **Line # 32 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe V1::Admin::ReservationsController, type: :controller do
    ```

  * **Line # 90 - convention:** Rails/TimeZone: Do not use `Time.now` without zone. Use one of `Time.zone.now`, `Time.current`, `Time.now.in_time_zone`, `Time.now.utc`, `Time.now.getlocal`, `Time.now.xmlschema`, `Time.now.iso8601`, `Time.now.jisx0301`, `Time.now.rfc3339`, `Time.now.httpdate`, `Time.now.to_i`, `Time.now.to_f` instead.

    ```rb
              reservation.image_pixels.first.events.create!(event_time: Time.now)
    ```

  * **Line # 94 - convention:** RSpec/ExampleLength: Example has too many lines. [8/5]

    ```rb
            it do ...
    ```

  * **Line # 94 - convention:** RSpec/MultipleExpectations: Example has too many expectations [7/1].

    ```rb
            it do
    ```

### spec/controllers/v1/admin/reservations_controller/reservations_controller.tables_summary_spec.rb - (9 offenses)
  * **Line # 5 - convention:** RSpec/FilePath: Spec path should end with `v1/admin/reservations_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::ReservationsController, type: :controller do
    ```

  * **Line # 5 - convention:** RSpec/SpecFilePathFormat: Spec path should end with `v1/admin/reservations_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::ReservationsController, type: :controller do
    ```

  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe V1::Admin::ReservationsController, type: :controller do
    ```

  * **Line # 61 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:reservations) do
    ```

  * **Line # 64 - convention:** Rails/TimeZone: Do not use `Time.now` without zone. Use one of `Time.zone.now`, `Time.current`, `Time.now.in_time_zone`, `Time.now.utc`, `Time.now.getlocal`, `Time.now.xmlschema`, `Time.now.iso8601`, `Time.now.jisx0301`, `Time.now.rfc3339`, `Time.now.httpdate`, `Time.now.to_i`, `Time.now.to_f` instead.

    ```rb
                create(:reservation, status: :active, datetime: Time.now, adults: 2),
    ```

  * **Line # 71 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:reservation_turns) do
    ```

  * **Line # 78 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
              let!(:reservation_turns) do
    ```

  * **Line # 85 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
              let!(:reservations) do
    ```

  * **Line # 157 - convention:** Rails/Date: Do not use `Date.today` without zone. Use `Time.zone.today` instead.

    ```rb
              before { req(date: Date.today.to_date) }
    ```

### spec/controllers/v1/admin/reservations_controller/reservations_controller.update_spec.rb - (6 offenses)
  * **Line # 5 - convention:** RSpec/FilePath: Spec path should end with `v1/admin/reservations_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::ReservationsController, type: :controller do
    ```

  * **Line # 5 - convention:** RSpec/SpecFilePathFormat: Spec path should end with `v1/admin/reservations_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::ReservationsController, type: :controller do
    ```

  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe V1::Admin::ReservationsController, type: :controller do
    ```

  * **Line # 60 - convention:** Style/StringConcatenation: Prefer string interpolation to string concatenation.

    ```rb
            let(:fullname) { "Anne Marie" + SecureRandom.hex }
    ```

  * **Line # 87 - convention:** Style/StringConcatenation: Prefer string interpolation to string concatenation.

    ```rb
            let(:notes) { "Please be kind" + SecureRandom.hex }
    ```

  * **Line # 96 - convention:** Style/StringConcatenation: Prefer string interpolation to string concatenation.

    ```rb
            let(:email) { "giuly@presley" + SecureRandom.hex }
    ```

### spec/controllers/v1/admin/reservations_controller/reservations_controller.update_status_spec.rb - (12 offenses)
  * **Line # 5 - convention:** RSpec/FilePath: Spec path should end with `v1/admin/reservations_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::ReservationsController, type: :controller do
    ```

  * **Line # 5 - convention:** RSpec/SpecFilePathFormat: Spec path should end with `v1/admin/reservations_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::Admin::ReservationsController, type: :controller do
    ```

  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe V1::Admin::ReservationsController, type: :controller do
    ```

  * **Line # 23 - convention:** Layout/LineLength: Line is too long. [140/120]

    ```rb
                                                                                                 action: :update_status, id: "2", format: :json)
    ```

  * **Line # 50 - convention:** RSpec/ExampleLength: Example has too many lines. [7/5]

    ```rb
            it do ...
    ```

  * **Line # 50 - convention:** RSpec/MultipleExpectations: Example has too many expectations [7/1].

    ```rb
            it do
    ```

  * **Line # 64 - convention:** RSpec/ExampleLength: Example has too many lines. [7/5]

    ```rb
            it do ...
    ```

  * **Line # 64 - convention:** RSpec/MultipleExpectations: Example has too many expectations [7/1].

    ```rb
            it do
    ```

  * **Line # 78 - convention:** RSpec/ExampleLength: Example has too many lines. [8/5]

    ```rb
            it do ...
    ```

  * **Line # 78 - convention:** RSpec/MultipleExpectations: Example has too many expectations [8/1].

    ```rb
            it do
    ```

  * **Line # 86 - convention:** Rails/TimeZone: Do not use `Time.now` without zone. Use one of `Time.zone.now`, `Time.current`, `Time.now.in_time_zone`, `Time.now.utc`, `Time.now.getlocal`, `Time.now.xmlschema`, `Time.now.iso8601`, `Time.now.jisx0301`, `Time.now.rfc3339`, `Time.now.httpdate`, `Time.now.to_i`, `Time.now.to_f` instead.

    ```rb
              expect(json[:item][:cancelled_at]).to include(Time.now.strftime("%Y-%m-%d"))
    ```

  * **Line # 93 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
            it do
    ```

### spec/controllers/v1/images_controller_spec.rb - (44 offenses)
  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe V1::ImagesController, type: :controller do
    ```

  * **Line # 47 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
            it "checking mock data" do
    ```

  * **Line # 72 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
                it "when providing record_type: #{invalid_klass.inspect}" do
    ```

  * **Line # 89 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
            it "checking mock data" do
    ```

  * **Line # 102 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.length).to eq 3 }
    ```

  * **Line # 127 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
          it { expect { req }.not_to(change { Image.count }) }
    ```

  * **Line # 138 - convention:** RSpec/ExpectChange: Prefer `change(ImageToRecord, :count)`.

    ```rb
          it { expect { req }.not_to(change { ImageToRecord.count }) }
    ```

  * **Line # 152 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
              it do
    ```

  * **Line # 159 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
              it { expect { req }.to change { Image.count }.from(0).to(1) }
    ```

  * **Line # 160 - convention:** RSpec/ExpectChange: Prefer `change(ImageToRecord, :count)`.

    ```rb
              it { expect { req }.to change { ImageToRecord.count }.from(0).to(1) }
    ```

  * **Line # 171 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:record_type) { "Menu::Category" }
    ```

  * **Line # 172 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:record_id) { category.id }
    ```

  * **Line # 175 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              subject
    ```

  * **Line # 179 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { Image.count }.by(1) }
    ```

  * **Line # 179 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
            it { expect { subject }.to change { Image.count }.by(1) }
    ```

  * **Line # 180 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { ImageToRecord.count }.by(1) }
    ```

  * **Line # 180 - convention:** RSpec/ExpectChange: Prefer `change(ImageToRecord, :count)`.

    ```rb
            it { expect { subject }.to change { ImageToRecord.count }.by(1) }
    ```

  * **Line # 181 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect { subject }.to change { category.reload.images.count }.by(1) }
    ```

  * **Line # 194 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:patch, "/v1/images/1").to(format: :json, action: :update, id: 1,
    ```

  * **Line # 199 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:patch, "/v1/images/881").to(format: :json, action: :update, id: 881,
    ```

  * **Line # 213 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
          it { expect { req }.not_to(change { Image.count }) }
    ```

  * **Line # 226 - convention:** RSpec/ExpectChange: Prefer `change(ImageToRecord, :count)`.

    ```rb
          it { expect { req }.not_to(change { ImageToRecord.count }) }
    ```

  * **Line # 227 - convention:** RSpec/ExpectChange: Prefer `change(Image, :count)`.

    ```rb
          it { expect { req }.not_to(change { Image.count }) }
    ```

  * **Line # 284 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:patch, "/v1/images/record").to(format: :json, action: :update_record,
    ```

  * **Line # 314 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 326 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 341 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
            let(:image_ids) { @order_before.reverse }
    ```

  * **Line # 348 - convention:** RSpec/ExpectChange: Prefer `change(ImageToRecord, :count)`.

    ```rb
            it { expect { req }.not_to(change { ImageToRecord.count }) }
    ```

  * **Line # 351 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 353 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              expect(record.reload.images.pluck(:id)).not_to eq @order_before
    ```

  * **Line # 354 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              expect(record.reload.images.pluck(:id)).to match_array(@order_before)
    ```

  * **Line # 371 - convention:** RSpec/ExpectChange: Prefer `change(ImageToRecord, :count)`.

    ```rb
            it { expect { req }.to(change { ImageToRecord.count }) }
    ```

  * **Line # 413 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:patch, "/v1/images/5/remove_from_record").to(format: :json, action: :remove_from_record,
    ```

  * **Line # 480 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:get, "/v1/images/23/download").to(format: :json, action: :download,
    ```

  * **Line # 508 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
            allow_any_instance_of(Image).to receive(:download).and_raise(ActiveStorage::FileNotFoundError)
    ```

  * **Line # 523 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:get, "/v1/images/23/download/blur").to(format: :json, action: :download_variant,
    ```

  * **Line # 567 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:get, "/v1/images/key/wassabratan").to(format: :json, action: :download_by_key, controller: "v1/images",
    ```

  * **Line # 567 - convention:** Layout/LineLength: Line is too long. [135/120]

    ```rb
          expect(subject).to route(:get, "/v1/images/key/wassabratan").to(format: :json, action: :download_by_key, controller: "v1/images",
    ```

  * **Line # 571 - warning:** Lint/UnderscorePrefixedVariableName: Do not use prefix `_` for a variable that is used.

    ```rb
        def req(_params = params)
    ```

  * **Line # 575 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it "returns 200" do
    ```

  * **Line # 602 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:get, "/v1/images/p/wassabratan").to(format: :json, action: :download_by_pixel_secret,
    ```

  * **Line # 606 - warning:** Lint/UnderscorePrefixedVariableName: Do not use prefix `_` for a variable that is used.

    ```rb
        def req(_params = params)
    ```

  * **Line # 621 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it "returns 200 usually" do
    ```

  * **Line # 632 - convention:** RSpec/ExpectChange: Prefer `change(Log::ImagePixelEvent, :count)`.

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

### spec/controllers/v1/menu/categories_controller_spec.rb - (133 offenses)
  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe V1::Menu::CategoriesController, type: :controller do
    ```

  * **Line # 99 - convention:** Layout/LineLength: Line is too long. [184/120]

    ```rb
        context "filtering for { skip_empty_categories: true } and categories have only inactive dishes and empty categories, should be empty cuz children categories are empty as well." do
    ```

  * **Line # 128 - convention:** Layout/LineLength: Line is too long. [123/120]

    ```rb
        context "filtering for { skip_empty_categories: true } and categories are actually empty (no dishes, no categories)" do
    ```

  * **Line # 141 - convention:** Layout/LineLength: Line is too long. [126/120]

    ```rb
        context "filtering for { skip_empty_categories: true } and some categories have dishes, other have children categories" do
    ```

  * **Line # 208 - convention:** Rails/Pick: Prefer `pick(:secret)` over `pluck(:secret).first`.

    ```rb
          it { expect(json[:items].pluck(:secret).first).to be_in(Menu::Category.all.pluck(:secret)) }
    ```

  * **Line # 249 - convention:** Layout/LineLength: Line is too long. [140/120]

    ```rb
          context "when public visibility is enabled but current time is out of absolute timezone (from: #{from.inspect}, to: #{to.inspect})" do
    ```

  * **Line # 301 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:items].size).to eq 10 }
    ```

  * **Line # 302 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:total_count]).to eq 30 }
    ```

  * **Line # 303 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:current_page]).to eq 1 }
    ```

  * **Line # 304 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:per_page]).to eq 10 }
    ```

  * **Line # 312 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:items].size).to eq 3 }
    ```

  * **Line # 313 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:total_count]).to eq 10 }
    ```

  * **Line # 314 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:current_page]).to eq 1 }
    ```

  * **Line # 315 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:per_page]).to eq 3 }
    ```

  * **Line # 323 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:items].size).to eq 3 }
    ```

  * **Line # 324 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:total_count]).to eq 10 }
    ```

  * **Line # 325 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:current_page]).to eq 2 }
    ```

  * **Line # 326 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:per_page]).to eq 3 }
    ```

  * **Line # 335 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              it { expect(@page1).to eq @offset0 }
    ```

  * **Line # 335 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              it { expect(@page1).to eq @offset0 }
    ```

  * **Line # 344 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:items].size).to eq 1 }
    ```

  * **Line # 345 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:total_count]).to eq 10 }
    ```

  * **Line # 346 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:current_page]).to eq 4 }
    ```

  * **Line # 347 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:per_page]).to eq 3 }
    ```

  * **Line # 355 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:items].size).to eq 0 }
    ```

  * **Line # 356 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:total_count]).to eq 10 }
    ```

  * **Line # 357 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:current_page]).to eq 10 }
    ```

  * **Line # 358 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[:metadata][:per_page]).to eq 3 }
    ```

  * **Line # 369 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              @items
    ```

  * **Line # 372 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.length).to eq 10 }
    ```

  * **Line # 373 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject).to all(be_a(Hash)) }
    ```

  * **Line # 374 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.pluck(:id).uniq.count).to eq 10 }
    ```

  * **Line # 390 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject).to be_a(Array) }
    ```

  * **Line # 391 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.count).to eq 2 }
    ```

  * **Line # 392 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[0][:index]).to eq 0 }
    ```

  * **Line # 393 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject[1][:index]).to eq 1 }
    ```

  * **Line # 408 - convention:** Rails/SkipsModelValidations: Avoid using `update_all` because it skips validations.

    ```rb
              Menu::Visibility.update_all(public_visible: true)
    ```

  * **Line # 414 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject).to be_a(Array) }
    ```

  * **Line # 415 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.pluck(:id)).to eq Menu::Category.order(:index).pluck(:id) }
    ```

  * **Line # 425 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
            req(except: @excluded.id)
    ```

  * **Line # 431 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.count).to eq 1 }
    ```

  * **Line # 432 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.pluck(:id).uniq.count).to eq 1 }
    ```

  * **Line # 433 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.first[:id]).to eq Menu::Category.last.id }
    ```

  * **Line # 437 - convention:** Performance/CollectionLiteralInLoop: Avoid immutable Array literals in loops. It is better to extract it into a local variable or a constant.

    ```rb
          ["true", "t", "1", true, 1].each do |param_value|
    ```

  * **Line # 438 - convention:** Layout/LineLength: Line is too long. [133/120]

    ```rb
            context "when filtering by { #{param_name.inspect}: #{param_value.inspect} } should return only categories without parent" do
    ```

  * **Line # 442 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
              let!(:children) { create_list(:menu_category, 2, parent:, visibility: nil) }
    ```

  * **Line # 452 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.count).to eq 1 }
    ```

  * **Line # 453 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.pluck(:id).uniq).to match_array(Menu::Category.without_parent.pluck(:id)) }
    ```

  * **Line # 454 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.pluck(:parent_id)).to all(be_nil) }
    ```

  * **Line # 474 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject).to be_a(Hash) }
    ```

  * **Line # 475 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(Menu::Category.find(subject[:id])).to be_a(Menu::Category) }
    ```

  * **Line # 483 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject).to include(
    ```

  * **Line # 490 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject[:images].count).to eq 2 }
    ```

  * **Line # 496 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
            create_list(:menu_category, 2, visibility: nil, parent: @parent)
    ```

  * **Line # 507 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
            before { req(parent_id: @parent.id) }
    ```

  * **Line # 512 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.count).to eq 2 }
    ```

  * **Line # 513 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.pluck(:id).uniq.count).to eq 2 }
    ```

  * **Line # 516 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(Menu::Category.where(id: subject.pluck(:id).uniq).pluck(:id)).to match_array(Menu::Category.where(parent: @parent).pluck(:id))
    ```

  * **Line # 516 - convention:** Layout/LineLength: Line is too long. [145/120]

    ```rb
                expect(Menu::Category.where(id: subject.pluck(:id).uniq).pluck(:id)).to match_array(Menu::Category.where(parent: @parent).pluck(:id))
    ```

  * **Line # 516 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
                expect(Menu::Category.where(id: subject.pluck(:id).uniq).pluck(:id)).to match_array(Menu::Category.where(parent: @parent).pluck(:id))
    ```

  * **Line # 523 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject[:total_count]).to eq 2 }
    ```

  * **Line # 524 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject[:current_page]).to eq 1 }
    ```

  * **Line # 525 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject[:per_page]).to eq 10 }
    ```

  * **Line # 526 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject[:params]).to be_a(Hash) }
    ```

  * **Line # 527 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject[:params]).to include("parent_id" => @parent.id) }
    ```

  * **Line # 527 - convention:** RSpec/InstanceVariable: Avoid instance variables - use let, a method call, or a local variable (if possible).

    ```rb
              it { expect(subject[:params]).to include("parent_id" => @parent.id) }
    ```

  * **Line # 537 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.count).to eq 3 }
    ```

  * **Line # 538 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.pluck(:id).uniq.count).to eq 3 }
    ```

  * **Line # 541 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect(Menu::Category.where(id: subject.pluck(:id).uniq).pluck(:id)).to match_array(Menu::Category.where(parent_id: nil).pluck(:id))
    ```

  * **Line # 541 - convention:** Layout/LineLength: Line is too long. [144/120]

    ```rb
                expect(Menu::Category.where(id: subject.pluck(:id).uniq).pluck(:id)).to match_array(Menu::Category.where(parent_id: nil).pluck(:id))
    ```

  * **Line # 548 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject[:total_count]).to eq 3 }
    ```

  * **Line # 549 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject[:current_page]).to eq 1 }
    ```

  * **Line # 550 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject[:per_page]).to eq 10 }
    ```

  * **Line # 551 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject[:params]).to be_a(Hash) }
    ```

  * **Line # 552 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject[:params]).to include("parent_id" => "") }
    ```

  * **Line # 560 - convention:** Performance/TimesMap: Use `Array.new(5)` with a block instead of `.times.map`.

    ```rb
            5.times.map do |i| ...
    ```

  * **Line # 582 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.count).to eq 5 }
    ```

  * **Line # 583 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.pluck(:id).uniq.count).to eq 5 }
    ```

  * **Line # 592 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.count).to eq 5 }
    ```

  * **Line # 593 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.pluck(:id).uniq.count).to eq 5 }
    ```

  * **Line # 602 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.count).to eq 1 }
    ```

  * **Line # 603 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.pluck(:id).uniq.count).to eq 1 }
    ```

  * **Line # 604 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.first[:name]).to eq "Category #1!!!" }
    ```

  * **Line # 613 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.count).to eq 1 }
    ```

  * **Line # 614 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.pluck(:id).uniq.count).to eq 1 }
    ```

  * **Line # 615 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.first[:name]).to eq "Category #1!!!" }
    ```

  * **Line # 616 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.first[:description]).to eq "Description for #1!!!" }
    ```

  * **Line # 625 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.count).to eq 1 }
    ```

  * **Line # 626 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.pluck(:id).uniq.count).to eq 1 }
    ```

  * **Line # 627 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.first[:name]).to eq "Category #5!!!" }
    ```

  * **Line # 628 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            it { expect(subject.first[:description]).to eq "Description for #5!!!" }
    ```

  * **Line # 635 - convention:** Performance/TimesMap: Use `Array.new(5)` with a block instead of `.times.map`.

    ```rb
            5.times.map do |i| ...
    ```

  * **Line # 647 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it do
    ```

  * **Line # 648 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject.map(&:price).uniq).to contain_exactly(nil, 10, 20, 30, 40, 50)
    ```

  * **Line # 649 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject.map(&:price?)).to match_array(([false] * 5) + ([true] * 5))
    ```

  * **Line # 650 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject.count).to eq 10
    ```

  * **Line # 660 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.count).to eq 5 }
    ```

  * **Line # 661 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.pluck(:id).uniq.count).to eq 5 }
    ```

  * **Line # 662 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.pluck(:price).uniq).to all(be_positive) }
    ```

  * **Line # 663 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.pluck(:price).uniq).to all(be_a(Numeric)) }
    ```

  * **Line # 678 - convention:** Performance/TimesMap: Use `Array.new(5)` with a block instead of `.times.map`.

    ```rb
            5.times.map do |i| ...
    ```

  * **Line # 690 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it do
    ```

  * **Line # 691 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject.map(&:price).uniq).to contain_exactly(nil, 10, 20, 30, 40, 50)
    ```

  * **Line # 692 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject.map(&:price?)).to match_array(([false] * 5) + ([true] * 5))
    ```

  * **Line # 693 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect(subject.count).to eq 10
    ```

  * **Line # 703 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.count).to eq 5 }
    ```

  * **Line # 704 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.pluck(:id).uniq.count).to eq 5 }
    ```

  * **Line # 705 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.pluck(:price).uniq).to eq [nil] }
    ```

  * **Line # 728 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.count).to eq 1 }
    ```

  * **Line # 729 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.pluck(:id)).to contain_exactly(categories[0].id) }
    ```

  * **Line # 751 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.count).to eq 2 }
    ```

  * **Line # 752 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.pluck(:id)).to match_array(categories[0..1].map(&:id)) }
    ```

  * **Line # 773 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.count).to eq 1 }
    ```

  * **Line # 774 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.pluck(:id)).to match_array(categories[0].id) }
    ```

  * **Line # 795 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.count).to eq 2 }
    ```

  * **Line # 796 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              it { expect(subject.pluck(:id)).to match_array(categories[0..1].map(&:id)) }
    ```

  * **Line # 821 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject).to all(include(status: "active")) }
    ```

  * **Line # 822 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject.size).to eq 1 }
    ```

  * **Line # 916 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject).to include(
    ```

  * **Line # 923 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject[:images].count).to eq 0 }
    ```

  * **Line # 936 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
          it do
    ```

  * **Line # 937 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject).to include(translations: Hash)
    ```

  * **Line # 938 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject[:translations]).to include(name: Hash)
    ```

  * **Line # 939 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.dig(:translations, :name)).to include(en: "test-en")
    ```

  * **Line # 940 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject.dig(:translations, :name)).to include(it: "test-it")
    ```

  * **Line # 955 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [963]

    ```rb
        context "when passing a invalid id" do ...
    ```

  * **Line # 963 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [955]

    ```rb
        context "when passing a invalid id" do ...
    ```

  * **Line # 984 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject).to include(
    ```

  * **Line # 991 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          it { expect(subject[:images].count).to eq 2 }
    ```

  * **Line # 1008 - convention:** RSpec/ExampleLength: Example has too many lines. [6/5]

    ```rb
          it { ...
    ```

  * **Line # 1009 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
            expect(subject).to include(
    ```

  * **Line # 1040 - convention:** Rails/I18nLocaleAssignment: Use `I18n.with_locale` with block instead of `I18n.locale=`.

    ```rb
            I18n.locale = (I18n.available_locales - [I18n.default_locale]).sample
    ```

  * **Line # 1046 - convention:** Rails/I18nLocaleAssignment: Use `I18n.with_locale` with block instead of `I18n.locale=`.

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

### spec/controllers/v1/reservations_controller/reservations_controller.cancel_spec.rb - (20 offenses)
  * **Line # 26 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe V1::ReservationsController, type: :controller do
    ```

  * **Line # 49 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:patch, "/v1/reservations/cancel").to(format: :json, action: :cancel,
    ```

  * **Line # 55 - convention:** Layout/LineLength: Line is too long. [125/120]

    ```rb
                       "#{Config.app.dig!(:nexi_api_url)}/#{Config.app.dig!(:nexi_refund_payment_path)}").to_return do |_request|
    ```

  * **Line # 75 - convention:** RSpec/ExpectChange: Prefer `change(Log::DeliveredEmail, :count)`.

    ```rb
          it { expect { req }.to change { Log::DeliveredEmail.count }.by(1) }
    ```

  * **Line # 83 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
              let!(:payment) { create(:reservation_payment, status: payment_status, reservation:) }
    ```

  * **Line # 87 - convention:** RSpec/ExpectChange: Prefer `change(ReservationPayment, :count)`.

    ```rb
              it  { expect { req }.not_to(change { ReservationPayment.count }) }
    ```

  * **Line # 88 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
              it  { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 90 - convention:** RSpec/ExpectChange: Prefer `change(Log::DeliveredEmail, :count)`.

    ```rb
              it { expect { req }.to change { Log::DeliveredEmail.count }.by(1) }
    ```

  * **Line # 116 - convention:** RSpec/ExpectChange: Prefer `change(ReservationPayment, :count)`.

    ```rb
            it  { expect { req }.not_to(change { ReservationPayment.count }) }
    ```

  * **Line # 117 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it  { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 137 - convention:** RSpec/ExpectChange: Prefer `change(ReservationPayment, :count)`.

    ```rb
              it  { expect { req }.not_to(change { ReservationPayment.count }) }
    ```

  * **Line # 138 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
              it  { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 155 - convention:** RSpec/ExpectChange: Prefer `change(ReservationPayment, :count)`.

    ```rb
            it  { expect { req }.not_to(change { ReservationPayment.count }) }
    ```

  * **Line # 156 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it  { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 175 - convention:** Performance/CollectionLiteralInLoop: Avoid immutable Array literals in loops. It is better to extract it into a local variable or a constant.

    ```rb
            [ ...
    ```

  * **Line # 208 - convention:** Performance/CollectionLiteralInLoop: Avoid immutable Array literals in loops. It is better to extract it into a local variable or a constant.

    ```rb
            [ ...
    ```

  * **Line # 240 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 272 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
              allow_any_instance_of(Reservation).to receive(:cancelled!).and_return(false)
    ```

  * **Line # 275 - convention:** RSpec/AnyInstance: Avoid stubbing using `allow_any_instance_of`.

    ```rb
              allow_any_instance_of(Reservation).to receive(:errors).and_return(errors)
    ```

  * **Line # 281 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "renders errors" do
    ```

### spec/controllers/v1/reservations_controller/reservations_controller.create_spec.rb - (202 offenses)
  * **Line # 51 - convention:** RSpec/ExpectChange: Prefer `change(Nexi::HttpRequest, :count)`.

    ```rb
        it { expect { req }.to(change { Nexi::HttpRequest.count }.by(1)) }
    ```

  * **Line # 73 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe V1::ReservationsController, type: :controller do
    ```

  * **Line # 120 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:post, "/v1/reservations").to(format: :json, action: :create,
    ```

  * **Line # 132 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
          it { expect { req }.to change { Reservation.count }.by(1) }
    ```

  * **Line # 134 - convention:** RSpec/MissingExampleGroupArgument: The first argument to `context` should not be empty.

    ```rb
          context do ...
    ```

  * **Line # 146 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
          it { expect { req }.to change { Reservation.count }.by(1) }
    ```

  * **Line # 148 - convention:** RSpec/MissingExampleGroupArgument: The first argument to `context` should not be empty.

    ```rb
          context do ...
    ```

  * **Line # 160 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
          it { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 162 - convention:** RSpec/MissingExampleGroupArgument: The first argument to `context` should not be empty.

    ```rb
          context do ...
    ```

  * **Line # 178 - convention:** Layout/LineLength: Line is too long. [129/120]

    ```rb
          context "when providing a #{scenario[:name]} date, should create a reservation for turn with weekday=#{scenario[:wday]}" do
    ```

  * **Line # 180 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:turn) do
    ```

  * **Line # 190 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
          let!(:turn) do
    ```

  * **Line # 209 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { doit }.to(change { Reservation.count }) }
    ```

  * **Line # 226 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
              it { expect { doit }.to(change { Reservation.count }) }
    ```

  * **Line # 244 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
              it { expect { doit }.not_to(change { Reservation.count }) }
    ```

  * **Line # 260 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
          let!(:turn) do
    ```

  * **Line # 331 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it do
    ```

  * **Line # 357 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it do
    ```

  * **Line # 364 - convention:** Layout/LineLength: Line is too long. [122/120]

    ```rb
        context "when a 'weekly' Holiday exists (closed only on the morning while the reservation is made for the evening)" do
    ```

  * **Line # 365 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
          let!(:holiday) do
    ```

  * **Line # 378 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it do
    ```

  * **Line # 393 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
              it do
    ```

  * **Line # 403 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
          let!(:holiday) do
    ```

  * **Line # 416 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it do
    ```

  * **Line # 426 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
          it { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 428 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it do
    ```

  * **Line # 439 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.to(change { Reservation.count }.by(1)) }
    ```

  * **Line # 442 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 454 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 456 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 472 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.to change { Reservation.count }.by(1) }
    ```

  * **Line # 474 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it do
    ```

  * **Line # 485 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.to change { Reservation.count }.by(1) }
    ```

  * **Line # 487 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it do
    ```

  * **Line # 509 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.to change { Reservation.count }.by(1) }
    ```

  * **Line # 511 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it do
    ```

  * **Line # 522 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.to change { Reservation.count }.by(1) }
    ```

  * **Line # 524 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it do
    ```

  * **Line # 536 - convention:** Layout/LineLength: Line is too long. [127/120]

    ```rb
                         "#{Config.app.dig!(:nexi_api_url)}/#{Config.app.dig!(:nexi_simple_payment_path)}").to_return do |_request|
    ```

  * **Line # 539 - convention:** Rails/FilePath: Prefer `Rails.root.join('path/to')`.

    ```rb
                body: File.read(Rails.root.join("spec", "fixtures", "nexi-error-page.html"))
    ```

  * **Line # 561 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 562 - convention:** RSpec/ExpectChange: Prefer `change(ReservationPayment, :count)`.

    ```rb
            it { expect { req }.not_to(change { ReservationPayment.count }) }
    ```

  * **Line # 563 - convention:** RSpec/ExpectChange: Prefer `change(Nexi::HttpRequest, :count)`.

    ```rb
            it { expect { req }.to(change { Nexi::HttpRequest.count }.by(1)) }
    ```

  * **Line # 566 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 577 - convention:** Layout/LineLength: Line is too long. [127/120]

    ```rb
                         "#{Config.app.dig!(:nexi_api_url)}/#{Config.app.dig!(:nexi_simple_payment_path)}").to_return do |_request|
    ```

  * **Line # 602 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 603 - convention:** RSpec/ExpectChange: Prefer `change(ReservationPayment, :count)`.

    ```rb
            it { expect { req }.not_to(change { ReservationPayment.count }) }
    ```

  * **Line # 604 - convention:** RSpec/ExpectChange: Prefer `change(Nexi::HttpRequest, :count)`.

    ```rb
            it { expect { req }.to(change { Nexi::HttpRequest.count }.by(1)) }
    ```

  * **Line # 607 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 618 - convention:** Layout/LineLength: Line is too long. [127/120]

    ```rb
                         "#{Config.app.dig!(:nexi_api_url)}/#{Config.app.dig!(:nexi_simple_payment_path)}").to_return do |_request|
    ```

  * **Line # 626 - convention:** Rails/FilePath: Prefer `Rails.root.join('path/to')`.

    ```rb
            File.read(Rails.root.join("spec", "fixtures", "nexi-unauthorized-page.html"))
    ```

  * **Line # 640 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 641 - convention:** RSpec/ExpectChange: Prefer `change(ReservationPayment, :count)`.

    ```rb
            it { expect { req }.not_to(change { ReservationPayment.count }) }
    ```

  * **Line # 642 - convention:** RSpec/ExpectChange: Prefer `change(Nexi::HttpRequest, :count)`.

    ```rb
            it { expect { req }.to(change { Nexi::HttpRequest.count }.by(1)) }
    ```

  * **Line # 665 - convention:** Layout/LineLength: Line is too long. [127/120]

    ```rb
                         "#{Config.app.dig!(:nexi_api_url)}/#{Config.app.dig!(:nexi_simple_payment_path)}").to_return do |_request|
    ```

  * **Line # 673 - convention:** Rails/FilePath: Prefer `Rails.root.join('path/to')`.

    ```rb
            File.read(Rails.root.join("spec", "fixtures", "nexi-simple-payment-success-page.html"))
    ```

  * **Line # 677 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:group) do
    ```

  * **Line # 684 - convention:** Layout/SpaceAfterComma: Space missing after comma.

    ```rb
              let(:adults) { [2,3,4,5].sample }
    ```

  * **Line # 684 - convention:** Layout/SpaceAfterComma: Space missing after comma.

    ```rb
              let(:adults) { [2,3,4,5].sample }
    ```

  * **Line # 684 - convention:** Layout/SpaceAfterComma: Space missing after comma.

    ```rb
              let(:adults) { [2,3,4,5].sample }
    ```

  * **Line # 687 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
              it { expect { req }.to(change { Reservation.count }) }
    ```

  * **Line # 688 - convention:** RSpec/ExpectChange: Prefer `change(ReservationPayment, :count)`.

    ```rb
              it { expect { req }.not_to(change { ReservationPayment.count }) }
    ```

  * **Line # 690 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
              it do
    ```

  * **Line # 698 - convention:** Layout/SpaceAfterComma: Space missing after comma.

    ```rb
              let(:adults) { [6,7,8].sample }
    ```

  * **Line # 698 - convention:** Layout/SpaceAfterComma: Space missing after comma.

    ```rb
              let(:adults) { [6,7,8].sample }
    ```

  * **Line # 701 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
              it { expect { req }.to(change { Reservation.count }) }
    ```

  * **Line # 702 - convention:** RSpec/ExpectChange: Prefer `change(ReservationPayment, :count)`.

    ```rb
              it { expect { req }.to(change { ReservationPayment.count }) }
    ```

  * **Line # 704 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
              it do
    ```

  * **Line # 721 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.to(change { Reservation.count }.by(1)) }
    ```

  * **Line # 723 - convention:** RSpec/ExpectChange: Prefer `change(ReservationPayment, :count)`.

    ```rb
            it { expect { req }.to(change { ReservationPayment.count }.by(1)) }
    ```

  * **Line # 724 - convention:** RSpec/ExpectChange: Prefer `change(Nexi::HttpRequest, :count)`.

    ```rb
            it { expect { req }.to(change { Nexi::HttpRequest.count }.by(1)) }
    ```

  * **Line # 742 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.to(change { Reservation.count }.by(1)) }
    ```

  * **Line # 743 - convention:** RSpec/ExpectChange: Prefer `change(ReservationPayment, :count)`.

    ```rb
            it { expect { req }.to(change { ReservationPayment.count }.by(1)) }
    ```

  * **Line # 744 - convention:** RSpec/ExpectChange: Prefer `change(Nexi::HttpRequest, :count)`.

    ```rb
            it { expect { req }.to(change { Nexi::HttpRequest.count }.by(1)) }
    ```

  * **Line # 765 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.to(change { Reservation.count }.by(1)) }
    ```

  * **Line # 766 - convention:** RSpec/ExpectChange: Prefer `change(ReservationPayment, :count)`.

    ```rb
            it { expect { req }.to(change { ReservationPayment.count }.by(1)) }
    ```

  * **Line # 767 - convention:** RSpec/ExpectChange: Prefer `change(Nexi::HttpRequest, :count)`.

    ```rb
            it { expect { req }.to(change { Nexi::HttpRequest.count }.by(1)) }
    ```

  * **Line # 771 - convention:** Layout/LineLength: Line is too long. [126/120]

    ```rb
              expect(ActionMailer::MailDeliveryJob).to have_been_enqueued.with("ReservationMailer", "payment_required_to_confirm",
    ```

  * **Line # 772 - convention:** Layout/LineLength: Line is too long. [128/120]

    ```rb
                                                                               "deliver_now", params: anything, args: anything).once
    ```

  * **Line # 775 - convention:** RSpec/ExampleLength: Example has too many lines. [23/5]

    ```rb
            it do ...
    ```

  * **Line # 775 - convention:** RSpec/MultipleExpectations: Example has too many expectations [22/1].

    ```rb
            it do
    ```

  * **Line # 798 - convention:** Layout/LineLength: Line is too long. [144/120]

    ```rb
              expect(Nexi::HttpRequest.last.request_body.dig!("urlpost")).to eq(Rails.application.routes.url_helpers.nexi_receive_order_outcome_url)
    ```

  * **Line # 801 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 814 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
                it { expect { req }.to(change { Reservation.count }.by(1)) }
    ```

  * **Line # 817 - convention:** RSpec/ExpectChange: Prefer `change(Nexi::HttpRequest, :count)`.

    ```rb
                it { expect { req }.to(change { Nexi::HttpRequest.count }.by(1)) }
    ```

  * **Line # 819 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
                it do
    ```

  * **Line # 825 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
                it do
    ```

  * **Line # 835 - convention:** Style/SingleArgumentDig: Use `Nexi::HttpRequest.last.request_body["languageId"]` instead of `Nexi::HttpRequest.last.request_body.dig("languageId")`.

    ```rb
                  expect(Nexi::HttpRequest.last.request_body.dig("languageId")).to eq(scenario[:code])
    ```

  * **Line # 870 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
                it { expect { req }.to(change { Reservation.count }.by(1)) }
    ```

  * **Line # 872 - convention:** RSpec/ExpectChange: Prefer `change(ReservationPayment, :count)`.

    ```rb
                it { expect { req }.to(change { ReservationPayment.count }.by(1)) }
    ```

  * **Line # 878 - convention:** RSpec/ExpectInHook: Do not use `expect` in `before` hook

    ```rb
                    expect(Reservation.where(table_type:).pluck(:adults, :children).flatten.sum).to eq 15
    ```

  * **Line # 879 - convention:** RSpec/ExpectInHook: Do not use `expect` in `before` hook

    ```rb
                    expect(Reservation.pluck(:adults, :children).flatten.sum).to eq 15
    ```

  * **Line # 882 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
                  it do
    ```

  * **Line # 910 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
                      let(:datetime_18) { "#{date.to_date} 18:00" }
    ```

  * **Line # 910 - convention:** Naming/VariableNumber: Use normalcase for symbol numbers.

    ```rb
                      let(:datetime_18) { "#{date.to_date} 18:00" }
    ```

  * **Line # 911 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
                      let(:datetime_21) { "#{date.to_date} 21:00" }
    ```

  * **Line # 911 - convention:** Naming/VariableNumber: Use normalcase for symbol numbers.

    ```rb
                      let(:datetime_21) { "#{date.to_date} 21:00" }
    ```

  * **Line # 914 - convention:** RSpec/ExpectInHook: Do not use `expect` in `before` hook

    ```rb
                        expect do
    ```

  * **Line # 921 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
                      it do
    ```

  * **Line # 949 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
                      let(:datetime_18) { "#{date.to_date} 18:00" }
    ```

  * **Line # 949 - convention:** Naming/VariableNumber: Use normalcase for symbol numbers.

    ```rb
                      let(:datetime_18) { "#{date.to_date} 18:00" }
    ```

  * **Line # 950 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
                      let(:datetime_1830) { "#{date.to_date} 18:30" }
    ```

  * **Line # 950 - convention:** Naming/VariableNumber: Use normalcase for symbol numbers.

    ```rb
                      let(:datetime_1830) { "#{date.to_date} 18:30" }
    ```

  * **Line # 951 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
                      let(:datetime_21) { "#{date.to_date} 21:00" }
    ```

  * **Line # 951 - convention:** Naming/VariableNumber: Use normalcase for symbol numbers.

    ```rb
                      let(:datetime_21) { "#{date.to_date} 21:00" }
    ```

  * **Line # 952 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
                      let(:datetime_2130) { "#{date.to_date} 21:30" }
    ```

  * **Line # 952 - convention:** Naming/VariableNumber: Use normalcase for symbol numbers.

    ```rb
                      let(:datetime_2130) { "#{date.to_date} 21:30" }
    ```

  * **Line # 954 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
                      let!(:turn) do
    ```

  * **Line # 959 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
                      let!(:turn2) do
    ```

  * **Line # 974 - convention:** Performance/CollectionLiteralInLoop: Avoid immutable Array literals in loops. It is better to extract it into a local variable or a constant.

    ```rb
                        Reservation.all.each { |r| r.update!(status: %w[deleted cancelled].sample) }
    ```

  * **Line # 983 - convention:** RSpec/ExpectInHook: Do not use `expect` in `before` hook

    ```rb
                        expect do
    ```

  * **Line # 987 - convention:** RSpec/ExpectInHook: Do not use `expect` in `before` hook

    ```rb
                        expect do
    ```

  * **Line # 998 - convention:** Layout/LineLength: Line is too long. [124/120]

    ```rb
              context "when base payment requires an authorization, if table_type is specified will create a payment instead" do
    ```

  * **Line # 1007 - convention:** Layout/LineLength: Line is too long. [139/120]

    ```rb
              context "when base payment requires an authorization, if table_type is not present will create an authorization (as expected)" do
    ```

  * **Line # 1016 - convention:** Layout/LineLength: Line is too long. [123/120]

    ```rb
              context "when base payment requires a payment, if table_type is specified will create a payment (as expected)" do
    ```

  * **Line # 1024 - convention:** Layout/LineLength: Line is too long. [125/120]

    ```rb
              context "when base payment requires a payment, if table_type is not present will create a payment (as expected)" do
    ```

  * **Line # 1049 - convention:** RSpec/ExpectChange: Prefer `change(ReservationPayment, :count)`.

    ```rb
                it { expect { req }.not_to(change { ReservationPayment.count }) }
    ```

  * **Line # 1057 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
                it do
    ```

  * **Line # 1064 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
                it { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 1065 - convention:** RSpec/ExpectChange: Prefer `change(ReservationPayment, :count)`.

    ```rb
                it { expect { req }.not_to(change { ReservationPayment.count }) }
    ```

  * **Line # 1071 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
                it do
    ```

  * **Line # 1078 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
                it { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 1079 - convention:** RSpec/ExpectChange: Prefer `change(ReservationPayment, :count)`.

    ```rb
                it { expect { req }.not_to(change { ReservationPayment.count }) }
    ```

  * **Line # 1085 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
                it do
    ```

  * **Line # 1092 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
                it { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 1093 - convention:** RSpec/ExpectChange: Prefer `change(ReservationPayment, :count)`.

    ```rb
                it { expect { req }.not_to(change { ReservationPayment.count }) }
    ```

  * **Line # 1128 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
                it { expect { req }.to(change { Reservation.count }.by(1)) }
    ```

  * **Line # 1129 - convention:** RSpec/ExpectChange: Prefer `change(ReservationPayment, :count)`.

    ```rb
                it { expect { req }.to(change { ReservationPayment.count }.by(1)) }
    ```

  * **Line # 1130 - convention:** RSpec/ExpectChange: Prefer `change(Nexi::HttpRequest, :count)`.

    ```rb
                it { expect { req }.to(change { Nexi::HttpRequest.count }.by(1)) }
    ```

  * **Line # 1132 - convention:** RSpec/ExampleLength: Example has too many lines. [8/5]

    ```rb
                it do ...
    ```

  * **Line # 1132 - convention:** RSpec/MultipleExpectations: Example has too many expectations [7/1].

    ```rb
                it do
    ```

  * **Line # 1143 - convention:** RSpec/ExampleLength: Example has too many lines. [6/5]

    ```rb
                it do ...
    ```

  * **Line # 1143 - convention:** RSpec/MultipleExpectations: Example has too many expectations [5/1].

    ```rb
                it do
    ```

  * **Line # 1152 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
                it do
    ```

  * **Line # 1169 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
                it { expect { req }.to(change { Reservation.count }.by(1)) }
    ```

  * **Line # 1170 - convention:** RSpec/ExpectChange: Prefer `change(ReservationPayment, :count)`.

    ```rb
                it { expect { req }.not_to(change { ReservationPayment.count }) }
    ```

  * **Line # 1171 - convention:** RSpec/ExpectChange: Prefer `change(Nexi::HttpRequest, :count)`.

    ```rb
                it { expect { req }.not_to(change { Nexi::HttpRequest.count }) }
    ```

  * **Line # 1183 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
                it do
    ```

  * **Line # 1203 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it "creates a reservation" do
    ```

  * **Line # 1212 - convention:** Layout/LineLength: Line is too long. [121/120]

    ```rb
                                                                             "deliver_now", params: anything, args: anything)
    ```

  * **Line # 1233 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:turn) do
    ```

  * **Line # 1238 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "returns 422" do
    ```

  * **Line # 1249 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "returns 422" do
    ```

  * **Line # 1260 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.to(change { Reservation.count }.by(1)) }
    ```

  * **Line # 1277 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.to(change { Reservation.count }.by(1)) }
    ```

  * **Line # 1304 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
                it "returns 422" do
    ```

  * **Line # 1328 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
                it "returns 422" do
    ```

  * **Line # 1343 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
            it "returns 422" do
    ```

  * **Line # 1356 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
            it "returns 422" do
    ```

  * **Line # 1368 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
            it "returns 422" do
    ```

  * **Line # 1381 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
            it "returns 422" do
    ```

  * **Line # 1393 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "returns 422" do
    ```

  * **Line # 1404 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "returns 422" do
    ```

  * **Line # 1415 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "returns 422" do
    ```

  * **Line # 1426 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "returns 422" do
    ```

  * **Line # 1437 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "returns 422" do
    ```

  * **Line # 1448 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "returns 422" do
    ```

  * **Line # 1459 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.to change { Reservation.count }.by(1) }
    ```

  * **Line # 1461 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "returns 200 and create record" do
    ```

  * **Line # 1471 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.to change { Reservation.count }.by(1) }
    ```

  * **Line # 1473 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "returns 200 and create record" do
    ```

  * **Line # 1483 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.to change { Reservation.count }.by(1) }
    ```

  * **Line # 1485 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it "returns 200 and create record" do
    ```

  * **Line # 1492 - convention:** Layout/LineLength: Line is too long. [129/120]

    ```rb
          context 'should create a reservation with "<firstname> <lastname>" as fullname and save the detail in the "other" field' do
    ```

  * **Line # 1496 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
            it "creates a reservation" do
    ```

  * **Line # 1509 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
            it "creates a reservation" do
    ```

  * **Line # 1522 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
            it "creates a reservation" do
    ```

  * **Line # 1531 - convention:** RSpec/RepeatedExampleGroupBody: Repeated context block body on line(s) [1593]

    ```rb
          context "when email is empty" do ...
    ```

  * **Line # 1531 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [1593]

    ```rb
          context "when email is empty" do ...
    ```

  * **Line # 1534 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 1536 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "returns 422" do
    ```

  * **Line # 1544 - convention:** RSpec/RepeatedExampleGroupBody: Repeated context block body on line(s) [1606]

    ```rb
          context "when email is nil" do ...
    ```

  * **Line # 1544 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [1606]

    ```rb
          context "when email is nil" do ...
    ```

  * **Line # 1547 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 1549 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "returns 422" do
    ```

  * **Line # 1557 - convention:** RSpec/RepeatedExampleGroupBody: Repeated context block body on line(s) [1619]

    ```rb
          context "when email is invalid" do ...
    ```

  * **Line # 1557 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [1619]

    ```rb
          context "when email is invalid" do ...
    ```

  * **Line # 1567 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
                it { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 1569 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
                it "returns 422" do
    ```

  * **Line # 1580 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:reservation) { create(:reservation, datetime:, email:) }
    ```

  * **Line # 1582 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 1584 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
            it "returns 422" do
    ```

  * **Line # 1593 - convention:** RSpec/RepeatedExampleGroupBody: Repeated context block body on line(s) [1531]

    ```rb
          context "when email is empty" do ...
    ```

  * **Line # 1593 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [1531]

    ```rb
          context "when email is empty" do ...
    ```

  * **Line # 1596 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 1598 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "returns 422" do
    ```

  * **Line # 1606 - convention:** RSpec/RepeatedExampleGroupBody: Repeated context block body on line(s) [1544]

    ```rb
          context "when email is nil" do ...
    ```

  * **Line # 1606 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [1544]

    ```rb
          context "when email is nil" do ...
    ```

  * **Line # 1609 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 1611 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "returns 422" do
    ```

  * **Line # 1619 - convention:** RSpec/RepeatedExampleGroupBody: Repeated context block body on line(s) [1557]

    ```rb
          context "when email is invalid" do ...
    ```

  * **Line # 1619 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [1557]

    ```rb
          context "when email is invalid" do ...
    ```

  * **Line # 1629 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
                it { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 1631 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
                it "returns 422" do
    ```

  * **Line # 1644 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 1646 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "returns 422" do
    ```

  * **Line # 1657 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
            it { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 1659 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it "returns 422" do
    ```

  * **Line # 1679 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
                it { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 1681 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
                it "returns 422" do
    ```

  * **Line # 1714 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
                it { expect { req }.to change { Reservation.count }.by(1) }
    ```

  * **Line # 1722 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
                it "returns 200" do
    ```

### spec/controllers/v1/reservations_controller/reservations_controller.show_spec.rb - (8 offenses)
  * **Line # 5 - convention:** RSpec/FilePath: Spec path should end with `v1/reservations_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::ReservationsController, type: :controller do
    ```

  * **Line # 5 - convention:** RSpec/SpecFilePathFormat: Spec path should end with `v1/reservations_controller*_spec.rb`.

    ```rb
    RSpec.describe V1::ReservationsController, type: :controller do
    ```

  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe V1::ReservationsController, type: :controller do
    ```

  * **Line # 18 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
          expect(subject).to route(:get, "/v1/reservations/supersecret").to(format: :json, action: :show, controller: "v1/reservations",
    ```

  * **Line # 18 - convention:** Layout/LineLength: Line is too long. [132/120]

    ```rb
          expect(subject).to route(:get, "/v1/reservations/supersecret").to(format: :json, action: :show, controller: "v1/reservations",
    ```

  * **Line # 43 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 56 - convention:** RSpec/ExampleLength: Example has too many lines. [13/5]

    ```rb
              it { ...
    ```

  * **Line # 57 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

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

### spec/interactions/fetch_reservation_payment_status_spec.rb - (12 offenses)
  * **Line # 30 - convention:** Layout/LineLength: Line is too long. [121/120]

    ```rb
                     "#{Config.app.dig!(:nexi_api_url)}/#{Config.app.dig!(:nexi_order_status_path)}").to_return do |_request|
    ```

  * **Line # 47 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
        it { expect { subject }.not_to(change { reservation_payment.reload.status }) }
    ```

  * **Line # 48 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
        it { expect { subject }.not_to(change { reservation_payment.reload.as_json }) }
    ```

  * **Line # 61 - convention:** RSpec/ExampleLength: Example has too many lines. [11/5]

    ```rb
            it do ...
    ```

  * **Line # 61 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
            it do
    ```

  * **Line # 63 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect { subject }.to(change do
    ```

  * **Line # 68 - convention:** RSpec/RepeatedSubjectCall: Calls to subject are memoized, this block is misleading

    ```rb
                expect { subject }.to(change do
    ```

  * **Line # 68 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
                expect { subject }.to(change do
    ```

  * **Line # 82 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 83 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.not_to(change { reservation_payment.reload.status }.from("todo"))
    ```

  * **Line # 94 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 95 - convention:** RSpec/NamedSubject: Name your test subject if you need to reference it explicitly.

    ```rb
              expect { subject }.to(change { reservation_payment.reload.status }.from("todo").to("refunded"))
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

### spec/matchers/active_interaction_matchers.rb - (2 offenses)
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

### spec/models/preorder_reservation_group_spec.rb - (8 offenses)
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

  * **Line # 41 - convention:** RSpec/ExpectChange: Prefer `change(TableTypeToPreorderReservationGroup, :count)`.

    ```rb
        it { expect { group.destroy! }.to(change { TableTypeToPreorderReservationGroup.count }.to(0)) }
    ```

  * **Line # 42 - convention:** RSpec/ExpectChange: Prefer `change(PreorderReservationGroup, :count)`.

    ```rb
        it { expect { group.destroy! }.to(change { PreorderReservationGroup.count }.to(0)) }
    ```

  * **Line # 42 - convention:** RSpec/DescribedClass: Use `described_class` instead of `PreorderReservationGroup`.

    ```rb
        it { expect { group.destroy! }.to(change { PreorderReservationGroup.count }.to(0)) }
    ```

  * **Line # 43 - convention:** RSpec/ExpectChange: Prefer `change(TableType, :count)`.

    ```rb
        it { expect { group.destroy! }.not_to(change { TableType.count }) }
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

### spec/models/table_type_spec.rb - (3 offenses)
  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.describe TableType, type: :model do
    ```

  * **Line # 9 - convention:** RSpec/Rails/NegationBeValid: Use `expect(...).not_to be_valid`.

    ```rb
      it { expect(build(:table_type, default_people_per_turn: 0)).to be_invalid }
    ```

  * **Line # 10 - convention:** RSpec/Rails/NegationBeValid: Use `expect(...).not_to be_valid`.

    ```rb
      it { expect(build(:table_type, default_people_per_turn: -1)).to be_invalid }
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

### spec/requests/v1/admin/menu/dishes_controller/menu_dishes_controller.bulk_update_status_spec.rb - (8 offenses)
  * **Line # 90 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
        let!(:default_params) { super().except(:status) }
    ```

  * **Line # 96 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
        let!(:default_params) { super().merge(status: "") }
    ```

  * **Line # 102 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
        let!(:default_params) { super().merge(status: "something-invalid") }
    ```

  * **Line # 108 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
        let!(:default_params) { super().except(:dish_ids) }
    ```

  * **Line # 114 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
        let!(:default_params) { super().merge(dish_ids: []) }
    ```

  * **Line # 120 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
        let!(:default_params) { super().merge(dish_ids: [*dish_ids, -1]) }
    ```

  * **Line # 126 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
        let!(:default_params) { super().merge(dish_ids: dishes.first.id) }
    ```

  * **Line # 136 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:default_params) { super().merge(params_options[:default] => nil, variant => dishes.map(&:id)) }
    ```

### spec/requests/v1/admin/menu/dishes_controller/menu_dishes_controller.relocate_spec.rb - (13 offenses)
  * **Line # 74 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
        let!(:default_params) { super().except(:from_category_id) }
    ```

  * **Line # 76 - convention:** RSpec/ExpectChange: Prefer `change(Menu::DishesInCategory, :count)`.

    ```rb
        it { expect { req }.to(change { Menu::DishesInCategory.count }.by(dishes.count)) }
    ```

  * **Line # 82 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
        let!(:default_params) { super().except(:to_category_id) }
    ```

  * **Line # 84 - convention:** RSpec/ExpectChange: Prefer `change(Menu::DishesInCategory, :count)`.

    ```rb
        it { expect { req }.to(change { Menu::DishesInCategory.count }.by(dishes.count * -1)) }
    ```

  * **Line # 90 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
        let!(:default_params) { super().merge(dish_ids: nil) }
    ```

  * **Line # 96 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
        let!(:default_params) { super().merge(from_category_id: -1) }
    ```

  * **Line # 102 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
        let!(:default_params) { super().merge(to_category_id: -1) }
    ```

  * **Line # 122 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
        let!(:default_params) { super().merge(dish_ids: []) }
    ```

  * **Line # 128 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
        let!(:default_params) { super().merge(dish_ids: [*dish_ids, -1]) }
    ```

  * **Line # 138 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
        let!(:default_params) { super().merge(dish_ids: [dishes.first.id]) }
    ```

  * **Line # 144 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
        let!(:default_params) { super().merge(dish_ids: dishes.first.id) }
    ```

  * **Line # 146 - convention:** RSpec/ExpectChange: Prefer `change(Menu::DishesInCategory, :count)`.

    ```rb
        it { expect { req }.not_to(change { Menu::DishesInCategory.count }) }
    ```

  * **Line # 162 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
            let!(:default_params) { super().merge(params_options[:default] => nil, variant => dishes.map(&:id)) }
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

### spec/requests/v1/admin/preorder_reservation_groups/preorder_reservation_groups.create_spec.rb - (45 offenses)
  * **Line # 39 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(p = params, h = headers)
    ```

  * **Line # 39 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(p = params, h = headers)
    ```

  * **Line # 76 - convention:** RSpec/ExampleLength: Example has too many lines. [10/5]

    ```rb
          it do ...
    ```

  * **Line # 106 - convention:** RSpec/ExampleLength: Example has too many lines. [11/5]

    ```rb
          it do ...
    ```

  * **Line # 149 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [166]

    ```rb
        context "when trying to add same turn to a new group" do ...
    ```

  * **Line # 162 - convention:** RSpec/ExpectChange: Prefer `change(PreorderReservationGroup, :count)`.

    ```rb
          it { expect { req }.not_to(change { PreorderReservationGroup.count }) }
    ```

  * **Line # 163 - convention:** RSpec/ExpectChange: Prefer `change(PreorderReservationGroupsToTurn, :count)`.

    ```rb
          it { expect { req }.not_to(change { PreorderReservationGroupsToTurn.count }) }
    ```

  * **Line # 166 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [149]

    ```rb
        context "when trying to add same turn to a new group" do ...
    ```

  * **Line # 179 - convention:** RSpec/ExpectChange: Prefer `change(PreorderReservationGroup, :count)`.

    ```rb
          it { expect { req }.not_to(change { PreorderReservationGroup.count }) }
    ```

  * **Line # 180 - convention:** RSpec/ExpectChange: Prefer `change(PreorderReservationGroupsToTurn, :count)`.

    ```rb
          it { expect { req }.not_to(change { PreorderReservationGroupsToTurn.count }) }
    ```

  * **Line # 200 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [217]

    ```rb
        context "when trying to add same turn to a new group" do ...
    ```

  * **Line # 213 - convention:** RSpec/ExpectChange: Prefer `change(PreorderReservationGroup, :count)`.

    ```rb
          it { expect { req }.not_to(change { PreorderReservationGroup.count }) }
    ```

  * **Line # 214 - convention:** RSpec/ExpectChange: Prefer `change(PreorderReservationGroupsToTurn, :count)`.

    ```rb
          it { expect { req }.not_to(change { PreorderReservationGroupsToTurn.count }) }
    ```

  * **Line # 217 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [200]

    ```rb
        context "when trying to add same turn to a new group" do ...
    ```

  * **Line # 230 - convention:** RSpec/ExpectChange: Prefer `change(PreorderReservationGroup, :count)`.

    ```rb
          it { expect { req }.not_to(change { PreorderReservationGroup.count }) }
    ```

  * **Line # 231 - convention:** RSpec/ExpectChange: Prefer `change(PreorderReservationGroupsToTurn, :count)`.

    ```rb
          it { expect { req }.not_to(change { PreorderReservationGroupsToTurn.count }) }
    ```

  * **Line # 235 - convention:** Layout/LineLength: Line is too long. [142/120]

    ```rb
      context "when providing many dates for same turn - real-life scenario where on certain dates the reservations can be created only paying" do
    ```

  * **Line # 245 - convention:** RSpec/ExpectChange: Prefer `change(PreorderReservationGroup, :count)`.

    ```rb
        it { expect { req }.to(change { PreorderReservationGroup.count }.by(1)) }
    ```

  * **Line # 246 - convention:** RSpec/ExpectChange: Prefer `change(PreorderReservationDate, :count)`.

    ```rb
        it { expect { req }.to(change { PreorderReservationDate.count }.by(4)) }
    ```

  * **Line # 247 - convention:** RSpec/ExpectChange: Prefer `change(PreorderReservationGroupsToTurn, :count)`.

    ```rb
        it { expect { req }.not_to(change { PreorderReservationGroupsToTurn.count }) }
    ```

  * **Line # 259 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it do
    ```

  * **Line # 267 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
        let(:turn2) { create(:reservation_turn, weekday: 1) }
    ```

  * **Line # 268 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
        let(:turn3) { create(:reservation_turn, weekday: 2) }
    ```

  * **Line # 269 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
        let(:turn4) { create(:reservation_turn, weekday: 2) }
    ```

  * **Line # 284 - convention:** RSpec/ExpectChange: Prefer `change(PreorderReservationGroup, :count)`.

    ```rb
        it { expect { req }.to(change { PreorderReservationGroup.count }.by(1)) }
    ```

  * **Line # 285 - convention:** RSpec/ExpectChange: Prefer `change(PreorderReservationDate, :count)`.

    ```rb
        it { expect { req }.to(change { PreorderReservationDate.count }.by(5)) }
    ```

  * **Line # 286 - convention:** RSpec/ExpectChange: Prefer `change(PreorderReservationGroupsToTurn, :count)`.

    ```rb
        it { expect { req }.to(change { PreorderReservationGroupsToTurn.count }.by(1)) }
    ```

  * **Line # 298 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
        it do
    ```

  * **Line # 324 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [343]

    ```rb
        context "when adding some turn to the new group, should receive 422" do ...
    ```

  * **Line # 338 - convention:** RSpec/ExpectChange: Prefer `change(PreorderReservationGroup, :count)`.

    ```rb
          it { expect { req }.not_to(change { PreorderReservationGroup.count }) }
    ```

  * **Line # 339 - convention:** RSpec/ExpectChange: Prefer `change(PreorderReservationDate, :count)`.

    ```rb
          it { expect { req }.not_to(change { PreorderReservationDate.count }) }
    ```

  * **Line # 340 - convention:** RSpec/ExpectChange: Prefer `change(PreorderReservationGroupsToTurn, :count)`.

    ```rb
          it { expect { req }.not_to(change { PreorderReservationGroupsToTurn.count }) }
    ```

  * **Line # 343 - convention:** RSpec/RepeatedExampleGroupDescription: Repeated context block description on line(s) [324]

    ```rb
        context "when adding some turn to the new group, should receive 422" do ...
    ```

  * **Line # 359 - convention:** RSpec/ExpectChange: Prefer `change(PreorderReservationGroup, :count)`.

    ```rb
          it { expect { req }.not_to(change { PreorderReservationGroup.count }) }
    ```

  * **Line # 360 - convention:** RSpec/ExpectChange: Prefer `change(PreorderReservationDate, :count)`.

    ```rb
          it { expect { req }.not_to(change { PreorderReservationDate.count }) }
    ```

  * **Line # 361 - convention:** RSpec/ExpectChange: Prefer `change(PreorderReservationGroupsToTurn, :count)`.

    ```rb
          it { expect { req }.not_to(change { PreorderReservationGroupsToTurn.count }) }
    ```

  * **Line # 392 - convention:** RSpec/PredicateMatcher: Prefer using `be_deferred` matcher over `deferred?`.

    ```rb
          it { expect(PreorderReservationGroup.last.deferred?).to be_truthy }
    ```

  * **Line # 399 - convention:** RSpec/RepeatedExample: Don't repeat examples within an example group.

    ```rb
        it { expect { req }.not_to(change { PreorderReservationGroup.count }) }
    ```

  * **Line # 399 - convention:** RSpec/ExpectChange: Prefer `change(PreorderReservationGroup, :count)`.

    ```rb
        it { expect { req }.not_to(change { PreorderReservationGroup.count }) }
    ```

  * **Line # 411 - convention:** RSpec/RepeatedExample: Don't repeat examples within an example group.

    ```rb
        it { expect { req }.not_to(change { PreorderReservationGroup.count }) }
    ```

  * **Line # 411 - convention:** RSpec/ExpectChange: Prefer `change(PreorderReservationGroup, :count)`.

    ```rb
        it { expect { req }.not_to(change { PreorderReservationGroup.count }) }
    ```

  * **Line # 412 - convention:** RSpec/ExpectChange: Prefer `change(PreorderReservationGroupsToTurn, :count)`.

    ```rb
        it { expect { req }.not_to(change { PreorderReservationGroupsToTurn.count }) }
    ```

  * **Line # 443 - convention:** RSpec/ExpectChange: Prefer `change(TableTypeToPreorderReservationGroup, :count)`.

    ```rb
          it { expect { req }.not_to(change { TableTypeToPreorderReservationGroup.count }) }
    ```

  * **Line # 457 - convention:** RSpec/ExpectChange: Prefer `change(TableTypeToPreorderReservationGroup, :count)`.

    ```rb
          it { expect { req }.not_to(change { TableTypeToPreorderReservationGroup.count }) }
    ```

  * **Line # 478 - convention:** RSpec/ExpectChange: Prefer `change(TableTypeToPreorderReservationGroup, :count)`.

    ```rb
          it { expect { req }.to(change { TableTypeToPreorderReservationGroup.count }.by(1)) }
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

### spec/requests/v1/admin/preorder_reservation_groups/preorder_reservation_groups.index_spec.rb - (5 offenses)
  * **Line # 25 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(p = params, h = headers)
    ```

  * **Line # 25 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(p = params, h = headers)
    ```

  * **Line # 63 - convention:** Layout/LineLength: Line is too long. [125/120]

    ```rb
                                    payment_value: record.payment_value, min_people: nil, created_at: String, updated_at: String)
    ```

  * **Line # 70 - convention:** Layout/LineLength: Line is too long. [124/120]

    ```rb
            expect(item[:turns]).to all(include(id: Integer, name: String, starts_at: String, ends_at: String, weekday: Integer,
    ```

  * **Line # 148 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
          let!(:all_inactive) do
    ```

### spec/requests/v1/admin/preorder_reservation_groups/preorder_reservation_groups.update_spec.rb - (22 offenses)
  * **Line # 49 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(id = group.id, p = params, h = headers)
    ```

  * **Line # 49 - convention:** Naming/MethodParameterName: Method parameter must be at least 3 characters long.

    ```rb
      def req(id = group.id, p = params, h = headers)
    ```

  * **Line # 83 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it do
    ```

  * **Line # 85 - convention:** Style/SingleArgumentDig: Use `json[:item]` instead of `json.dig(:item)`.

    ```rb
          expect(json.dig(:item)).to include(:min_people)
    ```

  * **Line # 89 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it do
    ```

  * **Line # 101 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it do
    ```

  * **Line # 114 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it do
    ```

  * **Line # 116 - convention:** Style/SingleArgumentDig: Use `json[:item]` instead of `json.dig(:item)`.

    ```rb
          expect(json.dig(:item)).to include(:active_from)
    ```

  * **Line # 120 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it do
    ```

  * **Line # 144 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it do
    ```

  * **Line # 162 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it do
    ```

  * **Line # 180 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it do
    ```

  * **Line # 195 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it do
    ```

  * **Line # 215 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
          it do
    ```

  * **Line # 239 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
            it do
    ```

  * **Line # 278 - convention:** RSpec/ExpectChange: Prefer `change(TableTypeToPreorderReservationGroup, :count)`.

    ```rb
          it { expect { req }.not_to(change { TableTypeToPreorderReservationGroup.count }) }
    ```

  * **Line # 292 - convention:** RSpec/ExpectChange: Prefer `change(TableTypeToPreorderReservationGroup, :count)`.

    ```rb
          it { expect { req }.not_to(change { TableTypeToPreorderReservationGroup.count }) }
    ```

  * **Line # 303 - convention:** RSpec/ExpectChange: Prefer `change(TableTypeToPreorderReservationGroup, :count)`.

    ```rb
          it { expect { req }.to(change { TableTypeToPreorderReservationGroup.count }.by(1)) }
    ```

  * **Line # 326 - convention:** RSpec/ExpectChange: Prefer `change(TableTypeToPreorderReservationGroup, :count)`.

    ```rb
            it { expect { req }.to(change { TableTypeToPreorderReservationGroup.count }.by(-1)) }
    ```

  * **Line # 349 - convention:** RSpec/ExpectChange: Prefer `change(TableTypeToPreorderReservationGroup, :count)`.

    ```rb
            it { expect { req }.not_to(change { TableTypeToPreorderReservationGroup.count }) }
    ```

  * **Line # 373 - convention:** RSpec/ExpectChange: Prefer `change(TableTypeToPreorderReservationGroup, :count)`.

    ```rb
            it { expect { req }.not_to(change { TableTypeToPreorderReservationGroup.count }) }
    ```

  * **Line # 394 - convention:** RSpec/ExpectChange: Prefer `change(TableTypeToPreorderReservationGroup, :count)`.

    ```rb
            it { expect { req }.not_to(change { TableTypeToPreorderReservationGroup.count }) }
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

### spec/requests/v1/admin/reservations_controller/reservations_controller.create_payment_spec.rb - (8 offenses)
  * **Line # 39 - convention:** RSpec/ExpectChange: Prefer `change(Reservation, :count)`.

    ```rb
      it { expect { req }.not_to(change { Reservation.count }) }
    ```

  * **Line # 65 - convention:** Layout/LineLength: Line is too long. [123/120]

    ```rb
                     "#{Config.app.dig!(:nexi_api_url)}/#{Config.app.dig!(:nexi_simple_payment_path)}").to_return do |_request|
    ```

  * **Line # 67 - convention:** Rails/FilePath: Prefer `Rails.root.join('path/to')`.

    ```rb
            body: File.read(Rails.root.join("spec", "fixtures", "nexi-simple-payment-success-page.html"))
    ```

  * **Line # 210 - convention:** Layout/LineLength: Line is too long. [125/120]

    ```rb
                       "#{Config.app.dig!(:nexi_api_url)}/#{Config.app.dig!(:nexi_simple_payment_path)}").to_return do |_request|
    ```

  * **Line # 213 - convention:** Rails/FilePath: Prefer `Rails.root.join('path/to')`.

    ```rb
              body: File.read(Rails.root.join("spec", "fixtures", "nexi-error-page.html"))
    ```

  * **Line # 224 - convention:** Layout/LineLength: Line is too long. [125/120]

    ```rb
                       "#{Config.app.dig!(:nexi_api_url)}/#{Config.app.dig!(:nexi_simple_payment_path)}").to_return do |_request|
    ```

  * **Line # 238 - convention:** Layout/LineLength: Line is too long. [125/120]

    ```rb
                       "#{Config.app.dig!(:nexi_api_url)}/#{Config.app.dig!(:nexi_simple_payment_path)}").to_return do |_request|
    ```

  * **Line # 240 - convention:** Rails/FilePath: Prefer `Rails.root.join('path/to')`.

    ```rb
              body: File.read(Rails.root.join("spec", "fixtures", "nexi-unauthorized-page.html"))
    ```

### spec/requests/v1/admin/reservations_controller/reservations_controller.record_deferred_payment_spec.rb - (2 offenses)
  * **Line # 78 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
      let!(:reservation_payment) do
    ```

  * **Line # 90 - convention:** Layout/LineLength: Line is too long. [124/120]

    ```rb
                     "#{Config.app.dig!(:nexi_api_url)}/#{Config.app.dig!(:nexi_record_deferred_path)}").to_return do |_request|
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
  * **Line # 54 - convention:** Layout/LineLength: Line is too long. [123/120]

    ```rb
                     "#{Config.app.dig!(:nexi_api_url)}/#{Config.app.dig!(:nexi_refund_payment_path)}").to_return do |_request|
    ```

  * **Line # 114 - convention:** RSpec/ExpectChange: Prefer `change(Nexi::HttpRequest, :count)`.

    ```rb
        it { expect { req }.to(change { Nexi::HttpRequest.count }.by(1)) }
    ```

  * **Line # 125 - convention:** RSpec/ExpectChange: Prefer `change(Nexi::HttpRequest, :count)`.

    ```rb
        it { expect { req }.not_to(change { Nexi::HttpRequest.count }) }
    ```

  * **Line # 133 - convention:** RSpec/ExpectChange: Prefer `change(Nexi::HttpRequest, :count)`.

    ```rb
        it { expect { req }.not_to(change { Nexi::HttpRequest.count }) }
    ```

  * **Line # 141 - convention:** RSpec/ExpectChange: Prefer `change(Nexi::HttpRequest, :count)`.

    ```rb
        it { expect { req }.to(change { Nexi::HttpRequest.count }.by(1)) }
    ```

  * **Line # 149 - convention:** RSpec/ExpectChange: Prefer `change(Nexi::HttpRequest, :count)`.

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

### spec/requests/v1/admin/stats_controller/stats_controller.index_spec.rb - (15 offenses)
  * **Line # 8 - warning:** Lint/ConstantDefinitionInBlock: Do not define constants this way within a block.

    ```rb
      ALL_KEYS = %w[reservations-by-hour reservations-count].freeze
    ```

  * **Line # 8 - convention:** RSpec/LeakyConstantDeclaration: Stub constant instead of declaring explicitly.

    ```rb
      ALL_KEYS = %w[reservations-by-hour reservations-count].freeze
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

  * **Line # 177 - convention:** RSpec/ExampleLength: Example has too many lines. [14/5]

    ```rb
        it "be blank if there are no reservations" do ...
    ```

  * **Line # 216 - convention:** Layout/LineLength: Line is too long. [123/120]

    ```rb
          create(:reservation, adults: 4, datetime: DateTime.parse("2025-03-17 10:00:00")) # next day: won't be counted in week
    ```

  * **Line # 218 - convention:** Layout/LineLength: Line is too long. [127/120]

    ```rb
          create(:reservation, adults: 5, datetime: DateTime.parse("2025-03-09 10:00:00")) # last sunday (won't be counted in week)
    ```

  * **Line # 219 - convention:** Layout/LineLength: Line is too long. [129/120]

    ```rb
          create(:reservation, adults: 3, datetime: DateTime.parse("2025-03-08 10:00:00")) # last saturday (won't be counted in week)
    ```

  * **Line # 235 - convention:** RSpec/ExampleLength: Example has too many lines. [36/5]

    ```rb
        it do ...
    ```

### spec/requests/v1/admin/table_types_controller/admin_table_types_controller.create_spec.rb - (4 offenses)
  * **Line # 84 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it do
    ```

  * **Line # 101 - convention:** RSpec/ExampleLength: Example has too many lines. [9/5]

    ```rb
        it do ...
    ```

  * **Line # 101 - convention:** RSpec/MultipleExpectations: Example has too many expectations [4/1].

    ```rb
        it do
    ```

  * **Line # 132 - convention:** Performance/CollectionLiteralInLoop: Avoid immutable Array literals in loops. It is better to extract it into a local variable or a constant.

    ```rb
        [nil, ""].each do |value|
    ```

### spec/requests/v1/admin/table_types_controller/admin_table_types_controller.delete_spec.rb - (1 offense)
  * **Line # 96 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
        let!(:preorder_reservation_group) do
    ```

### spec/requests/v1/admin/table_types_controller/admin_table_types_controller.index_spec.rb - (7 offenses)
  * **Line # 43 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
      let(:tt1) do ...
    ```

  * **Line # 52 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
      let(:tt2) do ...
    ```

  * **Line # 62 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
      let(:tt3) do ...
    ```

  * **Line # 112 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it do
    ```

  * **Line # 124 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it do
    ```

  * **Line # 134 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it do
    ```

  * **Line # 157 - convention:** Layout/LineLength: Line is too long. [167/120]

    ```rb
                                                                                                 preorder_reservation_group_id: Integer, preorder_reservation_group: Hash))
    ```

### spec/requests/v1/admin/table_types_controller/admin_table_types_controller.remove_from_preorder_reservation_groups_spec.rb - (7 offenses)
  * **Line # 5 - convention:** Layout/LineLength: Line is too long. [126/120]

    ```rb
    RSpec.shared_examples "failed request DELETE /v1/admin/table_types/<table-type-id>/remove_from_preorder_reservation_groups" do
    ```

  * **Line # 25 - convention:** Layout/LineLength: Line is too long. [130/120]

    ```rb
    RSpec.shared_examples "successful request DELETE /v1/admin/table_types/<table-type-id>/remove_from_preorder_reservation_groups" do
    ```

  * **Line # 53 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
      let!(:preorder_reservation_group) do
    ```

  * **Line # 74 - convention:** Layout/LineLength: Line is too long. [121/120]

    ```rb
        it_behaves_like "failed request DELETE /v1/admin/table_types/<table-type-id>/remove_from_preorder_reservation_groups"
    ```

  * **Line # 85 - convention:** Layout/LineLength: Line is too long. [121/120]

    ```rb
        it_behaves_like "failed request DELETE /v1/admin/table_types/<table-type-id>/remove_from_preorder_reservation_groups"
    ```

  * **Line # 89 - convention:** Layout/LineLength: Line is too long. [125/120]

    ```rb
        it_behaves_like "successful request DELETE /v1/admin/table_types/<table-type-id>/remove_from_preorder_reservation_groups"
    ```

  * **Line # 95 - convention:** Layout/LineLength: Line is too long. [121/120]

    ```rb
        it_behaves_like "failed request DELETE /v1/admin/table_types/<table-type-id>/remove_from_preorder_reservation_groups"
    ```

### spec/requests/v1/admin/table_types_controller/admin_table_types_controller.show_spec.rb - (1 offense)
  * **Line # 99 - convention:** Layout/LineLength: Line is too long. [134/120]

    ```rb
                          :table_type_to_preorder_reservation_groups)).to all(include(id: Integer, preorder_reservation_group_id: Integer,
    ```

### spec/requests/v1/admin/table_types_controller/admin_table_types_controller.update_spec.rb - (1 offense)
  * **Line # 36 - convention:** RSpec/ExpectChange: Prefer `change(TableType, :count)`.

    ```rb
      it { expect { req }.not_to(change { TableType.count }) }
    ```

### spec/requests/v1/admin/table_types_controller/admin_table_types_controller.update_status_spec.rb - (1 offense)
  * **Line # 36 - convention:** RSpec/ExpectChange: Prefer `change(TableType, :count)`.

    ```rb
      it { expect { req }.not_to(change { TableType.count }) }
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

  * **Line # 108 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it do
    ```

  * **Line # 119 - convention:** RSpec/MultipleExpectations: Example has too many expectations [2/1].

    ```rb
        it do
    ```

  * **Line # 177 - convention:** RSpec/ExpectChange: Prefer `change(Nexi::OrderOutcomeRequest, :count)`.

    ```rb
          it { expect { req }.to(change { Nexi::OrderOutcomeRequest.count }.by(1)) }
    ```

  * **Line # 197 - convention:** RSpec/ExpectChange: Prefer `change(Nexi::OrderOutcomeRequest, :count)`.

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

### spec/requests/v1/reservations_controller/datetime_requires_payment_spec.rb - (23 offenses)
  * **Line # 5 - convention:** RSpec/SharedContext: Use `shared_examples` when you don't define context.

    ```rb
    RSpec.shared_context "SUCCESSFUL GET /v1/reservations/datetime_requires_payment" do |table_types: nil|
    ```

  * **Line # 26 - convention:** RSpec/SharedContext: Use `shared_examples` when you don't define context.

    ```rb
    RSpec.shared_context "PAYMENT NOT REQUIRED GET /v1/reservations/datetime_requires_payment" do
    ```

  * **Line # 31 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.context "GET /v1/reservations/datetime_requires_payment", type: :request do
    ```

  * **Line # 64 - convention:** RSpec/ScatteredLet: Group all let/let! blocks in the example group together.

    ```rb
      let(:date) { "2025-1-1" }
    ```

  * **Line # 65 - convention:** RSpec/ScatteredLet: Group all let/let! blocks in the example group together.

    ```rb
      let(:time) { "12:00" }
    ```

  * **Line # 66 - convention:** RSpec/ScatteredLet: Group all let/let! blocks in the example group together.

    ```rb
      let(:people) { 2 }
    ```

  * **Line # 67 - convention:** RSpec/ScatteredLet: Group all let/let! blocks in the example group together.

    ```rb
      let(:default_params) { { date:, time:, people: } }
    ```

  * **Line # 68 - convention:** RSpec/ScatteredLet: Group all let/let! blocks in the example group together.

    ```rb
      let(:default_headers) { {} }
    ```

  * **Line # 69 - convention:** Layout/EmptyLines: Extra blank line detected.

    ```rb
     ...
    ```

  * **Line # 82 - convention:** Style/HashSyntax: Omit the hash value.

    ```rb
          group.add_table_type(table_type: table_type, price: table_type.default_price, people_per_turn: table_type.default_people_per_turn)
    ```

  * **Line # 82 - convention:** Layout/ArgumentAlignment: Align the arguments of a method call if they span more than one line.

    ```rb
                                                          people_per_turn: table_type.default_people_per_turn)
    ```

  * **Line # 82 - convention:** Layout/HashAlignment: Align the keys of a hash literal if they span more than one line.

    ```rb
                                                          people_per_turn: table_type.default_people_per_turn)
    ```

  * **Line # 82 - convention:** Layout/TrailingWhitespace: Trailing whitespace detected.

    ```rb
          group.add_table_type(table_type:, price: table_type.default_price, 
    ```

  * **Line # 82 - convention:** Layout/LineLength: Line is too long. [136/120]

    ```rb
          group.add_table_type(table_type: table_type, price: table_type.default_price, people_per_turn: table_type.default_people_per_turn)
    ```

  * **Line # 83 - convention:** Layout/ArgumentAlignment: Align the arguments of a method call if they span more than one line.

    ```rb
    people_per_turn: table_type.default_people_per_turn)
    ```

  * **Line # 83 - convention:** Layout/HashAlignment: Align the keys of a hash literal if they span more than one line.

    ```rb
    people_per_turn: table_type.default_people_per_turn)
    ```

  * **Line # 91 - convention:** Style/HashSyntax: Omit the hash value.

    ```rb
          group.add_table_type(table_type: table_type, price: table_type.default_price, people_per_turn: table_type.default_people_per_turn)
    ```

  * **Line # 91 - convention:** Layout/LineLength: Line is too long. [136/120]

    ```rb
          group.add_table_type(table_type: table_type, price: table_type.default_price, people_per_turn: table_type.default_people_per_turn)
    ```

  * **Line # 92 - convention:** Layout/ArgumentAlignment: Align the arguments of a method call if they span more than one line.

    ```rb
                                                          people_per_turn: table_type.default_people_per_turn)
    ```

  * **Line # 92 - convention:** Layout/HashAlignment: Align the keys of a hash literal if they span more than one line.

    ```rb
                                                          people_per_turn: table_type.default_people_per_turn)
    ```

  * **Line # 92 - convention:** Layout/TrailingWhitespace: Trailing whitespace detected.

    ```rb
          group.add_table_type(table_type:, price: table_type.default_price, 
    ```

  * **Line # 93 - convention:** Layout/ArgumentAlignment: Align the arguments of a method call if they span more than one line.

    ```rb
    people_per_turn: table_type.default_people_per_turn)
    ```

  * **Line # 93 - convention:** Layout/HashAlignment: Align the keys of a hash literal if they span more than one line.

    ```rb
    people_per_turn: table_type.default_people_per_turn)
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

### spec/requests/v1/reservations_controller/valid_times_spec.rb - (39 offenses)
  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.context "GET /v1/reservations/valid_times", type: :request do
    ```

  * **Line # 25 - convention:** Rails/TimeZone: Do not use `Time.now` without zone. Use one of `Time.zone.now`, `Time.current`, `Time.now.in_time_zone`, `Time.now.utc`, `Time.now.getlocal`, `Time.now.xmlschema`, `Time.now.iso8601`, `Time.now.jisx0301`, `Time.now.rfc3339`, `Time.now.httpdate`, `Time.now.to_i`, `Time.now.to_f` instead.

    ```rb
          create(:reservation_turn, starts_at: "12:00", ends_at: "15:00", weekday: Time.now.wday)
    ```

  * **Line # 44 - convention:** RSpec/EmptyLineAfterExample: Add an empty line after `it`.

    ```rb
          it { expect(json).not_to include(message: String) }
    ```

  * **Line # 46 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
          it do
    ```

  * **Line # 50 - convention:** Layout/LineLength: Line is too long. [122/120]

    ```rb
                                                                  "preorder_type" => group.preorder_type, "message" => String)
    ```

  * **Line # 55 - convention:** Layout/SpaceAfterComma: Space missing after comma.

    ```rb
          let(:people) { [1,2,3,4].sample }
    ```

  * **Line # 55 - convention:** Layout/SpaceAfterComma: Space missing after comma.

    ```rb
          let(:people) { [1,2,3,4].sample }
    ```

  * **Line # 55 - convention:** Layout/SpaceAfterComma: Space missing after comma.

    ```rb
          let(:people) { [1,2,3,4].sample }
    ```

  * **Line # 58 - convention:** RSpec/EmptyLineAfterExample: Add an empty line after `it`.

    ```rb
          it { expect(json).not_to include(message: String) }
    ```

  * **Line # 66 - convention:** Layout/SpaceAfterComma: Space missing after comma.

    ```rb
          let(:people) { [5,6,10].sample }
    ```

  * **Line # 66 - convention:** Layout/SpaceAfterComma: Space missing after comma.

    ```rb
          let(:people) { [5,6,10].sample }
    ```

  * **Line # 69 - convention:** RSpec/EmptyLineAfterExample: Add an empty line after `it`.

    ```rb
          it { expect(json).not_to include(message: String) }
    ```

  * **Line # 73 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
          it do
    ```

  * **Line # 77 - convention:** Layout/LineLength: Line is too long. [122/120]

    ```rb
                                                                  "preorder_type" => group.preorder_type, "message" => String)
    ```

  * **Line # 83 - convention:** Layout/LineLength: Line is too long. [121/120]

    ```rb
      context "when two groups have same turn different dates, will check the provided date (issue noticed in production)" do
    ```

  * **Line # 84 - convention:** Style/TrailingCommaInArrayLiteral: Avoid comma after the last item of an array.

    ```rb
            create(:reservation_turn, name: "Cena 2", starts_at: "19:01", ends_at: "21:00", weekday: 6),
    ```

  * **Line # 101 - convention:** Layout/SpaceBeforeBlockBraces: Space missing to the left of {.

    ```rb
          json.find{|j| j["starts_at"] == "2000-01-01T17:00:00.000Z" }
    ```

  * **Line # 101 - convention:** Layout/SpaceInsideBlockBraces: Space between { and | missing.

    ```rb
          json.find{|j| j["starts_at"] == "2000-01-01T17:00:00.000Z" }
    ```

  * **Line # 103 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
        let(:json_cena1) do ...
    ```

  * **Line # 104 - convention:** Layout/SpaceInsideBlockBraces: Space between { and | missing.

    ```rb
          json.find {|j| j["starts_at"] == "2000-01-01T17:00:00.000Z" }
    ```

  * **Line # 105 - convention:** Layout/SpaceBeforeBlockBraces: Space missing to the left of {.

    ```rb
          json.find{|j| j["starts_at"] == "2000-01-01T19:01:00.000Z" }
    ```

  * **Line # 105 - convention:** Layout/SpaceInsideBlockBraces: Space between { and | missing.

    ```rb
          json.find{|j| j["starts_at"] == "2000-01-01T19:01:00.000Z" }
    ```

  * **Line # 107 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
        let(:json_cena2) do ...
    ```

  * **Line # 108 - convention:** Layout/SpaceInsideBlockBraces: Space between { and | missing.

    ```rb
          json.find {|j| j["starts_at"] == "2000-01-01T19:01:00.000Z" }
    ```

  * **Line # 111 - convention:** Style/CommentAnnotation: Annotation keywords like `Note` should be all upper case, followed by a colon, and a space, then a note describing the problem.

    ```rb
          # Note: if we invert the order of creation, we will have a different result
    ```

  * **Line # 121 - convention:** Layout/LineLength: Line is too long. [124/120]

    ```rb
          expect(json_cena1["preorder_reservation_group"]).to be_a(Hash).and(include("id" => deluxe.id, "payment_value" => 100))
    ```

  * **Line # 124 - convention:** Layout/TrailingWhitespace: Trailing whitespace detected.

    ```rb
          expect(json_cena1["preorder_reservation_group"]).to be_a(Hash).and(include("id" => deluxe.id, 
    ```

  * **Line # 125 - convention:** Layout/ArgumentAlignment: Align the arguments of a method call if they span more than one line.

    ```rb
    "payment_value" => 100))
    ```

  * **Line # 125 - convention:** Layout/HashAlignment: Align the keys of a hash literal if they span more than one line.

    ```rb
    "payment_value" => 100))
    ```

  * **Line # 125 - convention:** Layout/ArgumentAlignment: Align the arguments of a method call if they span more than one line.

    ```rb
                                                                                                                                                                      "payment_value" => 100))
    ```

  * **Line # 125 - convention:** Layout/HashAlignment: Align the keys of a hash literal if they span more than one line.

    ```rb
                                                                                                                                                                      "payment_value" => 100))
    ```

  * **Line # 159 - convention:** Layout/LineLength: Line is too long. [133/120]

    ```rb
        context "when got holidays on all weekdays but they are expired (to_timestamp is in the past): should see all times available" do
    ```

  * **Line # 376 - convention:** Rails/TimeZone: Do not use `Time.now` without zone. Use one of `Time.zone.now`, `Time.current`, `Time.now.in_time_zone`, `Time.now.utc`, `Time.now.getlocal`, `Time.now.xmlschema`, `Time.now.iso8601`, `Time.now.jisx0301`, `Time.now.rfc3339`, `Time.now.httpdate`, `Time.now.to_i`, `Time.now.to_f` instead.

    ```rb
          create(:reservation_turn, starts_at: "12:00", ends_at: "15:00", weekday: Time.now.wday)
    ```

  * **Line # 394 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
        it do
    ```

  * **Line # 414 - convention:** Rails/TimeZone: Do not use `Time.now` without zone. Use one of `Time.zone.now`, `Time.current`, `Time.now.in_time_zone`, `Time.now.utc`, `Time.now.getlocal`, `Time.now.xmlschema`, `Time.now.iso8601`, `Time.now.jisx0301`, `Time.now.rfc3339`, `Time.now.httpdate`, `Time.now.to_i`, `Time.now.to_f` instead.

    ```rb
            ReservationTurn.create!(name: "Day", weekday: Time.now.wday, starts_at: "12:00", ends_at: "14:00", step: 30)
    ```

  * **Line # 417 - convention:** Rails/TimeZone: Do not use `Time.now` without zone. Use one of `Time.zone.now`, `Time.current`, `Time.now.in_time_zone`, `Time.now.utc`, `Time.now.getlocal`, `Time.now.xmlschema`, `Time.now.iso8601`, `Time.now.jisx0301`, `Time.now.rfc3339`, `Time.now.httpdate`, `Time.now.to_i`, `Time.now.to_f` instead.

    ```rb
          ReservationTurn.create!(name: "Night", weekday: Time.now.wday, starts_at: "19:00", ends_at: "21:00", step: 30)
    ```

  * **Line # 427 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
        it do
    ```

  * **Line # 447 - convention:** Rails/TimeZone: Do not use `Time.now` without zone. Use one of `Time.zone.now`, `Time.current`, `Time.now.in_time_zone`, `Time.now.utc`, `Time.now.getlocal`, `Time.now.xmlschema`, `Time.now.iso8601`, `Time.now.jisx0301`, `Time.now.rfc3339`, `Time.now.httpdate`, `Time.now.to_i`, `Time.now.to_f` instead.

    ```rb
            ReservationTurn.create!(name: "Day", weekday: Time.now.wday, starts_at: "12:00", ends_at: "14:00", step: 30)
    ```

  * **Line # 450 - convention:** Rails/TimeZone: Do not use `Time.now` without zone. Use one of `Time.zone.now`, `Time.current`, `Time.now.in_time_zone`, `Time.now.utc`, `Time.now.getlocal`, `Time.now.xmlschema`, `Time.now.iso8601`, `Time.now.jisx0301`, `Time.now.rfc3339`, `Time.now.httpdate`, `Time.now.to_i`, `Time.now.to_f` instead.

    ```rb
          ReservationTurn.create!(name: "Night", weekday: Time.now.wday, starts_at: "19:00", ends_at: "21:00", step: 30)
    ```

### spec/requests/v2/reservations_controller/valid_times_spec.rb - (73 offenses)
  * **Line # 5 - convention:** RSpec/Rails/InferredSpecType: Remove redundant spec type.

    ```rb
    RSpec.context "GET /v2/reservations/valid_times", type: :request do
    ```

  * **Line # 28 - convention:** Rails/TimeZone: Do not use `Time.now` without zone. Use one of `Time.zone.now`, `Time.current`, `Time.now.in_time_zone`, `Time.now.utc`, `Time.now.getlocal`, `Time.now.xmlschema`, `Time.now.iso8601`, `Time.now.jisx0301`, `Time.now.rfc3339`, `Time.now.httpdate`, `Time.now.to_i`, `Time.now.to_f` instead.

    ```rb
          create(:reservation_turn, starts_at: "12:00", ends_at: "15:00", weekday: Time.now.wday)
    ```

  * **Line # 47 - convention:** RSpec/EmptyLineAfterExample: Add an empty line after `it`.

    ```rb
          it { expect(json).not_to include(message: String) }
    ```

  * **Line # 49 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
          it do
    ```

  * **Line # 53 - convention:** Layout/LineLength: Line is too long. [122/120]

    ```rb
                                                                  "preorder_type" => group.preorder_type, "message" => String)
    ```

  * **Line # 58 - convention:** Layout/SpaceAfterComma: Space missing after comma.

    ```rb
          let(:people) { [1,2,3,4].sample }
    ```

  * **Line # 58 - convention:** Layout/SpaceAfterComma: Space missing after comma.

    ```rb
          let(:people) { [1,2,3,4].sample }
    ```

  * **Line # 58 - convention:** Layout/SpaceAfterComma: Space missing after comma.

    ```rb
          let(:people) { [1,2,3,4].sample }
    ```

  * **Line # 61 - convention:** RSpec/EmptyLineAfterExample: Add an empty line after `it`.

    ```rb
          it { expect(json).not_to include(message: String) }
    ```

  * **Line # 69 - convention:** Layout/SpaceAfterComma: Space missing after comma.

    ```rb
          let(:people) { [5,6,10].sample }
    ```

  * **Line # 69 - convention:** Layout/SpaceAfterComma: Space missing after comma.

    ```rb
          let(:people) { [5,6,10].sample }
    ```

  * **Line # 72 - convention:** RSpec/EmptyLineAfterExample: Add an empty line after `it`.

    ```rb
          it { expect(json).not_to include(message: String) }
    ```

  * **Line # 76 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
          it do
    ```

  * **Line # 80 - convention:** Layout/LineLength: Line is too long. [122/120]

    ```rb
                                                                  "preorder_type" => group.preorder_type, "message" => String)
    ```

  * **Line # 97 - convention:** Layout/LineLength: Line is too long. [121/120]

    ```rb
      context "when two groups have same turn different dates, will check the provided date (issue noticed in production)" do
    ```

  * **Line # 98 - convention:** Style/TrailingCommaInArrayLiteral: Avoid comma after the last item of an array.

    ```rb
            create(:reservation_turn, name: "Cena 2", starts_at: "19:01", ends_at: "21:00", weekday: 6),
    ```

  * **Line # 115 - convention:** Layout/SpaceBeforeBlockBraces: Space missing to the left of {.

    ```rb
          json["turns"].find{|j| j["starts_at"] == "2000-01-01T17:00:00.000Z" }
    ```

  * **Line # 115 - convention:** Layout/SpaceInsideBlockBraces: Space between { and | missing.

    ```rb
          json["turns"].find{|j| j["starts_at"] == "2000-01-01T17:00:00.000Z" }
    ```

  * **Line # 117 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
        let(:json_cena1) do ...
    ```

  * **Line # 118 - convention:** Layout/SpaceInsideBlockBraces: Space between { and | missing.

    ```rb
          json["turns"].find {|j| j["starts_at"] == "2000-01-01T17:00:00.000Z" }
    ```

  * **Line # 119 - convention:** Layout/SpaceBeforeBlockBraces: Space missing to the left of {.

    ```rb
          json["turns"].find{|j| j["starts_at"] == "2000-01-01T19:01:00.000Z" }
    ```

  * **Line # 119 - convention:** Layout/SpaceInsideBlockBraces: Space between { and | missing.

    ```rb
          json["turns"].find{|j| j["starts_at"] == "2000-01-01T19:01:00.000Z" }
    ```

  * **Line # 121 - convention:** RSpec/IndexedLet: This `let` statement uses index in its name. Please give it a meaningful name.

    ```rb
        let(:json_cena2) do ...
    ```

  * **Line # 122 - convention:** Layout/SpaceInsideBlockBraces: Space between { and | missing.

    ```rb
          json["turns"].find {|j| j["starts_at"] == "2000-01-01T19:01:00.000Z" }
    ```

  * **Line # 125 - convention:** Style/CommentAnnotation: Annotation keywords like `Note` should be all upper case, followed by a colon, and a space, then a note describing the problem.

    ```rb
          # Note: if we invert the order of creation, we will have a different result
    ```

  * **Line # 135 - convention:** Layout/LineLength: Line is too long. [124/120]

    ```rb
          expect(json_cena1["preorder_reservation_group"]).to be_a(Hash).and(include("id" => deluxe.id, "payment_value" => 100))
    ```

  * **Line # 138 - convention:** Layout/TrailingWhitespace: Trailing whitespace detected.

    ```rb
          expect(json_cena1["preorder_reservation_group"]).to be_a(Hash).and(include("id" => deluxe.id, 
    ```

  * **Line # 139 - convention:** Layout/ArgumentAlignment: Align the arguments of a method call if they span more than one line.

    ```rb
    "payment_value" => 100))
    ```

  * **Line # 139 - convention:** Layout/HashAlignment: Align the keys of a hash literal if they span more than one line.

    ```rb
    "payment_value" => 100))
    ```

  * **Line # 139 - convention:** Layout/ArgumentAlignment: Align the arguments of a method call if they span more than one line.

    ```rb
                                                                                                                                                                      "payment_value" => 100))
    ```

  * **Line # 139 - convention:** Layout/HashAlignment: Align the keys of a hash literal if they span more than one line.

    ```rb
                                                                                                                                                                      "payment_value" => 100))
    ```

  * **Line # 162 - convention:** Layout/LineLength: Line is too long. [133/120]

    ```rb
        context "when got holidays on all weekdays but they are expired (to_timestamp is in the past): should see all times available" do
    ```

  * **Line # 208 - convention:** Layout/LineLength: Line is too long. [128/120]

    ```rb
            create(:holiday, from_timestamp: 10.days.ago, to_timestamp: [10.days.from_now, nil].sample, weekday: Time.zone.now.wday,
    ```

  * **Line # 209 - convention:** Layout/LineLength: Line is too long. [122/120]

    ```rb
                             weekly_from: ["00:00", "01:00"].sample, weekly_to: ["15:00", "19:00", "23:59"].sample).tap do |h|
    ```

  * **Line # 217 - convention:** RSpec/BeEmpty: Use `be_empty` matchers for checking an empty array.

    ```rb
          it { expect(json[:turns].dig(0, "valid_times")).to match_array([]) }
    ```

  * **Line # 242 - convention:** Layout/SpaceAfterComma: Space missing after comma.

    ```rb
            create(:holiday, from_timestamp: 10.days.ago, to_timestamp: 10.days.ago, weekday: Time.zone.now.wday,weekly_from: "12:30", weekly_to: ["15:00", "16:00", "23:59"].sample)
    ```

  * **Line # 242 - convention:** Layout/LineLength: Line is too long. [177/120]

    ```rb
            create(:holiday, from_timestamp: 10.days.ago, to_timestamp: 10.days.ago, weekday: Time.zone.now.wday,weekly_from: "12:30", weekly_to: ["15:00", "16:00", "23:59"].sample)
    ```

  * **Line # 245 - convention:** Layout/LineLength: Line is too long. [223/120]

    ```rb
            create(:holiday, from_timestamp: 10.days.ago, to_timestamp: [1.day.from_now, 10.days.from_now, nil].sample, weekday: (Time.zone.now.wday + 1) % 6, weekly_from: "12:30", weekly_to: ["15:00", "16:00", "23:59"].sample)
    ```

  * **Line # 246 - convention:** Layout/TrailingWhitespace: Trailing whitespace detected.

    ```rb
            create(:holiday, from_timestamp: 10.days.ago, to_timestamp: 10.days.ago, weekday: Time.zone.now.wday, 
    ```

  * **Line # 246 - convention:** Layout/LineLength: Line is too long. [223/120]

    ```rb
            create(:holiday, from_timestamp: 10.days.ago, to_timestamp: [1.day.from_now, 10.days.from_now, nil].sample, weekday: (Time.zone.now.wday - 1) % 6, weekly_from: "12:30", weekly_to: ["15:00", "16:00", "23:59"].sample)
    ```

  * **Line # 247 - convention:** Layout/HashAlignment: Align the keys of a hash literal if they span more than one line.

    ```rb
    weekly_from: "12:30", weekly_to: ["15:00", "16:00", "23:59"].sample)
    ```

  * **Line # 250 - convention:** Layout/TrailingWhitespace: Trailing whitespace detected.

    ```rb
            create(:holiday, from_timestamp: 10.days.ago, to_timestamp: [1.day.from_now, 10.days.from_now, nil].sample, 
    ```

  * **Line # 251 - convention:** Layout/HashAlignment: Align the keys of a hash literal if they span more than one line.

    ```rb
    weekday: (Time.zone.now.wday + 1) % 6, weekly_from: "12:30", weekly_to: ["15:00", "16:00", "23:59"].sample)
    ```

  * **Line # 251 - convention:** Layout/LineLength: Line is too long. [132/120]

    ```rb
                             weekday: (Time.zone.now.wday + 1) % 6, weekly_from: "12:30", weekly_to: ["15:00", "16:00", "23:59"].sample)
    ```

  * **Line # 252 - convention:** Layout/TrailingWhitespace: Trailing whitespace detected.

    ```rb
            create(:holiday, from_timestamp: 10.days.ago, to_timestamp: [1.day.from_now, 10.days.from_now, nil].sample, 
    ```

  * **Line # 253 - convention:** Layout/HashAlignment: Align the keys of a hash literal if they span more than one line.

    ```rb
    weekday: (Time.zone.now.wday - 1) % 6, weekly_from: "12:30", weekly_to: ["15:00", "16:00", "23:59"].sample)
    ```

  * **Line # 253 - convention:** Layout/LineLength: Line is too long. [132/120]

    ```rb
                             weekday: (Time.zone.now.wday - 1) % 6, weekly_from: "12:30", weekly_to: ["15:00", "16:00", "23:59"].sample)
    ```

  * **Line # 255 - convention:** Layout/LineLength: Line is too long. [128/120]

    ```rb
            create(:holiday, from_timestamp: 10.days.ago, to_timestamp: [10.days.from_now, nil].sample, weekday: Time.zone.now.wday,
    ```

  * **Line # 349 - convention:** Layout/LineLength: Line is too long. [124/120]

    ```rb
          expect(json[:turns]).to all(include("id" => Integer, "starts_at" => String, "ends_at" => String, "weekday" => Integer,
    ```

  * **Line # 375 - convention:** Layout/LineLength: Line is too long. [124/120]

    ```rb
          expect(json[:turns]).to all(include("id" => Integer, "starts_at" => String, "ends_at" => String, "weekday" => Integer,
    ```

  * **Line # 458 - convention:** Rails/TimeZone: Do not use `Time.now` without zone. Use one of `Time.zone.now`, `Time.current`, `Time.now.in_time_zone`, `Time.now.utc`, `Time.now.getlocal`, `Time.now.xmlschema`, `Time.now.iso8601`, `Time.now.jisx0301`, `Time.now.rfc3339`, `Time.now.httpdate`, `Time.now.to_i`, `Time.now.to_f` instead.

    ```rb
          create(:reservation_turn, starts_at: "12:00", ends_at: "15:00", weekday: Time.now.wday)
    ```

  * **Line # 476 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
        it do
    ```

  * **Line # 496 - convention:** Rails/TimeZone: Do not use `Time.now` without zone. Use one of `Time.zone.now`, `Time.current`, `Time.now.in_time_zone`, `Time.now.utc`, `Time.now.getlocal`, `Time.now.xmlschema`, `Time.now.iso8601`, `Time.now.jisx0301`, `Time.now.rfc3339`, `Time.now.httpdate`, `Time.now.to_i`, `Time.now.to_f` instead.

    ```rb
            ReservationTurn.create!(name: "Day", weekday: Time.now.wday, starts_at: "12:00", ends_at: "14:00", step: 30)
    ```

  * **Line # 499 - convention:** Rails/TimeZone: Do not use `Time.now` without zone. Use one of `Time.zone.now`, `Time.current`, `Time.now.in_time_zone`, `Time.now.utc`, `Time.now.getlocal`, `Time.now.xmlschema`, `Time.now.iso8601`, `Time.now.jisx0301`, `Time.now.rfc3339`, `Time.now.httpdate`, `Time.now.to_i`, `Time.now.to_f` instead.

    ```rb
          ReservationTurn.create!(name: "Night", weekday: Time.now.wday, starts_at: "19:00", ends_at: "21:00", step: 30)
    ```

  * **Line # 509 - convention:** RSpec/MultipleExpectations: Example has too many expectations [3/1].

    ```rb
        it do
    ```

  * **Line # 567 - convention:** Layout/LineLength: Line is too long. [121/120]

    ```rb
        context "when turn has table_types but they are already full (all seats are taken) (scenario=#{scenario.inspect})" do
    ```

  * **Line # 583 - convention:** RSpec/LetSetup: Do not use `let!` to setup objects not referenced in tests.

    ```rb
          let!(:group) do
    ```

  * **Line # 605 - convention:** Performance/CollectionLiteralInLoop: Avoid immutable Array literals in loops. It is better to extract it into a local variable or a constant.

    ```rb
              create(:reservation, status: %w[active arrived deleted noshow cancelled].sample, table_type:, adults: Random.rand(1..10), children: 0, datetime: DateTime.parse("#{date} #{
    ```

  * **Line # 605 - convention:** Layout/LineLength: Line is too long. [181/120]

    ```rb
              create(:reservation, status: %w[active arrived deleted noshow cancelled].sample, table_type:, adults: Random.rand(1..10), children: 0, datetime: DateTime.parse("#{date} #{
    ```

  * **Line # 653 - convention:** Rails/TimeZone: Do not use `Time.now` without zone. Use one of `Time.zone.now`, `Time.current`, `Time.now.in_time_zone`, `Time.now.utc`, `Time.now.getlocal`, `Time.now.xmlschema`, `Time.now.iso8601`, `Time.now.jisx0301`, `Time.now.rfc3339`, `Time.now.httpdate`, `Time.now.to_i`, `Time.now.to_f` instead.

    ```rb
            ReservationTurn.create!(name: "Day", weekday: Time.now.wday, starts_at: "12:00", ends_at: "14:00", step: 30),
    ```

  * **Line # 654 - convention:** Rails/TimeZone: Do not use `Time.now` without zone. Use one of `Time.zone.now`, `Time.current`, `Time.now.in_time_zone`, `Time.now.utc`, `Time.now.getlocal`, `Time.now.xmlschema`, `Time.now.iso8601`, `Time.now.jisx0301`, `Time.now.rfc3339`, `Time.now.httpdate`, `Time.now.to_i`, `Time.now.to_f` instead.

    ```rb
            ReservationTurn.create!(name: "Night", weekday: Time.now.wday, starts_at: "19:00", ends_at: "21:00", step: 30)
    ```

  * **Line # 677 - convention:** RSpec/ExampleLength: Example has too many lines. [6/5]

    ```rb
        it do ...
    ```

  * **Line # 686 - convention:** RSpec/ExampleLength: Example has too many lines. [7/5]

    ```rb
        it do ...
    ```

  * **Line # 692 - convention:** Layout/LineLength: Line is too long. [121/120]

    ```rb
                                                                                                 "people_per_turn" => Integer
    ```

  * **Line # 710 - convention:** RSpec/ExampleLength: Example has too many lines. [6/5]

    ```rb
        it do ...
    ```

  * **Line # 721 - convention:** Layout/LineLength: Line is too long. [134/120]

    ```rb
                          "table_type_to_preorder_reservation_groups").pluck(:table_type).sample.keys.map(&:to_s) & ["notes"]).to be_empty
    ```

  * **Line # 726 - convention:** Layout/LineLength: Line is too long. [133/120]

    ```rb
                          "table_type_to_preorder_reservation_groups").pluck(:table_type).flatten.pluck(:images).flatten).to all(include(
    ```

  * **Line # 727 - convention:** Layout/LineLength: Line is too long. [142/120]

    ```rb
                                                                                                                                   "url" => String
    ```

  * **Line # 728 - convention:** Layout/LineLength: Line is too long. [127/120]

    ```rb
                                                                                                                                 ))
    ```

  * **Line # 743 - convention:** Rails/TimeZone: Do not use `Time.now` without zone. Use one of `Time.zone.now`, `Time.current`, `Time.now.in_time_zone`, `Time.now.utc`, `Time.now.getlocal`, `Time.now.xmlschema`, `Time.now.iso8601`, `Time.now.jisx0301`, `Time.now.rfc3339`, `Time.now.httpdate`, `Time.now.to_i`, `Time.now.to_f` instead.

    ```rb
            ReservationTurn.create!(name: "Day", weekday: Time.now.wday, starts_at: "12:00", ends_at: "14:00", step: 30)
    ```

  * **Line # 746 - convention:** Rails/TimeZone: Do not use `Time.now` without zone. Use one of `Time.zone.now`, `Time.current`, `Time.now.in_time_zone`, `Time.now.utc`, `Time.now.getlocal`, `Time.now.xmlschema`, `Time.now.iso8601`, `Time.now.jisx0301`, `Time.now.rfc3339`, `Time.now.httpdate`, `Time.now.to_i`, `Time.now.to_f` instead.

    ```rb
          ReservationTurn.create!(name: "Night", weekday: Time.now.wday, starts_at: "19:00", ends_at: "21:00", step: 30)
    ```

  * **Line # 927 - convention:** RSpec/RepeatedExample: Don't repeat examples within an example group.

    ```rb
        it { expect(json.dig(:turns, 0, :messages)).to all(include(message: String)) }
    ```

  * **Line # 928 - convention:** RSpec/RepeatedExample: Don't repeat examples within an example group.

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

### spec/routing/v1/admin/table_types_routing_spec.rb - (3 offenses)
  * **Line # 29 - convention:** Layout/LineLength: Line is too long. [177/120]

    ```rb
        expect(delete: "/v1/admin/table_types/22/remove_from_preorder_reservation_groups").to route_to("v1/admin/table_types#remove_from_preorder_reservation_groups", format: :json,
    ```

  * **Line # 30 - convention:** Layout/LineLength: Line is too long. [172/120]

    ```rb
                                                                                                                                                                       id: "22")
    ```

  * **Line # 34 - convention:** Layout/LineLength: Line is too long. [124/120]

    ```rb
        expect(patch: "/v1/admin/table_types/22/update_status").to route_to("v1/admin/table_types#update_status", format: :json,
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

