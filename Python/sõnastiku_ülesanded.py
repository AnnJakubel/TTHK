"""Dictionary exercises."""


def get_hobbies(hobbies_dict: dict, name: str) -> list:
    """
    Return the hobbies of a given person.

    hobbies = {
    "Tom": ["running", "reading"],
    "John": ["movies", "music", "swimming"]
    }

    get_hobbies(hobbies, "Tom")  => ["running", "reading"]
    get_hobbies(hobbies, "Timmy")  => "name not in dictionary"

    :param hobbies_dict: dictionary with peoples' hobbies.
    :param name: name of person whose hobbies are to be returned.

    :return: List of hobbies of the person with given name or "name not in dictionary".
    """
    # your code goes here
    
    if name in hobbies_dict:
        return hobbies_dict[name]
    else:
        return "name not in dictionary"
    


def find_tallest(height_dict: dict) -> str:
    """
    Return the name of the tallest peron in given dictionary.

    find_tallest({"Tom": 186, "Mari": 175, "Jhon": 190}) => "Jhon"

    :param height_dict: dictionary with peoples' names and heights
    :return name of tallest person in given dict.
    """
    # your code goes here
    tallest_person = ""
    tallest_height = 0
    
    for key in height_dict:
        if height_dict.get(key) > tallest_height:
            tallest_person = key
            tallest_height = height_dict.get(key)
    
    return tallest_person


def remove_sixes(six_dict: dict) -> dict:
    """
    Return a dictionary where all keys which's values are dividable by six are removed.

    remove_sixes({"a": 4, "b": 8, "c": 6, "d": 18}) => {"a": 4, "b": 8}

    :param six_dict: dictionary to be modified.
    :return: dict without values that are dividable by six.
    """
    # your code goes here
    
    final_dict = {}
    
    for key in six_dict:
        if six_dict.get(key) % 6 == 0:
            continue
        else:
            final_dict[key] = six_dict.get(key)
    
    return final_dict
            


def exchange_keys_and_values(exchange_dict: dict) -> dict:
    """
    Return a dict where keys and values have been exchanged.

    exchange_keys_and_values({"a": "b", "c": "d"}) => {"b": "a", "d": "c"}

    :param exchange_dict: dictionary to be modified.
    :return dictionary where values and keys have been exchanged.
    """
    # your code goes here
    
    final_dict = {}
    
    for key in exchange_dict:
        final_dict[exchange_dict.get(key)] = key
    
    return final_dict


def count_symbol_appearances(stringy: str) -> dict:
    """
    Return dict where key is the symbol and the value is the count this symbol is present in the string.

    count_symbol_appearances("hello hi") => {'h': 2, 'e': 1, 'l': 2, 'o': 1, ' ': 1, 'i': 1}

    :param stringy: string to be processed.
    :return: dictionary with symbol counts.
    """
    # your code goes here

    symbol_appearances_dict = {}
    
    for symbol in stringy:
        symbol_appearances_dict[symbol] = stringy.count(symbol)
        
    return symbol_appearances_dict


def organise_by_first_symbol(strings: list) -> dict:
    """
    Return dict where key the is a symbol and the value is a list of words starting with this symbol.

    organise_by_first_symbol(["hello", "word", "world", "welcome", "yes"]) =>
        {'h': ['hello'], 'w': ['word', 'world', 'welcome'], 'y': ['yes']}

    :param strings: list of strings.
    :return: dict with starting symbol and corresponding words in order of appearance.
    """
    # your code goes here
    first_symbol_dict = {}
    
    for word in strings:
        if word[0] in first_symbol_dict:
            value_list = first_symbol_dict.get(word[0])
            value_list.append(word)
            first_symbol_dict[word[0]] = value_list
        else:
            value_list = [word]
            first_symbol_dict[word[0]] = value_list
    
    return first_symbol_dict


print(organise_by_first_symbol(["hello", "word", "world", "welcome", "yes"]))