from functools import reduce

def evens_product(L):
	return reduce(lambda x, y: x * y, list(filter(lambda x: x % 2 == 0, L)), 1)

#print(evens_product([1,2,3,4]))

def reverse(L):
	return reduce(lambda x, y: [y] + x, L, [])

#print(reverse([1,2,3]))

def zip_with(f, L1, L2):
    return list(map(lambda x: f(x[0], x[1]), zip(L1, L2)))

#print(zip_with(lambda x, y: x * y, [1, 2, 3], [10, 2]))

def count_if(f, L):
    return len(list(filter(lambda x: f(x), L)))

#print(count_if(lambda x: x % 2 == 0, [1, 2, 3, 4, 5]))