class AddPriceToSource < ActiveRecord::Migration
  def change
  	add_column :sources, :price, :float
  end
end
