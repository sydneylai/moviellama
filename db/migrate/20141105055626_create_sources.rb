class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.boolean :netflix_dvd
      t.boolean :netflix_stream
      t.boolean :amazon_stream
      t.boolean :amazon_prime
      t.boolean :box_office

      t.timestamps
    end
  end
end
