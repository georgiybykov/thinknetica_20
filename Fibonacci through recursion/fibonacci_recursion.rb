=begin
Each time the code branches off again you are calling the fibonacci function from within itself two times. If you take all of those ones and zeros and add them together, you'll get the same answer you get when you run the code. You can see why computer programs are handy now. Think if you had to draw that diagram out every time you wanted to know the fibonacci respresentation of a number.
=end


def fibonacci(number)
  if number < 2
    number
  else
    fibonacci(number - 1) + fibonacci(number - 2)
  end
end

puts fibonacci(6)
