#Roman numerals were used by the ancient Romans to signify values using letters from the Latin alphabet. 
#Roman numerals went out of fashion around the 14th century, when they were superceded by the Arabic numerals we use today.
#Roman numerals are still used in certain applications today, such as to denote the production year of TV programs and films. 
#Modern Roman numerals are made up of 7 symbols; these symbols have the following values:
#I = 1, V = 5, X = 10, L = 50, C = 100, D = 500, M = 1000
#Roman numerals can be converted to Arabic by adding the values of the symbols together, 
#for example, MM is (1000 + 1000) = 2000, or MMXII is (1000 + 1000 + 10 + 1 + 1) = 2012.
#Numbers are placed in order of value (large to small), when a smaller value precedes a larger value, 
#the smaller value is subtracted from the larger value.
#I can be subtracted from V and X to give 4 or 9; X can be subtracted from L and C to give 40 or 90; 
#C can be subtracted from D or M to give 400 or 900. V, L and D can never be subtracted.
#The addition of these rules mean that the 1999 is written as MCMXCIX rather than MDCCCCLXXXXVIIII.
#In this challenge we will give you a Roman Numeral, your code must process this numeral and output an Arabic number.

#EXAMPLE INPUT (ROMAN)
roman = "MCMXCIX"

#DESIRED OUTPUT
#1999

def to_arabic_numeral(roman)
	arabic = 0
	value = {"I" => 1, "V" => 5, "X" => 10, "L" => 50, "C" => 100, "D" => 500, "M" => 1000}
	while (!(current = roman.slice!(0)).nil?)
		(value[roman.byteslice(0)] || 0) > value[current] ? arabic -= value[current] : arabic += value[current]
	end

	arabic

	#interesting: ?X = string X
end

puts to_arabic_numeral(roman)