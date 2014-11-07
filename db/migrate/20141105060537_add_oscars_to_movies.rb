class AddOscarsToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :oscars, :integer
  end
end
