#given lawn of nxm, lawnmower can cut any row/column from 1-100 in one go
#is it possible to cut the lawn inputs?

# Input
# 3 <-- num test cases
# 3 3 <-- n,m of lawn
# 2 1 2 <-- desired heights
# 1 1 1
# 2 1 2
# 5 5
# 2 2 2 2 2
# 2 1 1 1 2
# 2 1 2 1 2
# 2 1 1 1 2
# 2 2 2 2 2
# 1 3
# 1 2 1

# Output
# Case #1: YES
# Case #2: NO
# Case #3: YES

Enumerable.class_eval do
  def mode
    group_by do |e|
      e
    end.values.max_by(&:size).first
  end
end

def lawnmower(filepath)
  file = File.new(filepath)

  num_test_cases = (file.gets).to_i
  results = ""

  num_test_cases.times do |i|
    n_m = file.gets
    n, m = n_m.split(' ')
    lawn = []
    result = "YES"

    #store in data structure
    n.to_i.times do |j|
      line = file.gets
      lawn << line.split(' ').map(&:to_i)
    end

    #calculate result

    #look at first row, for each one that's not the same as the mode,
    #look at the column. if the number is not the same, look at the row
    for row in 0...(n.to_i)
      comparer = lawn[row].mode

      #compare with comparer, if it's not the same, look at the column
      lawn[row].each_with_index { |num, column|
        if comparer != num
          for r in 0...(n.to_i)
            if lawn[r][column] != num
              result = "NO"
              break
            end
          end
        end
      }
    end

    results += "Case ##{i + 1}: #{result}\n"
  end

  puts results
end

lawnmower('B-small-attempt0.in')
