"""Main"""


def lowest_highest(numbers: list) -> str:
    """Return "Lowest and highest number: {low}, {high}",
     where low is the lowest and high the highest number in numbers
     """
    if len(numbers) == 0:
        return "Can't find numbers from empty list"
    low = numbers[0]
    high = numbers[0]
    
    for number in numbers:
        if number < low:
            low = number
        if number > high:
            high = number
    
    return f"Lowest and highest number: {low}, {high}"


def text_to_numbers(text: str) -> str:
    """
    Convert text of a single digit number to a number.

    Given text, which consists of lowercase word of a single digit number, convert it to the corresponding number
    """
    eng_numbers_dict = {"one": "1", "two": "2", "three": "3", "four": "4", "five": "5", "six": "6", "seven": "7", "eight": "8", "nine": "9"}
    

    if text in eng_numbers_dict:
        return eng_numbers_dict.get(text)
    else:
        return ""


def vowel_doubler(text: str) -> str:
    """
    Replace only single vowel with double vowels.
    """
    vowels = ["a", "e", "i", "o", "u", "õ", "ä", "ö", "ü"]
    text_to_return = ""
    comparable_list = []
    i = 1
    
    for character in text:
        comparable_list.append(character)
    
    
    for character in text:

        if character in vowels:
            if i < (len(comparable_list) - 2):
                if comparable_list[i] == character:
                    i += 1
                else:
                    text_to_return = text_to_return + character + character
                    if i < (len(comparable_list) - 1):
                        i += 1
            else:
                text_to_return = text_to_return + character + character
                if i < (len(comparable_list) - 1):
                    i += 1
        else:
            text_to_return += character
            if i < (len(comparable_list) - 1):
                i += 1
            
    return text_to_return


def recycling_truck_trip(stop1bottles: int, stop2bottles: int, stop1dist: int, stop2dist: int) -> str:
    """
    Return which stop(s) the truck went to.

    The truck starts at 0. Stop 1 and stop 2 are dist1 and dist2 away from the start and on the same road.
    Stop 1 is always closest to the start.

    The truck goes to a stop
    if the amount of bottles at a stop is more than or equal to the distance between the truck and the stop.
    e.g. if stop1 is 17 away and has 20 bottles
    and stop2 is 26 away and has 19 bottles,
    the truck will go to both, because
    20 - 17 > 0 and
    19 - (26 - 17) > 0.
    """
    
    starting_point = 0
    truck_feedback = ""
    
    if stop1bottles - stop1dist >= starting_point:
        truck_feedback = "Stop 1"    
        if stop2bottles - (stop2dist - stop1dist) >= starting_point:
            truck_feedback = truck_feedback + " and Stop 2"
    elif stop2bottles - stop2dist >= starting_point:
        truck_feedback = "Stop 1 and Stop 2"
    else:
        truck_feedback = "No stops" 
    return truck_feedback
      

def weight_matching(weights: list, req_weight: int) -> bool:
    """
    Return True if in the list is found 2 sets of numbers, each equal to half of req_weight.

    A set of numbers can be a single number. req_weight always has to be an even number.

    :param weights: [1, 1, 2, 5, 6, 1, 3, 2, 7]
    :param req_weight: 16
    :return: True
    """
    
    half_of_req_weight = req_weight / 2
    count = 0 
    
    for number in weights:
        for second_number in weights:
            if number + second_number < half_of_req_weight:
                for third_number in weights:
                    if number + second_number + third_number == half_of_req_weight:
                        count += 1
                        if count == 2:
                            return True
            elif number + second_number == half_of_req_weight:
                count += 1
                if count == 2:
                    return True
            else:
                continue 
                
    return False    