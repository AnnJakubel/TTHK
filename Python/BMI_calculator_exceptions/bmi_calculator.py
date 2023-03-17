"""BMI Calculator"""
from erindid_demo import *

try:
    age,length,weight = AskValues()
except AgeInvalid:
    print("Sisestasid vanuse valesti")
except LengthInvalid:
    print("Sisestasid pikkuse valesti")
    raise SystemExit
except WeightInvalid:
    print("Sisestasid kaalu valesti")
    raise SystemExit
else:
    print(f"Sinu kehamassiindeks on {CalculateBMI(length,weight):.2f}")
