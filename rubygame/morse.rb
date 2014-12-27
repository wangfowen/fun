#This week we'd like you to design and implement a morse code interpreter. 
#We'll provide you with a string of dots and dashes and your interpreter will need to translate these back to English.
#We'll be using the letters A-Z only of the international (ITU) Morse code astandard. 
#Letter	Morse	Letter	Morse
#A		.-		N		-.
#B		-...	O		---
#C		-.-.	P		.--.
#D		-..		Q		--.-
#E		.		R		.-.
#F		..-.	S		...
#G		--.		T		-
#H		....	U		..-
#I		..		V		...-
#J		.---	W		.--
#K		-.-		X		-..-
#L		.-..	Y		-.--
#M		--		Z		--..
#Letters will be separated by a single blank space, words will be separated by 3 blank spaces. 
#Your function should return uppercase characters only.

#EXAMPLE INPUT (MORSE)
morse = ".... . .-.. .--.   -- .   --- ..- -   --- ..-.   - .... .. ...   .-- . .-.. .-.."

#DESIRED OUTPUT
#HELP ME OUT OF THIS WELL

def morse_to_eng(morse)
	convert = {".-" => "A", "-..." => "B", "-.-." => "C", "-.." => "D",
		"." => "E", "..-." => "F", "--." => "G", "...." => "H", ".." => "I",
		".---" => "J", "-.-" => "K", ".-.." => "L", "--" => "M", "-." => "N",
		"---" => "O", ".--." => "P", "--.-" => "Q", ".-." => "R", "..." => "S",
		"-" => "T", "..-" => "U", "...-" => "V", ".--" => "W", "-..-" => "X",
		"-.--" => "Y", "--.." => "Z"}
	letter = ""
	sentence = ""
	while (!morse.strip.empty?)
		while (!morse.slice(0,3).strip.empty?)
			if (!(l = morse.slice!(0)).strip.empty?)
				letter.concat(l)
			else
				sentence.concat(convert[letter])
				letter = ""
			end
		end
		sentence.concat(convert[letter] + " ")
		morse.slice!(0,3)
		letter = ""
	end
	sentence.strip

	#this is embarassing... second slowest submission so far
	#split and gsub are much much better
end

puts morse_to_eng(morse)