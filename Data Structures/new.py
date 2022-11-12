data=[1,2,3]

def incr(x):
    return x+1
print(list(map(incr, data)))    

array = ['Welcome', 'To', 'T']
print ("-".join(array))

try:
    print("h")
except:
    print("y")
finally:
    print("T")        

print(2**(3**2),(2**3)**2,(2**3)**3)

list1=[1,2,6,12]
list2=[12,6,2,1]
print(list1==list2)
print(set(list1)== set(list2))

list1=[1,2,6,12]
list1.pop()
print(data)