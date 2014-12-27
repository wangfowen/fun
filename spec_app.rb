class B
	def initialize hash = {} 
		@grid = hash 
	end

	def [] a, b, c = nil
		r = @grid[a]
		return r[b] if r
		nil
	end

	def []=(a, b, v)
		(@grid[a] ||= {})[b] = v
	end

	def neighbours(r, c)
		n = 0
		[ -1, 0, 1 ].each { |ri|
			[ -1, 0, 1 ].each { |ci|
				next if ri == 0 and ci == 0
				n += 1 if self[r + ri, c + ci]
			}
		}
		n
	end

	def evolve!
		gen = self.class.new
		@grid.keys.each { |row|
			@grid.keys.each { |col| 
				n = neighbours(row, col)
				if self[row, col]
					if (n < 2 || n > 3)
						gen[row, col] = nil
					else
						gen[row, col] = true
					end
				else
					gen[row, col] = true if n == 3
				end
			}
		}
		@grid.replace(gen.instance_variable_get(:@grid))
	end

	def ==(other)
		case other
		when B
			other.instance_variable_get(:@grid) == @grid
		else
			other == @grid
		end
	end
end

describe "Conway's Game of Life" do
	subject { B.new({ 0 => { 1 => true }, 1 => { 1 => true }, 2 => { 1 => true }}) }


	it "should have an initial state" do
		subject[1, 1].should == true
	end

	it "should return nil for uninitialized squares" do
		subject[3, 3].should == nil
	end

	it "should be comparable" do
		z = B.new({ 0 => { 1 => true }, 1 => { 1 => true }, 2 => { 1 => true }})
		subject.should == z
	end

	

	it "should play the game" do
		subject.evolve!
		z = B.new({ 0 => { 1 => nil}, 1 => { 0 => true, 1 => true, 2 => true }, 2 => { 1 => nil }})
		z.should == subject
	end

	it "should work in 3D" do
		b = B.new({0 => {1 => {1 => true}, 2 => {1 => true}}, 2 => {1 => {1 => true}, 2 => {1 => true}}})
		b[1,1,1].should == true # can't be plane 1 is not set at all
	end
end