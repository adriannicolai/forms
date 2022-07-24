class AddFormSectionOnFormQuestion < ActiveRecord::Migration[7.0]
  def change
    add_reference :form_questions, :form_sections, index:true, foreign_key: true, after: :form_id
  end
end
