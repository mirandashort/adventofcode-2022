require 'csv'

elves = []
calories_for_elf = []
CSV.foreach("/Users/mirandashort/adventofcode-2022/day_1/day_1_input.csv", headers: false) do |row|
  if !row[0].nil?
    calories_for_elf << row[0].to_i
  else
    elves << calories_for_elf.sum
    calories_for_elf = []
    next
  end
end

# elf with the most
puts elves.max

# top 3
puts elves.sort.last(3).sum
