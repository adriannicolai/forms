class CreateFormSection < ActiveRecord::Migration[7.0]
  def change
    create_table :form_sections do |t|
      t.references :form, null: false, foreign_key: true
      t.text :form_question_ids

      t.timestamps
    end
  end
end
