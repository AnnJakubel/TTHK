"""One Hundred Acre Forest exercise"""


def juurdekasv(forest_area, growth_per_hectar):
    
    area_as_hectars = float(forest_area) * 0.4047
    return area_as_hectars * float(growth_per_hectar)


if __name__ == "__main__":
    
    file_name = input("Sisestage failinimi: ")
    growth_per_hectar = input("Sisestage aastane juurdekasv hektari kohta tihumeetrites: ")
    minimum_area = input("Sisestage piir, mitmest aakrist suuremad metsatükid arvesse võtta: ")
    number_of_forest_areas_counted = 0
    
    file = open(file_name, "r")
    
    for line in file:
        if line >= minimum_area:
            overall_growth = round(juurdekasv(line, growth_per_hectar), 2)
            number_of_forest_areas_counted += 1
            print(f"Metsatüki aastane juurdekasv on {overall_growth}")
        else:
            print("Metsatükki ei võeta arvesse.")
    
    print(f"Arvutati {number_of_forest_areas_counted} metsatüki juurdekasv.")
    
    file.close()