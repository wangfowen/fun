input_file = ARGV[0]

def run_tests(input_file)
  file = File.new(input_file)

  #first line is number of test cases
  num_test_cases = (file.gets).to_i

  #this may differ based on question
  num_test_cases.times do |i|
    #first line of each test case is number of lines
    num_lines = (file.gets).to_i
    data = []
    num_lines.times do |j|
      data << (file.gets).split("")
    end

    verdict = test_pass?(data, num_lines) ? "YES" : "NO"
    puts "Case ##{i + 1}: #{verdict}"
  end
end


=begin
You want to write an image detection system that is able to
recognize different geometric shapes. In the first version of the
system you settled with just being able to detect filled squares
on a grid.

You are given a grid of N×N square cells. Each cell is either
white or black.  Your task is to detect whether all the black
cells form a square shape.

Input

The first line of the input consists of a single number T,
the number of test cases.

Each test case starts with a line containing a single integer N.
Each of the subsequent N lines contain N characters. Each
character is either "." symbolizing a white cell, or "#"
symbolizing a black cell.  Every test case contains at least one
black cell.

Output

For each test case print YES if all the black cells form a
completely filled square with edges parallel to the grid of
cells.  Otherwise print NO.

Constraints

1 ≤ T ≤ 20
1 ≤ N ≤ 20
=end

def within_square?(row, column, start_row, start_column, max_size)
  if (row >= start_row && row <= start_row + max_size && column >= start_column && column <= start_column + max_size)
    return true
  else
    return false
  end
end

def test_pass?(data, n)
  start_row = -1
  start_column = -1
  max_size = -1

  n.times do |row|
    n.times do |column|
      #found a black cell
      if (data[row][column] == "#")
        #first black cell found
        if (max_size == -1)
          max_size = [n - column, n - row].min - 1
          start_row = row
          start_column = column
          next
        end

        if (!within_square?(row, column, start_row, start_column, max_size))
          return false
        end
      else
        #white cell
        if (max_size != -1 && within_square?(row, column, start_row, start_column, max_size))
          if (row == start_row)
            #max square size is now smaller
            max_size = column - start_column - 1
          else
            #otherwise, should not be in square
            return false
          end
        end
      end
    end
  end

  true
end

run_tests(input_file)
