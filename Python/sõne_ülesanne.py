"""
String exercises.
"""

# 1st exercise
first_name = "James"
last_name = "Bond"


#  2nd exercise
full_name = first_name + " " + last_name
self_description_sentence = f"My name is {last_name}, {first_name} {last_name}."


# 3rd exercise
cake = "vahukoormarjadtäidispõhi"
print(f"{cake[:8]}\n{cake[8:14]}\n{cake[14:20]}\n{cake[20:]}")


# 4th exercise
original_string = "Programming is fun!"
backwards = original_string[::-1]
every_other = original_string[::2]
first_word_reversed = backwards[8:]
