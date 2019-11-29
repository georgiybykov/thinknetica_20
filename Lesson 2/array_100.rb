=begin
Заполнить массив числами от 10 до 100 с шагом 5.
=end

array = []

for n in (10..100)
  if n % 5 == 0
    array.push(n)
  end
end

puts array
