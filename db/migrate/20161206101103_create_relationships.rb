class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.refrences :follower
      t.refrences :followed

      t.timestamps null: false
    end
  end
end
