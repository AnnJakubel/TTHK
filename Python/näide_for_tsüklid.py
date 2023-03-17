list = [2, 4, 8]

for number in list:
    print(number)
      
print("")
      
for i in range(len(list)):
    list[i]*=3
# range(len(list)) kasutamisel saab listile ligi ja saab püsivalt
# muuta listi elementide väärtuseid

for number in list:
    print(number)

print("")  

for i in range(10,20,3):
    print(i)
# range(start,stop,step)
# start - alguse nr
# stop - viimane number
# step - samm (nt praegusel juhul tuleks 10, 13, 16... jne

print("")

