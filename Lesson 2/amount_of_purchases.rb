=begin
Пользователь вводит поочередно название товара, цену за единицу и кол-во купленного товара (может быть нецелым числом). Пользователь может ввести произвольное кол-во товаров до тех пор, пока не введет "стоп" в качестве названия товара.
На основе введенных данных требуетеся:
1) аполнить и вывести на экран хеш, ключами которого являются названия товаров, а значением - вложенный хеш, содержащий цену за единицу товара и кол-во купленного товара. Также вывести итоговую сумму за каждый товар.
2) Вычислить и вывести на экран итоговую сумму всех покупок в "корзине".
=end

cart = Hash.new

loop do
  puts "Type title of the product (or 'stop' to interrupt product input): "
  title = gets.chomp
  break if title == "stop"
  puts "Type product price: "
  price = gets.chomp.to_f
  puts "Type product amount: "
  amount = gets.chomp.to_f
  cart[title] = { "price" => price, "amount" => amount }
end

total_cart_price = 0
cart.each { |title, total| total_cart_price += total["price"] * total["amount"] }

puts cart


cart.each do |title, total_amount|
  amount_of_product = total_amount["price"] * total_amount["amount"]
  puts "For #{title} total amount is #{amount_of_product}"
end

puts "Total cart price is: #{total_cart_price}"
