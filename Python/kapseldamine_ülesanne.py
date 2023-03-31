"""Encapsulation exercise."""


class Student:
    """Represent student with name, id and status."""

    statuses = ["Active", "Inactive", "Expelled", "Finished"]

    def __init__(self, name, student_id):
        """Initialize."""
        self.__name = name
        self.__id = student_id
        self.__status = "Active"

    def get_id(self):
        """Return id."""
        return self.__id

    def set_name(self, name):
        """Set name."""
        self.__name = name

    def get_name(self):
        """Return name."""
        return self.__name

    def set_status(self, status):
        """Set status."""
        if status in Student.statuses:
            self.__status = status

    def get_status(self):
        """Return status."""
        return self.__status