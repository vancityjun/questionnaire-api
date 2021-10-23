class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.integer :questionnaire_id, index: true, foreign_key: true
      t.string :title, null: false
      t.string :question_type, null: false

      t.timestamps
    end
  end
end
