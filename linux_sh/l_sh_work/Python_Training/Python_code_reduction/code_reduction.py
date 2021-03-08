#!/usr/bin/env python3

a = [ a for a in range(1,11) if a%2 != 0 ]
print(a,"= a")
b = [ b for b in range(1,11) if b%2 != 1 ]
print(b,"= b")

def my_sum(lis1, lis2):
	new_list = []
	tmp_rez = 0
	if len(lis1) >= len(lis2):
		for count in range(len(lis2)):
			tmp_rez = lis2[count] + lis1[count]
			new_list.append(tmp_rez)
	else:
		for count in range(len(lis1)):
			tmp_rez = lis1[count] + lis2[count]
			new_list.append(tmp_rez)
	return new_list

c = my_sum(a,b)
print(c,"| c = my_sum(a,b) = c")

def new_sum(x,y):
	return x+y
c = list(map(new_sum,a,b))
print(c,"| c = list(map(new_sum,a,b))")

c = list(map(lambda x,y: x+y,a,b))
print(c,"| c = list(map(lambda x,y: x+y,a,b))")

d = list(map(lambda x,y: x+y, list(a for a in range(1,11) if a%2 != 0), list(b for b in range(1,11) if b%2 != 1)))
print(d,"= d")
