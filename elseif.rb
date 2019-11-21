print "Write your number: "
a = Integer(gets.chomp)

if a > 0
  puts "it's your number"
elsif a < 0
  puts "it's not your number"
else
  puts "it's zero - neutral number"
end
