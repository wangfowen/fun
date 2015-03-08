def banana(first_word, second_word)
  final_word = ""

  word_map = Hash[second_word.chars.map { |char| [char, 0] }]

  first_word.each_char do |char|
    if (!word_map[char].nil?)
      word_map[char] = word_map[char] + 1
    end
  end

  second_word.each_char do |char|
    word_map[char].times do |i|
      final_word = final_word + char
    end
    #done with that char, don't want for duplicates
    word_map[char] = 0
  end

  first_word.each_char do |char|
    if (word_map[char].nil?)
      final_word = final_word + char
    end
  end

  final_word
end

#normal case
puts banana("banana", "cab")
#empty
puts banana("", "cab")
puts banana("banana", "")
#make sure order preserved if second word not in order
puts banana("babac", "cab")
#spaces
puts banana("banana", "a b")
puts banana("ban ana", "ab")
puts banana("ban ana", "a b")
#duplicates
puts banana("banana", "aa")
