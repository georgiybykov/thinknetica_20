array = (10..100).to_a
array2 = []

array.each do |a|
  if a % 5 == 0
    array2.push(a)
  end
end

puts array2
