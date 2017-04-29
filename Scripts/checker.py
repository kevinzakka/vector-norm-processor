dir_path = "/media/sf_test_benches/"
file_path = "alu_res.txt"
file_path2 = "norm_adder.txt"

def parse_bin(s):
	t = s.split('.')
	return int(t[0], 2) + int(t[1], 2) / 2.**len(t[1])

# read test bench file
with open(dir_path + file_path2) as f:
	content = f.readlines()

# determine number of lines
num_lines = sum(1 for line in open(dir_path + file_path2))

# break up into [x, y, result]
res = content[num_lines-1].split(",")
res = [x.lstrip(' ').rstrip('\n') for x in res]

operands = []

# further breaking down
for i in range(1, 4):
	# split floating point representation
	num = res[i].split("_")

	# grab exponent and mantissa
	if i != 3:
		exp = num[1]
		mantissa = num[2]
	else:
		exp = num[0]
		mantissa = num[1]

	# format mantissa
	mantissa = '0.' + mantissa

	# shift by exponent
	s = list(" ".join(mantissa))
	pp = int(exp, 2)
	shift_amt = 2*pp + 3
	s[shift_amt] = '.'
	s[2] = " "
	s = [x for x in s if x != " "]
	s = "".join(s)

	# convert to integer
	int_repres = parse_bin(s)
	
	# store in list
	operands.append(int_repres)

# calculate correct value
x = operands[0]
y = operands[1]
norm = operands[2]
true_value = 80276.466796875

print("From Test Bench")
print("---------------")
print("norm: {}".format(norm))
print("Correct Value: {}".format(true_value))
print("Difference: {}".format(true_value-norm))