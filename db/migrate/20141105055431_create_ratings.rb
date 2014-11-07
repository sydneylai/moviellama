class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.float :imdb
      t.float :rt

      t.timestamps
    end
  end
end
