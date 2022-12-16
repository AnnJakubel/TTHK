"""Function examples."""


# func()
def func():
    """Print inside a function."""
    print("I´m inside the function")


# my_name_is(name)
def my_name_is(name: str):
    """Return my name."""
    print(f"My name is {name}")


# sum_six(num)`
def sum_six(num: int):
    """Return 6 plus number parameter."""
    return 6 + num


# sum_numbers()
def sum_numbers(a: int, b: int):
    """Return sum of provided numbers."""
    return a + b


# usd_to_eur()
def usd_to_eur(num: int):
    """Return conversion from USD to EUR."""
    return num * 0.8


func()
my_name_is("Annabel")
print(sum_six(8))
print(sum_numbers(6, 10))
print(usd_to_eur(84))
      