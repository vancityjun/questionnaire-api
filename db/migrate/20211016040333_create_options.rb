class CreateOptions < ActiveRecord::Migration[6.1]
  def change
    create_table :options do |t|
      t.belongs_to :question, index: true, foreign_key: true
      t.string :title, null: false
      t.timestamps
    end
  end
end
