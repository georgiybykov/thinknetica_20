=begin
Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).
=end

alph_arr = ('a'..'z').to_a
vowels = ['a', 'e', 'i', 'o', 'u']
hash_vow = {}

vowels.each do |v|
  hash_vow[v] = alph_arr.find_index(v) + 1
end

puts hash_vow
