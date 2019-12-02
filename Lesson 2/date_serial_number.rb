=begin
Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя). Найти порядковый номер даты, начиная отсчет с начала года. Учесть, что год может быть високосным. (Запрещено использовать встроенные в ruby методы для этого вроде Date#yday или Date#leap?).
=end

puts "Type day of the month: "
day = gets.chomp.to_i
puts "Type month: "
month = gets.chomp.to_i
puts "Type year: "
year = gets.chomp.to_i

if (day > 31) || (month > 12) || (year < 1)
  abort "Try again later! Wrong arguments!"
end

hash_month = {
  january: 31,
  february: 28,
  march: 31,
  april: 30,
  may: 31,
  june: 30,
  july: 31,
  august: 31,
  september: 30,
  october: 31,
  november: 30,
  december: 31
}

hash_month[:february] = 29 if (year % 4 == 0) || (year % 400 == 0) && (year % 100 != 0)

days_array = hash_month.values.take(month - 1)
number_of_day = day + days_array.sum

puts "Date serial number is #{number_of_day}"
