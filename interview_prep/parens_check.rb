def proper_parens(string)
  count = 0
  string.each_char do |c|
    if c == "("
      count += 1
    elsif c == ")"
      count -= 1
    end

    if count < 0
      return false
    end
  end

  count == 0
end

puts proper_parens("(sdfsdf)")
puts proper_parens("((sdfsdf)")
puts proper_parens("sdfsdf(sdfsdf))")
puts proper_parens(")(")
