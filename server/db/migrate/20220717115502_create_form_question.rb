class CreateFormQuestion < ActiveRecord::Migration[7.0]
  def change
    create_table :form_questions do |t|
      t.references :form, null: false, foreign_key: true
      t.integer :question_type_id, :limit => 2
      t.string :title, :limit => 255
      t.text :choices_json
      t.integer :is_required, :limit => 2
      t.timestamps
    end
  end
end
