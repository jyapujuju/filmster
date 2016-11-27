class AddIndexAndChange < ActiveRecord::Migration
  def change
    add_index :movies, :imdbid
    remove_column :movies, :index
  end
end
