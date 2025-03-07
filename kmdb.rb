# In this assignment, you'll be using the domain model from hw1 (found in the hw1-solution.sql file)
# to create the database structure for "KMDB" (the Kellogg Movie Database).
# The end product will be a report that prints the movies and the top-billed
# cast for each movie in the database.

# To run this file, run the following command at your terminal prompt:
# `rails runner kmdb.rb`

# Requirements/assumptions
#
# - There will only be three movies in the database – the three films
#   that make up Christopher Nolan's Batman trilogy.
# - Movie data includes the movie title, year released, MPAA rating,
#   and studio.
# - There are many studios, and each studio produces many movies, but
#   a movie belongs to a single studio.
# - An actor can be in multiple movies.
# - Everything you need to do in this assignment is marked with TODO!
# - Note rubric explanation for appropriate use of external resources.

# Rubric
# 
# There are three deliverables for this assignment, all delivered within
# this repository and submitted via GitHub and Canvas:
# - Generate the models and migration files to match the domain model from hw1.
#   Table and columns should match the domain model. Execute the migration
#   files to create the tables in the database. (5 points)
# - Insert the "Batman" sample data using ruby code. Do not use hard-coded ids.
#   Delete any existing data beforehand so that each run of this script does not
#   create duplicate data. (5 points)
# - Query the data and loop through the results to display output similar to the
#   sample "report" below. (10 points)
# - You are welcome to use external resources for help with the assignment (including
#   colleagues, AI, internet search, etc). However, the solution you submit must
#   utilize the skills and strategies covered in class. Alternate solutions which
#   do not demonstrate an understanding of the approaches used in class will receive
#   significant deductions. Any concern should be raised with faculty prior to the due date.

# Submission
# 
# - "Use this template" to create a brand-new "hw2" repository in your
#   personal GitHub account, e.g. https://github.com/<USERNAME>/hw2
# - Do the assignment, committing and syncing often
# - When done, commit and sync a final time before submitting the GitHub
#   URL for the finished "hw2" repository as the "Website URL" for the 
#   Homework 2 assignment in Canvas

# Successful sample output is as shown:

# Movies
# ======

# Batman Begins          2005           PG-13  Warner Bros.
# The Dark Knight        2008           PG-13  Warner Bros.
# The Dark Knight Rises  2012           PG-13  Warner Bros.

# Top Cast
# ========

# Batman Begins          Christian Bale        Bruce Wayne
# Batman Begins          Michael Caine         Alfred
# Batman Begins          Liam Neeson           Ra's Al Ghul
# Batman Begins          Katie Holmes          Rachel Dawes
# Batman Begins          Gary Oldman           Commissioner Gordon
# The Dark Knight        Christian Bale        Bruce Wayne
# The Dark Knight        Heath Ledger          Joker
# The Dark Knight        Aaron Eckhart         Harvey Dent
# The Dark Knight        Michael Caine         Alfred
# The Dark Knight        Maggie Gyllenhaal     Rachel Dawes
# The Dark Knight Rises  Christian Bale        Bruce Wayne
# The Dark Knight Rises  Gary Oldman           Commissioner Gordon
# The Dark Knight Rises  Tom Hardy             Bane
# The Dark Knight Rises  Joseph Gordon-Levitt  John Blake
# The Dark Knight Rises  Anne Hathaway         Selina Kyle

# Delete existing data, so you'll start fresh each time this script is run.
# Use `Model.destroy_all` code.

Role.destroy_all
Movie.destroy_all
Actor.destroy_all
Studio.destroy_all

# Generate models and tables, according to the domain model.

warner_bros = Studio.create(name: "Warner Bros.")

movies = [
  { title: "Batman Begins", year_released: 2005, rated: "PG-13", studio: warner_bros },
  { title: "The Dark Knight", year_released: 2008, rated: "PG-13", studio: warner_bros },
  { title: "The Dark Knight Rises", year_released: 2012, rated: "PG-13", studio: warner_bros }
]

movies.each do |movie_data|
    Movie.create(movie_data)
  end

  actors = [
  "Christian Bale",
  "Michael Caine",
  "Liam Neeson",
  "Katie Holmes",
  "Gary Oldman",
  "Heath Ledger",
  "Aaron Eckhart",
  "Maggie Gyllenhaal",
  "Tom Hardy",
  "Joseph Gordon-Levitt",
  "Anne Hathaway"
]

actors.each do |actor_name|
    Actor.create(name: actor_name)
  end

# Insert data into the database that reflects the sample data shown above.
# Do not use hard-coded foreign key IDs.

roles = [
  { movie_title: "Batman Begins", actor_name: "Christian Bale", character_name: "Bruce Wayne" },
  { movie_title: "Batman Begins", actor_name: "Michael Caine", character_name: "Alfred" },
  { movie_title: "Batman Begins", actor_name: "Liam Neeson", character_name: "Ra's al Ghul" },
  { movie_title: "Batman Begins", actor_name: "Katie Holmes", character_name: "Rachel Dawes" },
  { movie_title: "Batman Begins", actor_name: "Gary Oldman", character_name: "Commissioner Gordon" },
  { movie_title: "The Dark Knight", actor_name: "Christian Bale", character_name: "Bruce Wayne" },
  { movie_title: "The Dark Knight", actor_name: "Heath Ledger", character_name: "Joker" },
  { movie_title: "The Dark Knight", actor_name: "Aaron Eckhart", character_name: "Harvey Dent" },
  { movie_title: "The Dark Knight", actor_name: "Michael Caine", character_name: "Alfred" },
  { movie_title: "The Dark Knight", actor_name: "Maggie Gyllenhaal", character_name: "Rachel Dawes" },
  { movie_title: "The Dark Knight Rises", actor_name: "Christian Bale", character_name: "Bruce Wayne" },
  { movie_title: "The Dark Knight Rises", actor_name: "Gary Oldman", character_name: "Commissioner Gordon" },
  { movie_title: "The Dark Knight Rises", actor_name: "Tom Hardy", character_name: "Bane" },
  { movie_title: "The Dark Knight Rises", actor_name: "Joseph Gordon-Levitt", character_name: "John Blake" },
  { movie_title: "The Dark Knight Rises", actor_name: "Anne Hathaway", character_name: "Selina Kyle" }
]

roles.each do |role_data|
    movie = Movie.find_by(title: role_data[:movie_title])
    actor = Actor.find_by(name: role_data[:actor_name])
    Role.create(movie: movie, actor: actor, character_name: role_data[:character_name])
  end


# Prints a header for the movies output
puts "Movies"
puts "======"
puts ""



# Query the movies data and loop through the results to display the movies output.


Movie.includes(:studio).all.each do |movie|
    puts "#{movie.title.ljust(25)} #{movie.year_released} #{movie.rated.ljust(5)} #{movie.studio.name}"
  end

# Prints a header for the cast output
puts ""
puts "Top Cast"
puts "========"
puts ""

# Query the cast data and loop through the results to display the cast output for each movie.

Role.includes(:movie, :actor).all.each do |role|
    puts "#{role.movie.title.ljust(25)} #{role.actor.name.ljust(20)} #{role.character_name}"
  end
