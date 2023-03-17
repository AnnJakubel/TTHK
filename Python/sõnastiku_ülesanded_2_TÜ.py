from sõnastiku_ülesanded_TÜ import inglise, itaalia

e_inglise = {}
e_itaalia = {}


for key in inglise:
    e_inglise[inglise[key]] = key
    
for key in itaalia:
    e_itaalia[itaalia[key]] = key


print(f"Üks -> {itaalia['üks']}")
print(f"Ciao -> {e_itaalia['ciao']}")
print(f"Dog -> {itaalia[e_inglise['dog']]}")
print(f"Pentola -> {inglise[e_itaalia['pentola']]}")