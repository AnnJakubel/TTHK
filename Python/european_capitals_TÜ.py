"""
Koosta järjend vähemalt kümne Euroopa pealinnaga (suvalises järjekorras).

Väljasta linnad eraldi ridadena.
Järjesta need tähestikulisse järjekorda.
Lase kasutajal lisada kaks uut Euroopa pealinna ja järjesta uuesti.
Esita linnade nimed tähestikulises järjekorras, lisades iga nime ette ka järjekorra numbri.
Lisa väljundile kokkuvõttev lause "Meie järjendis on 12 Euroopa pealinna",
kus linnade arv leitakse vastava funktsiooni abil.
"""
def european_capitals():
    capitals = ["Tallinn", "Riia", "Vilnius", "Helsingi", "Kopenhaagen", "Pariis", "Oslo", "Viin", "Brüssel", "Sofia"]
    
    print("Euroopa riikide pealinnad eraldi ridadena: ")
    for c in capitals:
        print(c)
    print("\nAntud linnad tähestikulises järjekorras: ")
    capitals.sort()
    for c in capitals:
        print(c)
    print("\nKüsin veel kahte Euroopa pealinna, et lisada järjendisse.")
    while True: 
        capital_one = input("Sisesta esimene pealinn: ")
        if capital_one in capitals:
            capital_one = input(f"Sisestus {capital_one} juba eksisteerib, palun sisesta uus: ")
            if capital_one in capitals:
                continue
            else:
                break
        else:
            break;
    
    while True:
        capital_two = input("Sisesta teine pealinn: ")
        if capital_two in capitals:
            capital_two = input(f"Sisestus {capital_two} juba eksisteerib, palun sisesta uus: ")
            if capital_two in capitals:
                continue
            else:
                break
        else:
            break
        
    capitals.append(capital_one)
    capitals.append(capital_two)
    capitals.sort()
    
    count = 1
    print("")
    for c in capitals:
        print(f"{count}. {c}")
        count += 1
    
    print(f"\nMeie järjendis on {len(capitals)} Euroopa pealinna.")