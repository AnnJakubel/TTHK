temperatureInput = input("What's today's temperature: ")
finalTemperature = int(temperatureInput)
if finalTemperature > 21:
    print("Go swimming")
elif finalTemperature > 18:
    print("Walk the dog")
    print("Mow the lawn")
elif finalTemperature < 10:
    print("Bundle up and make fire")
else:
    print("Make fire")
    

a = True
b = not a # False

if a and b:
    print("true")
else:
    print("false")
    
if a or b:
    print("true")
else:
    print("false")