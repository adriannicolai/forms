class CreateForms < ActiveRecord::Migration[7.0]
  def change
    create_table :forms do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, limit: 150
      t.string :description, limit: 500
      t.text :form_settings_json
      t.integer :cache_response_count

      t.timestamps
    end
  end
end
