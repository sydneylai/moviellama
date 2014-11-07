class AddMovieIdToSources < ActiveRecord::Migration
  def change
  	add_column :sources, :movie_id, :integer
  end
end
