require 'csv'

# (1 for Rock, 2 for Paper, and 3 for Scissors)
# (0 if you lost, 3 if the round was a draw, and 6 if you won).
# order by win, lose, draw

# rock: a, x
# paper: b, y
# scissors: c, z

# part 1
def options
  @options ||= {
    rock: { them: 'A', me: 'X', points: 1, beats: :scissors },
    paper: { them: 'B', me: 'Y', points: 2, beats: :rock },
    scissors: { them: 'C', me: 'Z', points: 3, beats: :paper }
  }
end

def result(options, them, me)
  their_throw = options.select { |_k, v| v[:them] == them }.keys.first
  my_throw = options.select { |_k, v| v[:me] == me }.keys.first

  if their_throw == my_throw
    return options[my_throw][:points] + 3
  elsif options[my_throw][:beats] == their_throw
    return options[my_throw][:points] + 6
  elsif options[their_throw][:beats] == my_throw
    return options[my_throw][:points]
  end

  points
end

total_points = []
CSV.foreach("/Users/mirandashort/adventofcode-2022/day_2/day_2_input.csv", headers: false) do |row|
  throws = row[0].split(" ")
  them = throws.first
  me = throws.last

  total_points << result(options, them, me)
end

puts total_points.sum

# part 2

# x == lose
# y == draw
# z == win

def options
  @options ||= {
    rock: { val: 'A', points: 1, beats: :scissors, loses_to: :paper },
    paper: { val: 'B', points: 2, beats: :rock, loses_to: :scissors },
    scissors: { val: 'C', points: 3, beats: :paper, loses_to: :rock }
  }
end

def extra_points
  @extra_points ||= {
    win: 6,
    lose: 0,
    draw: 3
  }
end

def points(options, them, result)
  their_throw = options.select { |_k, v| v[:val] == them }.keys.first

  case result
  when :win
    my_throw = options[their_throw][:loses_to]
  when :lose
    my_throw = options[their_throw][:beats]
  when :draw
    my_throw = their_throw
  end

  options[my_throw][:points] + extra_points[result]
end

total_points = []

CSV.foreach("/Users/mirandashort/adventofcode-2022/day_2/day_2_input.csv", headers: false) do |row|
  throws = row[0].split(" ")
  them = throws.first
  result = throws.last
  results = { "X" => :lose, "Y" => :draw, "Z" => :win }

  total_points << points(options, them, results[result])
end

puts total_points.sum
