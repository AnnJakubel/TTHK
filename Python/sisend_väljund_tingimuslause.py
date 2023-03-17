"""Exercises from Tatru University"""


def rectangle_circumference_and_area():
    """
    Return rectangle area and circumference.
    """
    
    lenght = float(input("Sisesta ristküliku pikkus: "))
    width = float(input("Sisesta ristküliku laius: "))
    
    circumference = (lenght + width) * 2
    area = lenght * width
    
    print(f"Ristküliku ümbermõõt on {circumference:.2f} ja pindala on {area:.2f}.")
    
    
def peronal_greeting():
    """
    Return greeting with name and age range.
    """
    
    name = input("Sisesta oma nimi: ")
    age = int(input("Sisesta oma vanus numbriga täisarvuna: "))
    
    if age > 6 and age < 19:
        print(f"Tere {name}! Sa oled 7-18 aastane.")
    else:
        print(f"Tere {name}! Oled alla 7 aastane või üle 18")
    
    
def simple_calculator():
    """
    Return  a simple math solution
    """
    
    num_a = int(input("Sisesta täisarv numbrina: "))
    num_b = int(input("Sisesta veel üks täisarv numbrina: "))
    operator = input("Sisesta tehe(+ - / // * ** %): ")
    
    
    if operator == "+":
        result = num_a + num_b
    elif operator == "-":
        result = num_a - num_b
    elif operator == "/":
        result = num_a / num_b
    elif operator == "//":
        result = num_a // num_b
    elif  operator == "*":
        result = num_a * num_b
    elif operator == "**":
        result = num_a ** num_b
    elif operator == "%":
        result = num_a % num_b
    else:
        print("ERROR! Vale sisestus")
                   
    print(f"Tulemus: {num_a}{operator}{num_b}={result}")
    
    
def m_dog():
    """
    Return math solution as the number of barks
    """
    
    num_a = int(input("Sisesta täisarv numbrina: "))
    num_b = int(input("Sisesta veel üks täisarv numbrina: "))
    operator = input("Sisesta tehe(+ - / // * ** %): ")
    
    
    if operator == "+":
        result = num_a + num_b
    elif operator == "-":
        result = num_a - num_b
    elif operator == "/":
        result = num_a / num_b
    elif operator == "//":
        result = num_a // num_b
    elif  operator == "*":
        result = num_a * num_b
    elif operator == "**":
        result = num_a ** num_b
    elif operator == "%":
        result = num_a % num_b
    else:
        print(" ")
    
    bark = "auh "
    bark_result = bark * int(result)
                   
    print(f"Tulemus: {bark_result}")
                

def temperature_converter():
    """
    Return converted temperature.
    """
    
    temperature = float(input("Sisesta temperatuur numbrina: "))
    unit = input("Mis ühikutes on temperatuur (C/F/K)? ")
    target = input("Mis ühikutes soovid tulemust? ")
    
    if unit.upper() == "C":
        fahrenheit = temperature * 1.8 + 32
        kelvin = temperature + 273.15
        celsius = temperature
    elif unit.upper() == "F":
        celsius = (temperature - 32) / 1.8
        kelvin = celsius + 273.15
        fahrenheit = temperature
    elif unit.upper() == "K":
        kelvin = temperature
        celsius = kelvin - 273.15
        fahrenheit = celsius * 1.8 + 32
    else:
        print("Tundmatu ühik. Valida on C-celsius, F-fahrenheit, K-kelvin")
        exit()
        
    if target.upper() == "F":
        print(f"Temperatuur Fahrenheit kraadides: {fahrenheit:.2f}")
    elif target.upper() == "C":
        print(f"Temperatuur Celsius kraadides: {celsius:.2f}")
    elif target.upper() == "K":
        print(f"Temperatuur Kelvin kraadides: {kelvin:.2f}")
    
    
# rectangle_circumference_and_area()
# peronal_greeting()
# simple_calculator()
# m_dog()
temperature_converter()