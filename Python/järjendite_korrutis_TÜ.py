"""
Koosta vähemalt kümnest elemendist koosnev järjend arvudest.
Koosta programm, mis küsib kasutajalt tegurit ja korrutab kõik
algses järjendis olnud arvud sellega läbi ning väljastab tulemuse ekraanile.
"""

import random


def product_of_all_numbers():
    long_list = []
    for number in range(10):
        long_list.append(random.randint(0, 1000))
        
    print("Programm koostab järjendi kümnest täisarvust \nning küsib sinult tegurit, \nmillega kõik numbrid läbi korrutada\n")
    multiplier = int(input("Sisesta tegur (täisarv): "))
    
    for element in long_list:
        product = element * multiplier
        print(f"{element} * {multiplier} = {product}")
        