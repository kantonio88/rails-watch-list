# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# db/seeds.rb
require 'json'
require 'open-uri'

# Delete previous movies
Bookmark.destroy_all
List.destroy_all
Movie.destroy_all

# Seed movies from the API
url = "http://tmdb.lewagon.com/movie/top_rated"
response = URI.open(url).read
movies = JSON.parse(response)["results"]

movies.each do |movie|
  Movie.create(
    title: movie["title"],
    overview: movie["overview"],
    poster_url: "https://image.tmdb.org/t/p/w500#{movie["poster_path"]}",
    rating: movie["vote_average"]
  )
end

puts "#{Movie.count} movies seeded"
