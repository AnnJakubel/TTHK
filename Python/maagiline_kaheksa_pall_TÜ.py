"""
Moodusta järjend järgnevate sõnedega:

Jah, kindlasti!
Jah!
Võib-olla!
Ei!
Tee programm, kus kasutaja saab küsida jah/ei küsimuse ja programm annab
vastuse ühe suvalise elemendi eelnevast järjendist.

Juhuslike arvude genereerimist vaatame tulevikus, kuid praegu lisame programmi
algusesse rea, tänu millele Python suudab juhuslikke arve genereerida:

import random
Seejärel võime suvalises kohas programmis kasutada juhusliku arvu saamiseks
funktsiooni random.randint(x, y), mis genereerib juhusliku täisarvu x-st y-ni
(mõlemad kaasaarvatud), näiteks:

juhuarv = random.randint(1, 10)

Lisa ka sisse- ja väljajuhatavad tekstid, et dialoog kasutajaga oleks
võimalikult loomulik.

Kui valmis, siis lisa järjendisse 20 erinevat vastusevarianti,
mille ingliskeelsed vasted leiad leheküljelt
https://en.wikipedia.org/wiki/Magic_8-Ball
"""
import random


def magic_8_ball():
    answers = ["See on kindel.", "See on otsustavalt nii.", "Kahtlemata!", "Jah, kindlasti!", "Sa võid seda usaldada", "Minu silme järgi, jah.", "Tõenäoliselt.", "Väljavaade on hea.", "Jah.", "Märgid näitavad, et jah.", "Vastus on ähmane, proovi uuesti.", "Küsi hiljem uuesti.", "Parem mitte sulle hetkel öelda.", "Ei saa praegu ennustada.", "Keskendu ja küsi uuesti", "Ära looda selle peale.", "Mu vastus on ei.", "Mu allikad ütlevad ei.", "Väljavaade pole nii hea.", "Väga kaheldav." ]
    print("Küsi üks jah/ei küsimus ning maagiline 8-pall vastab sulle!")
    while True:
        question = input("Mis on sinu küsimus? ")
        
        answer_index = random.randint(0, 19)
        
        print(f"Maagilise 8-palli vastus sinu küsimusele: {answers[answer_index]}\n")
        
        continue_answer = input("Kas soovid jätkata küsimustega? (j/e) ")
        
        if continue_answer.lower() == "e":
            break
        elif continue_answer.lower() == "j":
            continue
        else:
            print("Vale sisestus.")
            break
    
    print("\nMaagiline 8-pall soovib sulle ilusat päeva jätku!")


magic_8_ball()
    
