=begin
Заполнить массив числами от 10 до 100 с шагом 5.
=end

array = []

for n in (10..100)
  array.push(n) if n % 5 == 0
end

puts array
