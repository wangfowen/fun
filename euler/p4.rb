#Find the largest palindrome made from the product of two 3-digit numbers.

def is_palindrome?(n)
  for i in 0..(n.to_s.size / 2)
    return false unless (n.to_s[i] == n.to_s[-i - 1])
  end

  true
end

answer = 0

999.downto(900) do |a|
  999.downto(a) do |b|
    num = a * b
    if is_palindrome?(num) && num > answer
      answer = num
    end
  end
end

puts answer
