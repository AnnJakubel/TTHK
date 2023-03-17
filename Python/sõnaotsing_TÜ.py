"""
Koosta järjend sõnadest. Seejärel koosta programm,
mis küsib kasutajalt otsingusõna ja seejärel käib kõik
järjendi elemendid läbi ning väljastab ekraanile järjendi
elemendi, kui järjendi element sisaldab otsitavat sõna.

"""

def word_search():
    word_array = ["automobiil", "jäääär", "ahvileivapuu", "tervitused", "lennukikandja", "karussell" ]
    
    word_exists = False 
    searchable_word = input("Palun sisesta otsingusõna, et kontrollida kas järjend sisaldab seda: ")
    
    for word in word_array:
        if searchable_word in word:
            print("Jaa, sisaldab sõna.")
            word_exists = True
            break
        else:
            word_exists = False
    
    if word_exists == False:
        print("Ei sisalda sõna.")
        
word_search()