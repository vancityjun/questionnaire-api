class CreateVoteCounts < ActiveRecord::Migration[6.1]
  def change
    create_table :vote_counts do |t|
      t.integer :voter_id
      t.belongs_to :option, index: true, foreign_key: true

      t.timestamps
    end

    add_index :vote_counts, :voter_id
  end
end
