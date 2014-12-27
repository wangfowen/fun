#You will be passed a newline separated list of objects given as gifts on sequential dates, 
#along with their quantity (either an integer or a more English representation of a single item). 
#These are in reverse order of date, with the last item representing the first day. 
#The challenge is to determine the total number of gifts received up to the Nth day. 
#The day is passed as a positive integer and will always be less than or equal to the number of lines in the gift list. 
#The number of items on each day will be ramdom so don't assume there's one more item each day!

#EXAMPLE INPUT (GIFTS)
gifts = "12 Drummers Drumming 
11 Pipers Piping
10 Lords-a-Leaping
9 Ladies Dancing 
8 Maids-a-Milking 
7 Swans-a-Swimming 
6 Geese-a-Laying 
5 Gold Rings 
4 Colly Birds 
3 French Hens 
2 Turtle Doves 
A Partridge in a Pear Tree."

#EXAMPLE INPUT (DAY)
day = 10

#DESIRED OUTPUT
#55

def count_gifts(gifts, day)
	giftCount = 0
	gifts.split(/\n/).reverse!.each_with_index do |gift, index|
		if index >= day.to_i
			return giftCount
		end
		count = /(^[0-9A]*)/.match(gift)[1]
		if count == "A"
			giftCount += 1
		else
			giftCount += count.to_i
		end
	end

	gifts.scan(/^\S+/)

	#shortest solution: eval "A=1;"+gifts.scan(/^\S+/).pop(day)*?+
	#other cool things: ("11 Pipers Piping").to_i returns 11
end

puts count_gifts(gifts, day)