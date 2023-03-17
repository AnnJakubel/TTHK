"""Exercises from Tartu Ülikool"""

import datetime

def id_number():
    """"
    Eestis kasutatav isikukood koosneb üheteistkümnest numbrist.
    Tutvu isikukoodi struktuuriga (https://et.wikipedia.org/wiki/Isikukood)
    ja kirjuta programm, mis analüüsib isikukoode ja väljastab võimalikult rohkem
    infot selle kohta (sünnikuupäev, sugu jne). Isikukoodi käsitlege kui sümbolite
    kogumit ehk sõnet (kuigi see koosneb numbritest), analüüsimiseks kasutage
    sõneoperatsioone (vt. käsiraamat). Kuna isikukoode on keeruline testimise ajal
    korduvalt sisestada, on alguses mõistlik sisestada erinevad isikukoodid ning
    kommenteerida vastavalt vajadusele ülearused välja, näiteks järgnevalt
    kasutatakse teisel real olevat isikukoodi:
    """
    
    isikukood = "60201302715"
    #isikukood = "48008082727"
    #isikukood = "31212230156"
    
    first_number = int(isikukood[0])
    
    if first_number % 2 == 0:
        sex = "naine"
    else:
        sex = "mees"
        
    if first_number < 3:
            century = "18"
    elif first_number < 5:
        century = "19"
    elif first_number < 7:
        century = "20"
    
    year = int(century + isikukood[1:3])
    month_number = int(isikukood[3:5])
    day_number = int(isikukood[5:7])
    birthday = datetime.datetime(year,month_number,day_number).strftime("%A %d %B %Y")
    
    print(f"Oled {sex}.\nSünniaasta on {year}\nOled sündinud aasta {month_number}.kuul ja {day_number}.päeval.\nSünnipäev on {birthday}")


id_number()