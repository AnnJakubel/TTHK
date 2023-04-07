"""Course class with name and grades."""
from student import Student


class Course:
    """Course class."""

    def __init__(self) -> None:
        self.grades = []
    
    def get_grades(self) -> list[tuple[Student, int]]:
        """Returns grades as a list of tuples, consisting of student and grade"""
        return self.grades

    def add_grade(self, student: Student, grade: int) -> None:
        """Adds student and grade to course list as tuple."""
        student_grade = (student, grade)
        self.grades.append(student_grade)

