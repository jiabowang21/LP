from functools import reduce

def count_unique(L):
	return len(set(L))

#print(count_unique([1,3,2,2,3,4]))
"""
def remove_duplicates(L):
	l = []
	for i in set(L):
		l.append(i)
	return l
"""
def remove_duplicates(L):
    return list(set(L))
#print(remove_duplicates([3,1,3,2,3,2,3,4]))

"""
def flatten(L):
	res = []
	for sub_l in L:
		res += sub_l
	return res
"""

def flatten(L):
    return reduce(lambda l1, l2: l1 + l2, L, [])

#print(flatten([[2, 6], [8, 1, 4], [], [1]]))

"""
def flatten_rec(L):
	res = []
	for sub_l in L:
		if isinstance(sub_l, list):
			res += flatten_rec(sub_l)
		else:
			res.append(sub_l)
	return res
"""
def flatten_rec(L):
    return reduce(lambda l1,l2: l1+(flatten_rec(l2) if isinstance(l2, list) else [l2]), L, [])

#print(flatten_rec([3, [1], [], [4, [], [5, 3]], [2, 1]]))
