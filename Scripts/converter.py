dir_path = "/media/sf_test_benches/"

def parse_bin(s):
	# check sign bit
	if s[0] == '1':
		neg = 1
	else:
		neg = 0
	s = s[1:]

	# proceed with conversion
	t = s.split('.')
	result = int(t[0], 2) + int(t[1], 2) / 2.**len(t[1])
	if neg: result *= -1
	return result

def float_to_bin(x):
	if x == 0:
		return "0" * 64
	# grab sign
	w, sign = (float.hex(x), 0) if x > 0 else (float.hex(x)[1:], 1)
	# parse mantissa
	mantissa = int(w[2:17][0] + w[2:17][2:], 16)
	mantissa = bin(mantissa)[2:17]
	# parse exponent
	exp = int(w[18:]) + 1
	return "{}_{:08b}_{}".format(sign, exp, mantissa)

def bin_to_float(x):
	num = x.split("_")

	sign = num[0]
	exp = num[1]
	mantissa = num[2]
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
	s = sign + s
	int_s = parse_bin(s)
	return int_s

doubly_float = [-33.125, 23.75, 19.03125, 102.0, 25.5, -93.125, 8.125, 90.09375, 
		   		31.28125, 32.34375, 47.0625, -11.46875, 25.75, 88.125, 56.59375,
		   		48.65625, 112.71875, 69.78125, 101.96875, 63.25]

test = [-33.125, 23.75, 101.96875, 63.25]

# p = '0_000010001_100111001100101000111011110000'
# x = doubly_float[3]
# xy = float_to_bin(x)
# xyz = bin_to_float(p)
# print(xyz)

# with open(dir_path + "test_vectors.txt", 'w') as f:
# 	for elem in doubly_float:
# 		float_repr = float_to_bin(elem)
# 		f.write("24'b" + float_repr + "\n")

norm = 0.0
for elem in test:
	square = (elem)**2
	norm += square
print(norm)

# 12427.5166015625

tt = '0_000001110_111110101110111000010001000000'
xy = bin_to_float(tt)
print(xy)