require 'csv'

elves = []
calories_for_elf = []
CSV.foreach("/Users/mirandashort/Downloads/input.csv", headers: false) do |row|
  if !row[0].nil?
    calories_for_elf << row[0].to_i
  else
    elves << calories_for_elf.sum
    calories_for_elf = []
    next
  end
end
