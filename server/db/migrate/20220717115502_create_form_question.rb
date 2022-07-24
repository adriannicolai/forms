class CreateFormQuestion < ActiveRecord::Migration[7.0]
  def change
    create_table :form_questions do |t|
      t.references :form, null: false, foreign_key: true
      t.text :question_json

      t.timestamps
    end
  end
end
