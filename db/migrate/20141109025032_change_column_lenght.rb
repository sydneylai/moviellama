class ChangeColumnLenght < ActiveRecord::Migration
  def change
  	change_column :sources, :url, :text, limit: 1000
  	change_column :movies, :poster_url, :text, limit: 1000
  end
end
