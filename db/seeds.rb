# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
m = Movie.first
m.movie_shows.create(:timing => "09:00")
m.movie_shows.create(:timing => "13:00")
m.movie_shows.create(:timing => "21:00")
m = Movie.last
m.movie_shows.create(:timing => "09:00")
m.movie_shows.create(:timing => "13:00")
m.movie_shows.create(:timing => "21:00")
m = Movie.first
m.movie_shows.create(:timing => "09:00")
m.movie_shows.create(:timing => "13:00")
m.movie_shows.create(:timing => "21:00")
m = Movie.last
m.movie_shows.create(:timing => "09:00")
m.movie_shows.create(:timing => "13:00")
m.movie_shows.create(:timing => "21:00")
a = Audi.find(1)
ms = MovieShow.find_all_by_id([114, 115, 116])
a.movie_shows << ms
a = Audi.find(2)
ms = MovieShow.find_all_by_id([117, 118, 119])
a.movie_shows << ms
a = Audi.find(3)
ms = MovieShow.find_all_by_id([120, 121, 122])
a.movie_shows << ms
a = Audi.find(4)
ms = MovieShow.find_all_by_id([123, 124, 125])
a.movie_shows << ms
