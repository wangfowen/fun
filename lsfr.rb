#init with 0001
nlfsr_init = [1,0,0,0]
#init with 1010
lfsr_init = [0,1,0,1]

#outputs 103 string of a
def lfsr(input)
  output = input

  #start from one after input
  (4...103).each do |i|
    #x1 + x0
    x0 = output[i - 4]
    x1 = output[i - 3]

    output << (x0 ^ x1)
  end

  output
end

lfsr_output = lfsr(lfsr_init)

#outputs 103 string of b
def nlfsr(input, lfsr)
  output = input

  (4...103).each do |i|
    #x0 + x1*x2 + x2*x3 + lfsr0
    x0 = output[i - 4]
    x1 = output[i - 3]
    x2 = output[i - 2]
    x3 = output[i - 1]
    lfsr0 = lfsr[i - 4]

    output << (x0 ^ (x1*x2) ^ (x2*x3) ^ lfsr0)
  end

  output
end

nlfsr_output = nlfsr(nlfsr_init, lfsr_output)

#ouputs 100 string of s
def output(lfsr, nlfsr)
  output = []

  #nlfsr0 + nlfsr3 + lfsr0*lfsr2
  (0...100).each do |i|
    nlfsr0 = nlfsr[i]
    nlfsr3 = nlfsr[i + 3]
    lfsr0 = lfsr[i]
    lfsr2 = lfsr[i + 2]

    output << (nlfsr0 ^ nlfsr3 ^ (lfsr0*lfsr2))
  end

  output
end

output = output(lfsr_output, nlfsr_output)

