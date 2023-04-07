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
    
    def add_course(self, course: Course) -> None:
        """Adds course to list of courses."""
        self.courses.append(course)
    
    def add_student(self, student: Student) -> None:
        """"Adds student to list of students."""
        self.students.append(student)
    
    def add_student_grade(self, student: Student, course: Course, grade: int) -> None:
        """Adds student's grade to course and grade to student."""
        student.add_grade_by_course(course, grade)
        course.add_grade_by_student(student, grade)

    def get_students(self) -> list[Student]:
        """Returns list of students."""
        return self.students
    
    def get_courses(self) -> list[Course]:
        """Returns list of courses."""
        return self.courses
    
    def get_students_ordered_by_average_grade(self) -> list[Student]:
        sorted_students = sorted(self.students, reverse=True, key= lambda student: student.get_average_grade())
        return sorted_students
