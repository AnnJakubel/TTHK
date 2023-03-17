"""
Pikimad loomanimed - Kirjuta programm:
1. Küsi looma nimesid kuni tühja sisestuseni
2. Kuva sama tähega algavate loomade kõige pikemad nimed
 
Näiteks:
Sisend -< Karu, Kass, Koaala, Siil, Saarmas, Rebane
Tulem: K – Koaala S – Saarmas R – Rebane
"""

def longest_animal_names():
    print("See programm küsib loomanimesid kuni tühja sisestuseni \nning tagastab iga algustähe kohta kõige pikemad nimed.\n")
    animal_list = []
    first_letter = ""
    longest_animal_name_for_letter = ""
    final_output = ""
    all_letters_once = []
    
    while True:
        animal = input("Sisesta loomanimi (või lõpetamiseks vajuta Enter): ")
        
        if animal == "":
            break;
        else:
            animal_list.append(animal)
            
    
    for animal in animal_list:
        if animal[0] in all_letters_once:
            continue;
        else:
            first_letter = animal[0].upper()
            longest_animal_name_for_letter = animal.capitalize()
            all_letters_once.append(animal[0])
            print(all_letters_once)
            print(longest_animal_name_for_letter)
            
        for animal_two in animal_list: 
            if animal[0] == animal_two[0]:
                if len(animal) > len(animal_two):
                    longest_animal_name_for_letter = animal.capitalize()
                    print(longest_animal_name_for_letter)
                elif len(animal_two) > len(animal):
                    longest_animal_name_for_letter = animal_two.capitalize()
                    print(longest_animal_name_for_letter)
                else:
                    continue
            
        final_output = final_output + first_letter + " - " + longest_animal_name_for_letter + " "
                 
    print(f"\n{final_output}")
    

longest_animal_names()

