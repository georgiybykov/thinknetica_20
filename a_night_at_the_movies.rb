movies = {
  Echo: 4.8,
  Batman: 4.7,
  Superman: 4.9,
  YesMan: 4.5
  }

puts 'What would you like to do?'
choice = gets.chomp

case choice
when "add"
  puts 'What movie would you like to add?'
  title = gets.chomp
  if movies[title.to_sym].nil?
    puts 'What rating does the movie have?'
    rating = gets.chomp
    movies[title] = rating.to_i
    puts "Your movie #{title} is added with rating #{rating}."
  else
    puts "That movie already exists with rating #{movies[title.to_sym]}."
  end
when "update"
  puts 'Which movie is up to update?'
  title = gets.chomp
  if movies[title.to_sym].nil?
    puts 'That movie does not exist.'
  else
    puts 'What rating does the movie have?'
    rating = gets.chomp
    movies[title.to_sym] = rating.to_i
    puts "Your movie rating is updated to #{rating}."
  end
when "display"
  movies.each do |name, rating|
    puts "#{name}: #{rating}"
  end
when "delete"
  puts 'Type the title of the movie:'
  title = gets.chomp
  if movies[title.to_sym].nil?
    puts 'That movie does not exist.'
  else
    movies.delete(title.to_sym)
  end
else
  puts 'Error!'
end
