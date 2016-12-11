class CreateVotings < ActiveRecord::Migration
  def change
    create_table :votings do |t|
      t.references :upvoter, index: true, foreign_key: true
      t.references :candidate, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
