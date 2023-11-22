class CreateMenuVisibilities < ActiveRecord::Migration[7.0]
  def change
    create_table :menu_visibilities do |t|
      t.boolean   :public_visible,    null: false, default: false
      t.timestamp :public_from,       null: true
      t.timestamp :public_to,         null: true
      t.boolean   :private_visible,   null: false, default: false
      t.timestamp :private_from,      null: true
      t.timestamp :private_to,        null: true

      t.timestamps
    end
  end
end
