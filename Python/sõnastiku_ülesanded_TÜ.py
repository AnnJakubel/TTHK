"""
Exercises from Tartu University.
"""

inglise = {"üks":"one", "kaks" : "two", "kolm" : "three", "neli" : "four"}
itaalia = {"üks":"uno", "kaks" : "due", "kolm" : "tre", "neli" : "quattro"}

inglise["auto"] = "car"
itaalia["auto"] = "auto"

inglise.update({"koer" : "dog"})
itaalia.update({"koer" : "cane"})

inglise.setdefault("kass", "cat")
itaalia.setdefault("kass", "gatto")

inglise["tere"] = "hello"
itaalia["tere"] = "ciao"

inglise["headaega"] = "goodbye"
itaalia["headaega"] = "arrivederci"

inglise["pott"] = "pot"
itaalia["pott"] = "pentola"

inglise["sõnastik"] = "dictionary"
itaalia["sõnastik"] = "dizionario"

if __name__ == "__main__":

    print( f"Tere -> {inglise['tere']}, {itaalia['tere']}")
    print( f"Auto -> {itaalia['tere']}")
    print( f"Kass -> {inglise['kass']}")
    print( f"Üks -> {itaalia['üks']}")
    print( f"Kolm -> {inglise['kolm']}")








