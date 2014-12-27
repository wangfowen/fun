#given an array of tokens in infix notation, output a postfix string of it
#given [5, "+", 7, "*", 9] outputs "5 7 9 * +"

def to_postfix(infix_tokens)
  output = ""
  op_precedence = { "-" => 0, "+" => 1, "*" => 2, "/" => 3, "^" => 4 }
  op_stack = []
  child = []
  b_count = 0

  infix_tokens.each_with_index do |t, i|
    #if brackets, store til close bracket then recurse
    if t == "("
      b_count = b_count + 1
      if b_count == 1
        next
      end
    elsif t == ")"
      b_count = b_count - 1
      if b_count == 0
        output += to_postfix child
        next
      end
    end

    if b_count > 0
      child << t
      next
    end

    #if num, output
    if t.is_a? Fixnum
      output += t.to_s
    #if operator, see if there's higher precedence
    #if there's higher precedence pop that then push
    #if there's not, just push
    else
      if (op_precedence[t] < (op_precedence[op_stack.last] || 0))
        output += op_stack.pop
      end
      op_stack.push t
    end
  end

  #if hit end, pop operator remaining
  while !op_stack.empty? do
    output += op_stack.pop
  end
  output
end

puts to_postfix([5, "+", 7, "*", 9, "-", 3, "/", 4])
puts to_postfix([5, "*", "(", 7, "+", 9, ")"])
puts to_postfix([5, "*", "(", 7, "*", "(", 3, "+", 9, ")", ")", "/", 2])
puts to_postfix([5, "*", 7, "+", 9])
