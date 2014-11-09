class ChangeColumnType < ActiveRecord::Migration
  def change
  	change_column :sources, :url, :text, limit: 5000
  end
end
