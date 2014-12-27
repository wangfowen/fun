#given a 2d array representing a boggle board and a dictionary of valid words
#find all the valid words in the board

class TrieNode
  attr_accessor :children, :letter, :word, :is_valid

  def initialize(letter, word)
    @letter = letter
    @word = word
    @is_valid = false
    @children = {}
  end
end

#creates a board that is dimension x dimension of falses except the one point
def populate_unvisited_except(visited_row, visited_col, board_dimension)
  visited_board = []

  board_dimension.times do |row|
    visited_row = []
    board_dimension.times do |col|
      if (row == visited_row && col == visited_col)
        visited_row << true
      else
        visited_row << false
      end
    end
    visited_board << visited_row
  end

  visited_board
end

def unvisited_neighbors(visited, start_row, start_col)
  unvisited_neighbors = []

  #assuming board is dimension x dimension
  max_dimension = visited.size - 1
  lower_row = [0, start_row - 1].max
  upper_row = [start_row + 1, max_dimension].min
  lower_col = [0, start_col - 1].max
  upper_col = [start_col + 1, max_dimension].min

  (lower_row..upper_row).each do |row|
    (lower_col..upper_col).each do |col|
      if (!visited[row][col])
        unvisited_neighbors << [row,col]
      end
    end
  end

  unvisited_neighbors
end

def create_trie(valid_words)
  root = TrieNode.new("", "")
  current_node = root

  valid_words.each do |word|
    word_so_far = ""
    parent_node = root

    word.split("").each do |letter|
      word_so_far = word_so_far + letter

      if (parent_node.children.has_key?(letter))
        current_node = parent_node.children[letter]
      else
        current_node = TrieNode.new(letter, word_so_far)
        parent_node.children[letter] = current_node
      end

      parent_node = current_node
    end

    current_node.is_valid = true
  end

  root
end

def find_words(board, start_row, start_col, visited, remaining_valid_words)
  words_in_board = []

  if (remaining_valid_words.children.has_key?(board[start_row][start_col]))
    visited[start_row][start_col] = true

    child = remaining_valid_words.children[board[start_row][start_col]]
    neighbors = unvisited_neighbors(visited, start_row, start_col)

    if (neighbors.size > 0)
      neighbors.each do |row, col|
        words_in_board << find_words(board, row, col, visited, child)
      end
    end

    if (child.is_valid)
      words_in_board << child.word
    end

    visited[start_row][start_col] = false
  end

  words_in_board
end

def boggle_words(board, valid_words)
  puts "----------"

  remaining_valid_words = create_trie(valid_words)
  words_in_board = []

  board.size.times do |row|
    board.size.times do |col|
      visited = populate_unvisited_except(row, col, board.size)

      words_in_board << find_words(board, row, col, visited, remaining_valid_words)
    end
  end

  words_in_board.flatten.uniq
end

#diagonal words, horizontal words, vertical words, a combination of them, words built on other words,
#doesn't repeat visited letters
board1 = [
          ["a", "s", "n", "t"],
          ["h", "u", "r", "g"],
          ["n", "e", "f", "b"],
          ["w", "e", "t", "q"]
         ]
#zaps should be out of reach and not show up, should branch from a to both zag and zap
board2 = [
          ["z", "a", "z"],
          ["z", "g", "p"],
          ["s", "z", "z"]
         ]
board3 = [[]]

valid_words = ["zap", "has", "sue", "few", "zaps", "zag", "ha", "he", "hen", "a", "wet", "aha", "nerf", "hunt"]

puts boggle_words(board1, valid_words)
puts boggle_words(board2, valid_words)
puts boggle_words(board3, valid_words)

valid_words = []

puts boggle_words(board1, valid_words)
