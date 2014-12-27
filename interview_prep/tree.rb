#Write code to print out a binary tree where each row is comma-separated and
#contains nodes at the same depth. Each node has a single letter.
#So if the tree is:
#
#     A
#   /   \
#  B     C
# / \   /
#D   E F
#   /   \
#  G     H
#
#you would want to print out:
#A
#B,C
#D,E,F
#G,H

#You're given which node is the head and each node object has a method for 
#its value, the left node below it and the right node below it


class TreeParse
	current_level = [Node.head]
	next_level = []
	
	while !current_level.empty?
		puts current_level.value.join(', ')
		current_level.each do |node|
			next_level << node.left_node unless node.left_node.nil?
			next_level << node.right_node unless node.right_node.nil?
		end
		current_level = next_level
		next_level = []
	end
end