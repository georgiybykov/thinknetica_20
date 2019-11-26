=begin
  Квадратное уравнение. Пользователь вводит три коэффициента.
  Программа вычисляет дискриминант и корни уравнения.
  Выводит значения дискриминанта и корней на экран.
=end

class QuadraticEquation
  def initialize
    puts 'Enter 1 coefficient:'
    @a = gets.chomp.to_f
    puts 'Enter 2 coefficient:'
    @b = gets.chomp.to_f
    puts 'Enter 3 coefficient:'
    @c = gets.chomp.to_f
  end

  def discriminant
    @d = @b**2.0 - 4.0 * @a * @c
  end

  def count
    if @d > 0
      puts "The discriminant equals to #{@d}. First root equals to #{x1.round(2)}. Second root equals to #{x2.round(2)}."
    elsif @d == 0
      puts "The discriminant equals to #{@d}. Both roots of the equation equal to #{x1.round(2)}."
    else
      puts "The discriminant equals to #{@d}. The equation does not have roots."
    end
  end

  def x1
    @x1 = -@b + Math.sqrt(@d) / 2.0 * @a
  end

  def x2
    @x2 = -@b - Math.sqrt(@d) / 2.0 * @a
  end
end

equation = QuadraticEquation.new
equation.discriminant
equation.count
