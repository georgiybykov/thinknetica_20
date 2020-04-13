# Ruby exceptions and exceptions handling

# --------------------------------------

=begin

begin
  puts 'Before exception'
  Math.sqrt(-1)
rescue StandardError => e
  puts "Error!!!"
  raise
  puts e.backtrace
rescue NoMemoryError => e
  puts "No memory!!!"
end

puts 'After exception'

=end

# --------------------------------------

=begin

def method_with_error
  # ...
  raise ArgumentError, "Oh no!"
end

begin
  method_with_error
rescue RuntimeError => e
  puts e.inspect
end

puts "After exception"

=end

# --------------------------------------

=begin

def sqrt(value)
  sqrt = Math.sqrt(value)
  puts sqrt
rescue StandardError
  puts 'Incorrect value'
end

sqrt(-1)

=end

# --------------------------------------

def connect_to_wikipedia
  # ...
  raise 'Connection error'
end

attempt = 0
begin
  connect_to_wikipedia
rescue RuntimeError
  attempt += 1
  retry if attempt < 3
  # puts 'Check your internet connection!'
ensure
  puts "There was #{attempt} attempts."
end
