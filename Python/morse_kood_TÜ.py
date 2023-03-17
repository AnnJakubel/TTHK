
tahestik = {"a":".-", "b":"-...", "c":"-.-.", "d":"-..", "e":".", "f":"..-.", "g":"--.", "h":"....", "i":"..", "j":".---", "k":"-.-", "l":".-..", "m":"--", "n":"-.", "o":"---", "p":".--.", "q":"--.-", "r":".-.", "s":"...", "t":"-", "u":"..-", "v":"...-", "w":".--", "x":"-..-", "y":"-.--", "z":"--..", "ä":"· — · —", "ö":"— — — ·", "ü":"· · — —"}
m_alphabet = { v:k for k, v in tahestik.items() }

def text_to_morse(text):
    user_morse_code = ""
    for letter in text:
        if letter.lower() in tahestik:
            user_morse_code = user_morse_code + tahestik[letter.lower()] + " "
        elif letter == "õ":
            user_morse_code = user_morse_code + tahestik["o"] + " "
        elif letter == " ":
            user_morse_code += "  "
        else:
            continue
    return user_morse_code;


def morse_to_text(morse):
    message = ""
    morse_list = morse.split(" ")
    for character in morse_list:
        if character in m_alphabet:
            message = message + m_alphabet[character] + " "
        else:
            message += "  "
        
    return message

greeting = "Tervist!"

print(greeting)
print(text_to_morse(greeting))

while True:
    user_input = input("Sisesta mingisugune sõna või väljend,\nmida tõlgitakse morsekoodi. \nLihtsalt 'Enter'-i vajutamine \nlõpetab programmi: \n>>> ")
    
    if user_input == "":
        print("\nProgramm lõpetatud.")
        break
    
    
    final_t_to_m = text_to_morse(user_input)
    
    final_m_to_t = morse_to_text(final_t_to_m)
            
    print(f"\n{final_t_to_m}\n")
    print(f"\n{final_m_to_t}")