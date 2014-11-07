class AddMovieIdToSource < ActiveRecord::Migration
  def change
 		remove_column :sources, :netflix_dvd
 		remove_column :sources, :netflix_stream
 		remove_column :sources, :amazon_stream
 		remove_column :sources, :amazon_prime

 		add_column :sources, :url, :string
 		add_column :sources, :name, :string
   end
end
