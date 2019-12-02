=begin
Заполнить массив числами от 10 до 100 с шагом 5.
=end

array = (10..100).to_a
result_array = []

array.each do |a|
  result_array.push(a) if a % 5 == 0
end

puts result_array
