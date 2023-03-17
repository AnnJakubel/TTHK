"""Exercises from Tartu University"""
import random


def greet():
    """
    Koosta programm, mis küsib kasutajalt nime ja tervitab teda nimeliselt 5 korda
    ja lisab ka tervituse järjekorranumbri.
    """
    name = input("Sisesta oma nimi: ")
    for number in range (1, 6):
        print(f"Ole tervitatud, {name}, {number}. korda.")
        

def sum_of_ten_numbers():
    """
    Koosta programm, mis küsib kasutajalt 10 korda arve
    ja väljastab seejärel nende arvude summa. (For loop)
    """
    print("Tere! Küsin 10 täisarvu, mida liita summaks")
    total = 0
    for i in range(10):
        number = int(input(f"Sisesta {i+1}. arv: "))
        total += number
    print(f"Sisestatud arvude summa: {total}")
    
    
def sum_of_ten_numbers_again():
    """
    Koosta programm, mis küsib kasutajalt 10 korda arve
    ja väljastab seejärel nende arvude summa. (While loop)
    """
    print("Tere! Küsin 10 täisarvu, mida liita summaks")
    total = 0
    i = 10
    count = 1
    while i > 0:
        number = int(input(f"Sisesta {count}. arv: "))
        total += number
        count += 1
        i -= 1
    print(f"Sisestatud arvude summa: {total}")
    

def sum_of_numbers():
    """
    Täienda eelnevat programmi nii, et kasutajalt küsitakse arve seni,
    kuni kasutaja enam uut arvu ei sisesta,
    vaid vajutab lihtsalt sisestusklahvi. Proovige seda ülesannet lahendada
    nii while- kui for-tsükliga.
    """
    total = 0
    count = 1
    while True:
        number = input(f"Sisesta {count}. täisarv: ")
        if number == "":
            break
        number_as_int = int(number)
        total += number_as_int
        count += 1
    print(f"Sisestatud arvude summa: {total}")


def math_training():
    """
    (SIMPLE)
    Koosta programm, mis aitab lastel treenida liitmist.
    Programm peaks pakkuma välja juhuslike arvudega liitmistehteid ning ootama
    kasutajalt vastust. Kui vastus on õige, kiitma kasutajat, kui aga vale,
    andma õige vastuse ja esitama uue tehte. Järjest esitatavate tehete hulk
    võib olla programmis ette antud (näiteks 10), samuti võib olla ette antud
    piirid, kui suuri arve kasutajalt küsitakse (näiteks 1 kuni 50).
    Programm peaks pidama arvestust ka õigete vastuste üle ning väljastama pärast
    viimast tehet tulemuse.
    """
    print("Tere! Õpime arvutama. Esitan 10 liitmistehet, püüa vastata õigesti.")
    total = 0
    correct_answers = 0
    for i in range(10):
        a = random.randint(1, 50)
        b = random.randint(1, 50)
        total = a + b
        print(f"{a} + {b} = ")
        user_answer = int(input(">> "))
        if total == user_answer:
            print("Tubli, õige vastus!")
            correct_answers += 1
        else:
            print(f"Sinu vastus polnud õige. Õige vastus on {total}")
    print(f"See oli viimane ülesanne. Kogusid 10-st punktist {correct_answers}")


def advanced_math_training():
    """
    (ADVANCED)
    Koosta programm, mis aitab lastel treenida liitmist.
    Programm peaks pakkuma välja juhuslike arvudega liitmistehteid ning ootama
    kasutajalt vastust. Kui vastus on õige, kiitma kasutajat, kui aga vale,
    andma õige vastuse ja esitama uue tehte. Järjest esitatavate tehete hulk
    võib olla programmis ette antud (näiteks 10), samuti võib olla ette antud
    piirid, kui suuri arve kasutajalt küsitakse (näiteks 1 kuni 50).
    Programm peaks pidama arvestust ka õigete vastuste üle ning väljastama pärast
    viimast tehet tulemuse.
    """
    print("Tere! Õpime arvutama. Esitan vastavalt teie sisestatud arvule ja märgile matemaatilisi tehteid, püüa vastata õigesti.")
    while True:
        operations = int(input("Sisesta täisarv, kui palju tehteid soovid (1 kuni 10): "))
        if operations > 10:
            print("Sisestatud number on liiga suur. Proovi uuesti.")
        elif operations < 1:
            print("Sisestatud arv on liiga väike. Proovi uuesti.")
        else:
            break
        
    total = 0
    correct_answers = 0
    for i in range(operations):
        operator = input("Sisesta tehete märk (+ - / *): ")
        a = random.randint(1, 10)
        b = random.randint(1, 10)
        if operator == "+":
            total = a + b
        elif operator == "-":
            total = a - b
        elif operator == "/":
            total = a / b
        elif operator == "*":
            total = a * b
        else:
            print("Vale sisestus, proovi uuesti järgmisel tehtel.")
            continue
        
        print(f"{a} {operator} {b} = ")
        if operator == "/":
            user_answer = round(float(input(">> ")), 1)
        else:
            user_answer = int(input(">> "))
            
        if total == user_answer:
            print("Tubli, õige vastus!")
            correct_answers += 1
        else:
            print(f"Sinu vastus polnud õige. Õige vastus on {total}")
            
    print(f"See oli viimane ülesanne. Kogusid {operations}-st punktist {correct_answers}")
    
    percentage = correct_answers / operations
    if percentage > 0.9:
        print("Ülihea!")
    elif percentage > 0.6:
        print("Olid tubli!")
    elif percentage > 0.3:
        print("Korralik keskmine tulemus!")
    else:
        print("Püüa järgmisel korral rohkem")

        
    
                     
# greet
# sum_of_ten_numbers()
# sum_of_ten_numbers_again()
# sum_of_numbers()
# math_training()
# advanced_math_training()