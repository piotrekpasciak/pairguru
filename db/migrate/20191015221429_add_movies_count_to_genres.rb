class AddMoviesCountToGenres < ActiveRecord::Migration[5.2]
  def change
    add_column :genres, :movies_count, :integer

    Genre.find_each do |genre|
      Genre.reset_counters(genre.id, :movies)
    end
  end
end
