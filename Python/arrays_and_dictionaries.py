
# Arrary, tagantpoolt lugedes algab -1-st, eespoolt 0-st
some_list = ["Errors", "are", "sometimes", "better", "than", "no", "errors"]
print(some_list[-4])
print(some_list[2])
"""Notes from class, Arrays and Dictionaries"""


# Sõnest saab võtta tähepositsiooni
nimi = "Annabel"
print(nimi[4])


# Sõnastik, võti: väärtus
grades = {
    "english": 4,
    "math": 5,
    "physics": 3
    }

#Sõnastiku võtme väärtuse printimine
print(grades["physics"])


# Two examples of concatenation with str and int
print(nimi + ", sinu matemaatika hinne on " + str(grades["math"]))
print(nimi + ", sinu inglise keele hinne on", grades["english"])