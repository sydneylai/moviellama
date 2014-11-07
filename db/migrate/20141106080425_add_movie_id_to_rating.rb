class AddMovieIdToRating < ActiveRecord::Migration
  def change
  	remove_column :ratings, :imdb
  	remove_column :ratings, :rt
  	add_column :ratings, :rating, :float
  	add_column :ratings, :source, :string
  	add_column :ratings, :movie_id, :integer
  end
end
