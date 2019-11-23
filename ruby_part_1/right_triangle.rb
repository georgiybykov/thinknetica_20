=begin
  Прямоугольный треугольник. Программа запрашивает три стороны треугольника.
  После сравнений и подсчетов выводит результат: прямоугольный, равнобедренный, равносторонний или треугольник другого типа.
=end

class RightTriangle
  attr_reader :side1, :side2, :side3

  def initialize
    puts "Enter side 1 value:"
    @side1 = gets.chomp.to_f
    puts "Enter side 2 value:"
    @side2 = gets.chomp.to_f
    puts "Enter side 3 value:"
    @side3 = gets.chomp.to_f
  end

  def count
    a, b, h = [@side1, @side2, @side3].sort!
    if (@side1 == @side2) && (@side2 == @side3)
      puts "This triangle is equilateral."
    elsif (@side1 == @side2) || (@side2 == @side3) || (@side1 == @side3)
      puts "This triangle is isoscales."
    elsif (h ** 2) == (a ** 2 + b ** 2)
      puts "This triangle is rectangular."
    else
      puts "This is another type of triangle."
    end
  end
end

triangle = RightTriangle.new
triangle.count
