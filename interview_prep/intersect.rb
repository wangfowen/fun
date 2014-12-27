#Given two arrays of letters, output an array of the intersections
#For example, given ["a", "a", "b", "c"] and 
#["a", "a", "a", "b"] output ["a", "a", "b"]

def intersect array_1, array_2
	output = []
	while (letter_1 = array_1.shift)
		array_2.each_with_index do |letter_2, i|
			if (letter_1 == letter_2)
				output << array_2.delete_at(i)
				break
			end
		end
	end
	puts output
end