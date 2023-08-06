def myLength(L):
    return len(L)

#print(myLength([1,3,6,1]))

def myMaximum(L):
    max = L[0]
    for i in L:
        if (i > max):
            max = i
    return max

#print(myMaximum(['josep', 'jordi', 'albert']))

def average(L):
    average = 0.0
    for i in range(0, len(L)):
        average += L[i]
    average = average / len(L)
    return average

#print(average([1,2,3]))

def buildPalindrome(L):
    l = []
    for i in L[::-1]:
        l.append(i)
    for i in L:
        l.append(i)
    return l

#print(buildPalindrome(['pa','amb','oli']))

def remove(L1, L2):
    l = []
    for i in L1:
        if (i not in L2):
            l.append(i)
    return l
#print(remove([1,4,5,3,4,5,1,2,7,4,2], [2,4]))

"""
def remove(L1, L2):
    l = []
    for i in L1:
        found = False
        print(i)
        for j in L2:
            if (i == j):
                print(j)
                found = True
        if (found == False):
            l.append(i)
    return l
        
print(remove([1,4,5,3,4,5,1,2,7,4,2], [2,4])) 
"""

def flatten(L):
    l = []
    for i in L:
        if type(i) is list:
            l += flatten(i)
        else:
            l.append(i)
    return l

#print(flatten([[2,6],[[8,1,4],[3,'uau']],[[],[1]],[[]]]))

def oddsNevens(L):
    odds = []
    evens = []
    for i in L:
        if (i%2 == 0):
            evens.append(i)
        else:
            odds.append(i)
    return (odds, evens)

#print(oddsNevens([1,4,5,3,4,5,1,2,7,4,2]))

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

def primeDivisors(n):
    primeD = []
    for i in range(2, n + 1):
        if (n%i == 0 and isPrime(i)):
            primeD.append(i)
    return primeD

#print(primeDivisors(255))
    
