from KT3_tasks import lowest_highest, text_to_numbers, vowel_doubler, recycling_truck_trip, weight_matching


def test__lowest_highest__empty_and_1_number():
    assert lowest_highest([]) == "Can't find numbers from empty list"
    assert lowest_highest([3]) == "Lowest and highest number: 3, 3"


def test__lowest_highest__2_numbers():
    assert lowest_highest([3, 6]) == "Lowest and highest number: 3, 6"


def test__lowest_highest__many_numbers():
    assert lowest_highest([3, 6, 1, 43, 7, 8, 21]) == "Lowest and highest number: 1, 43"


def test__text_to_numbers__empty_str():
    assert text_to_numbers("") == ""


def test__text_to_numbers__different_amount_of_numbers():
    assert text_to_numbers("one") == "1"
    assert text_to_numbers("twothreefoursix") == "2346"
    assert text_to_numbers("fivefivefivefivefivefivefivefivefivefive") == "5555555555"


def test__vowel_replacer__empty_str():
    assert vowel_doubler("") == ""


def test__vowel_replacer__no_vowels():
    assert vowel_doubler("trx") == "trx"


def test__vowel_replacer__single_vowels_and_double_vowels():
    assert vowel_doubler("afterwards") == "aafteerwaards"
    assert vowel_doubler("pool time") == "pool tiimee"


def test__recycling_truck_trip__no_bottles():
    assert recycling_truck_trip(0, 0, 10, 12) == "No stops"


def test__recycling_truck_trip__some_bottles():
    assert recycling_truck_trip(17, 1, 10, 12) == "Stop 1"
    assert recycling_truck_trip(0, 29, 10, 12) == "Stop 1 and Stop 2"
    assert recycling_truck_trip(17, 3, 10, 12) == "Stop 1 and Stop 2"


def test__recycling_truck_trip__not_enough_bottles():
    assert recycling_truck_trip(9, 7, 10, 12) == "No stops"


def test__weight_matching__no_weights():
    assert weight_matching([], 20) is False


def test__weight_matching__not_enough_weights():
    assert weight_matching([1, 2, 6, 3], 20) is False


def test__weight_matching__enough_weights():
    assert weight_matching([6, 4, 3, 2, 5], 20) is True
    assert weight_matching([1, 1, 2, 6, 4, 3, 2, 5, 1, 3, 5], 20) is True
    assert weight_matching([10, 10, 20, 60, 40, 35, 20, 5, 1, 30, 50, 25, 90], 300) is True