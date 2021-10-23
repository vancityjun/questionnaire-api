class CreateQuestionnaires < ActiveRecord::Migration[6.1]
  def change
    create_table :questionnaires do |t|
      t.string :title, null: false
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
