=begin
  Вычисление идеального веса человека.
  Программа запрашивает имя и рост.
  После подсчета выводит идеальный вес.
=end

class Man
  attr_reader :first_name

  def initialize
    puts 'What is your name?'
    @first_name = gets.chomp
    puts 'How tall are you?'
    @height = Integer(gets.chomp)
  end

  def ideal_weight
    (@height - 110) * 1.15
  end
end

man = Man.new
if man.ideal_weight.negative?
  puts "#{man.first_name}, your weight is ideal now."
else
  puts "#{man.first_name}, your ideal weight is #{man.ideal_weight.round(2)} kilograms." # Метод round() сокращает количество знаков после запятой до 2 во Float
end
