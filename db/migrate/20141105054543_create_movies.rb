class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :year
      t.date :release_date
      t.string :genre
      t.string :poster_url
      t.string :plot
      t.integer :runtime

      t.timestamps
    end
  end
end
