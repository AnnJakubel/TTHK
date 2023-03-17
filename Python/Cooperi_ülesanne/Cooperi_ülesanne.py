"""Cooper exercise"""

import csv

def hinda(meters_as_int, gender):
    meters = str(meters_as_int)
    threshold = 0
    data = gender + " " + meters + " m, "
   
    if gender == "N":
            
        if meters_as_int >= 2600:
            assessment = "väga hea"
            result = data + assessment
            print(result)
        elif meters_as_int < 1800:
            threshold = 1800 - meters_as_int
            assessment = "nõrk, järgmisest hindest puudu " + str(threshold) + " m"
            result = data + assessment
            print(result)
        else:
            threshold = 2600 - meters_as_int
            assessment = "rahuldav, järgmisest hindest puudu " + str(threshold) + " m"
            result = data + assessment
            print(result)
                
    elif gender == "M":
                
        if meters_as_int >= 2800:
            assessment = "väga hea"
            print(result)
        elif meters_as_int < 2000:
            threshold = 2000 - meters_as_int
            assessment = "nõrk, järgmisest hindest puudu " + str(threshold) + " m"
            result = data + assessment
            print(result)
        else:
            threshold = 2800 - meters_as_int
            assessment = "rahuldav, järgmisest hindest puudu " + str(threshold) + " m"
            result = data + assessment
            print(result)
            
    else:
        "Andmed puudu."


if __name__ == "__main__":
    
    file_name = input("Sisesta faili nimi: \n>>> ")
    
    with open(file_name) as file:
        csv_reader = csv.reader(file, delimiter=" ")

        meters_women = 0
        count_women = 0
        meters_men = 0
        count_men = 0
            
        for row in csv_reader:
            meters_as_int = int(row[0])
            gender = row[1]
            hinda(meters_as_int, gender)
            
            if gender == "N":
                meters_women += meters_as_int
                count_women += 1
            elif gender == "M":
                meters_men += meters_as_int
                count_men += 1
            else:
                print("Andmed puuduvad")
        
        avg_meters_women = round(meters_women / count_women, 0)
        avg_meters_men = round(meters_men / count_men, 0)
        
        
        print("Keskmised:")
        hinda(int(avg_meters_men), "M")
        hinda(int(avg_meters_women), "N")
    
    file.close()