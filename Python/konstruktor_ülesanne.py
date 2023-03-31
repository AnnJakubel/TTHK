"""Constructor exercise."""


class Empty:
    """An empty class without constructor."""


class Person:
    """Represent person with firstname, lastname and age."""
    def __init__(self, firstname="", lastname="", age=0):
        """Initialize."""
        self.firstname = firstname
        self.lastname = lastname
        self.age = age
    
    def __str__(self):
        return f"{self.firstname} {self.lastname}, age: {self.age}"


class Student(Person):
    """Represent student with firstname, lastname and age."""

    def __init__(self, firstname, lastname, age):
        """Initialize."""
        super().__init__(firstname, lastname, age)
    
    def __str__(self):
        return f"{self.firstname} {self.lastname}, age: {self.age}"


if __name__ == '__main__':
    # empty usage
    empty = Empty()

    # 3 x student usage
    s1 = Student("Katniss", "Everdeen", 17)
    s2 = Student("Peeta", "Mellark", 17)
    s3 = Student("Johanna", "Mason", 20)
    
    # 3 x person usage
    p1 = Person()
    p1.firstname = "Haymitch"
    p1.lastname = "Abernathy"
    p1.age = 50
    
    p2 = Person()
    p2.firstname = "Effie"
    p2.lastname = "Trinket"
    p2.age = 35
    
    p3 = Person()
    p3.firstname = "Cinna"
    p3.lastname = "..."
    p3.age = 27
    
    
    list_of_all = []
    list_of_all.append(s1)
    list_of_all.append(s2)
    list_of_all.append(s3)
    list_of_all.append(p1)
    list_of_all.append(p2)
    list_of_all.append(p3)
    
    for character in list_of_all:
        print(character)
    
