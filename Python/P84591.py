def absValue(x):
    if (x >= 0):
        return x
    else:
        return x * -1

#print(absValue(-666))

def power(x, p):
    return pow(x, p)

#print(power(2, 3))

def isPrime(x):
    if (x <= 1):
        return False
    elif (x == 2):
        return True
    else:
        for i in range(2, int(x/2) + 1):
            if (x%i == 0):
                return False
        return True
    
#print(isPrime(17))

def slowFib(n):
    if (n == 0):
        return 0
    elif (n == 1):
        return 1
    else:
        return slowFib(n - 1) + slowFib(n - 2)
    
#print(slowFib(5))

def fib2(x, y, n):
    if (n != 0):
        return fib2(y, (x + y), (n - 1))
    else:
        return x

def quickFib(n):
    if (n == 0):
        return 0
    elif (n == 1):
        return 1
    else:
        return fib2(0, 1, n)
"""
def quickFib(n):
    def fib(i):
        if i == 0: return (0,0)
        if i == 1: return (0,1)
        (f2, f1) = fib(i-1)
        return (f1, f1 + f2)
    return fib(n)[1]
"""
#print(quickFib(40))
