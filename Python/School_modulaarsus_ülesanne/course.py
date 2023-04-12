"""Course class with name and grades."""


class Course:
    """Course class."""

    def __init__(self, name: str) -> None:
        """Course object constructor."""
        self.name = name
        self.grades = []

    def get_grades(self):
        """Return grades as a list of tuples, consisting of student and grade."""
        return self.grades

    def add_grade(self, student, grade: int) -> None:
        """Add student and grade to course list as tuple."""
        student_grade = (student, grade)
        self.grades.append(student_grade)

    def get_average_grade(self) -> float:
        """Return average grade of the whole course."""
        grades_sum = 0
        if len(self.grades) == 0:
            return -1
        else:
            for grade in self.grades:
                grades_sum += grade[1]
            return grades_sum / (len(self.grades))

    def __repr__(self) -> str:
        """Course object representation."""
        return self.name