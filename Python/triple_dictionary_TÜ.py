"""
Lihtsa sõnaraamatu jaoks koosta neli järjendit (arv, eesti, inglise, itaalia)
sisuga: arv - 1, 2, 3, 4
eesti - üks, kaks, kolm, neli
inglise - one, two, three, four
itaalia - uno, due, tre, quattro
Väljasta kõik elemendid tabelina ekraanile: 1 - üks - one - uno 2 - kaks - two - due ...
Lisa arvude ja eesti järjendile veel kaks elementi.
Kontrolli, kas itaalia sõnade järjendis eksiteerib element 'tre'
Väljasta kõigi nelja järjendi elemendid tähestikulises järjekorras kasvavalt.
"""

def triple_dictionary():
    numbers = [1, 2, 3, 4, 5, 6]
    estonian = ["üks", "kaks", "kolm", "neli", "viis", "kuus"]
    english = ["one", "two", "three", "four"]
    italian = ["uno", "due", "tre", "quattro"]
    
    
    for i in range(len(numbers)):
        if i < len(numbers) and i < len(estonian) and i < len(english) and i < len(italian):
            print(f"{numbers[i]} - {estonian[i]} - {english[i]} - {italian[i]}")
        elif i < len(numbers) and i < len(estonian):
            print(f"{numbers[i]} - {estonian[i]} - -")
        elif i < len(numbers) and i < len(english):
            print(f"{numbers[i]} - - {english[i]} -")
        elif i < len(numbers) and i < len(italian):
            print(f"{numbers[i]} - - - {italian[i]}")
        elif i < len(numbers) and i < len(estonian) and i < len(english):
            print(f"{numbers[i]} - {estonian[i]} - {english[i]} - ")
        elif i < len(numbers) and i < len(estonian) and i < len(italian):
            print(f"{numbers[i]} - {estonian[i]} - - {italian[i]}")
        elif i < len(numbers) and i < len(english) and i < len(italian):
            print(f"{numbers[i]} - - {english[i]} - {italian[i]}")
    
    word = input("\nSisesta sõna, mille olemasolu kontrollida: ")
    dictionary = input("Sisesta sõnastik, millest sõna otsida (estonian / english / italian) ")
    
    if dictionary == "estonian":
        if word in estonian:
            print(f"Sõna '{word}' on sõnastikus olemas.")
        else:
            print(f"Sõna '{word}' ei eksisteeri siin sõnastikus.")
    elif dictionary == "english":
        if word in english:
            print(f"Sõna '{word}' on sõnastikus olemas.")
        else:
            print(f"Sõna '{word}' ei eksisteeri siin sõnastikus.")
    elif dictionary == "italian":
        if word in estonian:
            print(f"Sõna '{word}' on sõnastikus olemas.")
        else:
            print(f"Sõna '{word}' ei eksisteeri siin sõnastikus.")
    else:
        print("Vale sisestus.")
        
    answer = input("\nKas soovid väljastada kõigi nelja järjendi elemendid tähestikulises järjekorras (jah / ei): ")
    if answer == "jah":
        mega_dictionary = []
        mega_dictionary.append(numbers)
        mega_dictionary.append(estonian)
        mega_dictionary.append(english)
        mega_dictionary.append(italian)
        
        for n in mega_dictionary:
            print("")
            n.sort()
            for e in n:
                print(e)

    elif answer == "ei":
        ("Selge. Programm lõpetatud.")
    else:
        print("Vale sisestus.")


triple_dictionary()