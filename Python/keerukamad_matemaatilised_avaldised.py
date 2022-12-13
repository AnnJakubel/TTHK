"""Math exercises vol2."""
import math

def time_converter(seconds: int) -> str:
    """Convert time in seconds to hours and minutes."""
    # Write your code here
    hours = seconds // 3600
    minutes = (seconds // 60) % 60
    return f"{seconds} sekundit on {hours} tund(i) ja {minutes} minut(it)."


print(time_converter(5473))


def student_helper(angle: int) -> str:
    """Return the sine and cosine of the given angle in degrees."""
    # Write your code here
    sine = round((math.sin(math.radians(angle))),1)
    cosine = round((math.cos(math.radians(angle))),1)
    return f"Nurk: {angle}, siinus: {sine}, koosinus: {cosine}."


def greetings(n: int) -> str:
    """Return a string that contains "Hey" n times."""
    # Write your code here
    lots_of_heys = n * "Hey"
    return lots_of_heys


print(greetings(4))


def adding_numbers(num_a: int, num_b: int) -> str:
    """Return given numbers added together as a string."""
    # Write your code here
    string_numbers = str(num_a) + str(num_b)
    return string_numbers


print(adding_numbers(67, 88))
