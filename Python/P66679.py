from functools import reduce


def my_map(f, L):
	return [f(x) for x in L]

"""
def my_map(f, L):
    return reduce(lambda acc, x: acc+[f(x)], L, [])
"""
#print(my_map(lambda x: x + 1, [1, 2, 3, 4]))

"""
def my_filter(f, L):
	return [x for x in L if f(x)]
"""

def my_filter(f, L):
    return reduce(lambda acc, x: acc + ([x] if f(x) == True else []), L, [])

#print(my_filter(lambda x: x % 2 == 1, [1, 2, 3, 4, 5]))

"""
def factors(n):
	return [x for x in range(1, n+1) if n%x == 0]
"""

def factors(n):
    return reduce(lambda acc, x: acc + ([x] if n%x == 0 else []), range(1,n+1), [])

#print(factors(10))

def triplets(n):
	return[(a, b, c)
			for a in range(1, n+1)
			for b in range(1, n+1)
			for c in range(b, n+1)
			if a * a + b * b == c * c]

#print(triplets(20))
