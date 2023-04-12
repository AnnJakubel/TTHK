"""Student class with student name and grades."""


class Student:
    """Student class."""

    def __init__(self, name: str) -> None:
        """Student constructor."""
        self.name = name
        self.id = None
        self.grades = []

    def set_id(self, id: int) -> None:
        """Set student id."""
        if self.id is None:
            self.id = id

    def get_id(self) -> int:
        """Return Student id."""
        return self.id

    def get_grades(self):
        """Return Student grades."""
        return self.grades

    def add_grade(self, course, grade: int) -> None:
        """Add grade."""
        self.grades.append((course, grade))

    def get_average_grade(self) -> float:
        """Return average grade of the whole course."""
        grades_sum = 0
        if len(self.get_grades()) <= 0:
            return -1
        else:
            for grade in self.get_grades():
                grades_sum += grade[1]
            return float(grades_sum / len(self.get_grades()))

    def __repr__(self) -> str:
        """Student object representation."""
        return self.name