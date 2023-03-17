
def CalculateBMI(length, weight):
    return weight / (length ** 2)


def AskValues():
    try:
        age = int(input("Kui vana sa oled? "))
    except ValueError:
        raise AgeInvalid
    try:
        length = int(input("Kui pikk sa oled? "))
    except ValueError:
        raise LengthInvalid
    try:
        weight = int(input("Kui palju sa kaalud? "))
    except ValueError:
        raise WeightInvalid
    finally:
        return age,length / 100,weight
