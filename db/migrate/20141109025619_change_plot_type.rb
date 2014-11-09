class ChangePlotType < ActiveRecord::Migration
  def change
  	change_column :movies, :plot, :text, limit: nil
  end
end
