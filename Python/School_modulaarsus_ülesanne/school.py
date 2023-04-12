"""School class which stores information about courses and students."""
from student import Student
from course import Course


class School:
    """School class."""

    def __init__(self, name) -> None:
        """School class constructor."""
        self.name = name
        self.courses = []
        self.students = []
        self.__next_id = 0

    def add_course(self, course: Course) -> None:
        """Add course to list of courses."""
        if course not in self.courses:
            self.courses.append(course)

    def add_student(self, student: Student) -> None:
        """Add student to list of students."""
        if student not in self.students:
            self.__next_id += 1
            student.set_id(self.__next_id)
            self.students.append(student)

    def add_student_grade(self, student: Student, course: Course, grade: int) -> None:
        """Add student's grade to course and grade to student."""
        if student in self.students and course in self.courses:
            student.add_grade(course, grade)
            course.add_grade(student, grade)

    def get_students(self) -> list[Student]:
        """Return list of students."""
        return self.students

    def get_courses(self) -> list[Course]:
        """Return list of courses."""
        return self.courses

    def get_students_ordered_by_average_grade(self) -> list[Student]:
        """Order students by average grade."""
        if len(self.students) == 0:
            return self.students
        sorted_students = sorted(self.students, reverse=True, key=lambda student: student.get_average_grade())
        return sorted_students