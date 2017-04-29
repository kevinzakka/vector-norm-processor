dir_path = "/media/sf_test_benches/"

doubly_float = [49, 34, 17, 40, 22, 18, 11, 6, 33, 12, 44, 34,
				28, 23, 5, 50, 0, 29, 39, 1]

with open(dir_path + "test_addr.txt", 'w') as f:
	for elem in doubly_float:
		float_repr = '0_00000000_' + '{:015b}'.format(elem)
		f.write('24\'b' + float_repr + "\n")