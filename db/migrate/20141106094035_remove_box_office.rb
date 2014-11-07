class RemoveBoxOffice < ActiveRecord::Migration
  def change
  	remove_column :sources, :box_office
  end
end
