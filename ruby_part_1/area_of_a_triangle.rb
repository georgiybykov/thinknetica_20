=begin
  Вычесление площади теругольника.
  Программа запрашивает величину основания и высоту треугольника.
  После вычисления выводит площадь треугольника.
=end

class Triangle
  attr_reader :base, :height

  def initialize
    puts "What is triangle base?"
    @base = gets.chomp.to_f
    puts "What is triangle height?"
    @height = gets.chomp.to_f
  end

  def area
    0.5 * @base * @height
  end
end

triangle = Triangle.new
puts "The triangle area is #{triangle.area}"
