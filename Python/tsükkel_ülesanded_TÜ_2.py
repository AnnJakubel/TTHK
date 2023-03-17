"""Exercise from Tartu University."""
import random

def guessing_game():
    """
    Koosta mäng, kus saate ära arvata arvuti poolt mõeldud täisarvu ühest kahekümneni.
    """
    print("Mõtlesin ühele täisarvule 1-20ni. Mis arv see on?")
    correct_answer = random.randint(1, 20)
    while True:
        user_answer = int(input(">> "))
        if user_answer > correct_answer:
            print("Liiga suur, proovi uuesti.")
        elif user_answer < correct_answer:
            print("Liiga väike, proovi uuesti.")
        else:
            print(f"Tubli, arvasid ära. Arv oli {correct_answer}")
            break;
        

def limited_guessing_game():
    """
    Täienda eelmist programmi selliselt, et kasutajal oleks arvu arvamiseks 5 korda,
    s. t. kui viie korra jooksul ära ei arvata, ütleb arvuti, et kaotasid,
    ning teatab õige arvu.
    """
    correct_answer = random.randint(1, 20)
    print("Mõtlesin ühele täisarvule 1-20ni. Mis arv see on?")
    print("Viis korda on võimalus arvata.")
    for i in range(5):
        user_answer = int(input(f">> "))
        print(f"{i+1}.kord \n")
        if i == 4 and user_answer != correct_answer:
            break;
        if user_answer > correct_answer:
            print("Liiga suur, proovi uuesti.")
        elif user_answer < correct_answer:
            print("Liiga väike, proovi uuesti.")
        else:
            print(f"Tubli, arvasid ära. Arv oli {correct_answer}.")
            return
    print("Kaotasid mängu, ei arvanud õige arvu ära.")
    print(f"Õige arv oli {correct_answer}.")
        
    
    
    
    
# guessing_game()
# limited_guessing_game()