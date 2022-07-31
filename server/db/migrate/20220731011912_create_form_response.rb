class CreateFormResponse < ActiveRecord::Migration[7.0]
  def change
    create_table :form_responses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :form, null: false, foreign_key: true
      t.references :form_question, null: false, foreign_key: true
      t.text :answer_json

      t.timestamps
    end
  end
end
