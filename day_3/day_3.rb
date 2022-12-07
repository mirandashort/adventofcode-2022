require 'csv'

# common types must go in same compartment
# first half of string is one compartment; second another
# example:
# vJrwpWtwJgWrhcsFMMfFFhFp: vJrwpWtwJgWr; hcsFMMfFFhFp
# `p` in both
# priority: a-z: 1-26; A-Z: 27-52

# part 1

def char_type(char)
  if char == char.upcase
    "upper"
  else
    "lower"
  end
end

strings = []
CSV.foreach("/Users/mirandashort/adventofcode-2022/day_3/day_3_input.csv", headers: false, row_sep: "\n") do |row|
  strings << row[0]
end

char_values = ('a'..'z').to_a
sum_score = 0
strings.each do |str|
  left, right = str.chars.each_slice((str.size/2).round).to_a
  matching_char = (left & right).first

  score = char_values.index(matching_char.downcase) + (char_type(matching_char) == "lower" ? 1 : 27)
  sum_score += score
end

puts sum_score

# part 2

def char_type(char)
  if char == char.upcase
    "upper"
  else
    "lower"
  end
end

strings = []
row_count = 0
current_set = []
CSV.foreach("/Users/mirandashort/adventofcode-2022/day_3/day_3_input.csv", headers: false, row_sep: "\n") do |row|
  row_count += 1
  current_set << row[0]

  if row_count == 3
    strings << current_set
    current_set = []
    row_count = 0
  end
end

char_values = ('a'..'z').to_a
sum_score = 0
strings.each do |arr|
  x, y, z = arr[0].chars, arr[1].chars, arr[2].chars
  common_char = (x & y & z).first
  score = char_values.index(common_char.downcase) + (char_type(common_char) == "lower" ? 1 : 27)
  sum_score += score
end

puts sum_score
