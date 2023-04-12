"""Student class with student name and grades."""


class Student:
    """Student class."""

    def __init__(self, name: str) -> None:
        self.name = name
        self.id = None
        self.grades = []
    
    def set_id(self, id: int) -> None:
        if self.id == None:
            self.id = id

    def get_id(self) -> int:
        return self.id
    
    def get_grades(self):
        return self.grades
    
    def add_grade_by_course(self, course, grade: int) -> None:
        course_grade = (course, grade)
        self.grades.append(course_grade)

    def get_average_grade(self) -> float:
        """Returns average grade of the whole course."""
        grades_sum = 0
        if len(self.grades) == 0:
            return -1
        else:
            for grade in self.grades:
                grades_sum += grade[1]
            return grades_sum / (len(self.grades) - 1)
    
    def __repr__(self) -> str:
        return self.name