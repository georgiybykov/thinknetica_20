puts "How is your name?"
name = gets.chomp

puts "When were you born?"
year = gets.chomp

puts "#{name}, hello! You are #{2019 - year.to_i} years."
