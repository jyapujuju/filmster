class RenameReviewColumn < ActiveRecord::Migration
  def change
    rename_column :movies, :meatascorre, :metascore
  end
end
