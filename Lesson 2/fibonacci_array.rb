=begin
Заполнить массив числами Фибоначчи до 100.
=end

fib_array = [0, 1]

loop do
  num = fib_array[-2] + fib_array[-1]
  break if num >= 100
  fib_array << num
end

p fib_array
