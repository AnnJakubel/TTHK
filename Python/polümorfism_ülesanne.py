
"""Shapes."""
from abc import ABC, abstractmethod
from math import pi


class Shape(ABC):
    """General shape class."""

    def __init__(self, color: str):
        """Shape constructor."""
        self.color = color

    def set_color(self, color: str):
        """Set the color of the shape."""
        self.color = color

    def get_color(self) -> str:
        """Get the color of the shape."""
        return self.color

    @abstractmethod
    def get_area(self) -> float:
        """Get area method which every subclass has to override."""
        return 0.0


class Circle(Shape):
    """Circle is a subclass of Shape."""

    def __init__(self, color: str, radius: float):
        """
        Circle constructor.

        The color is stored using superclass constructor:
        super().__init__(color)

        The radius value is stored here.
        """
        super().__init__(color)
        self.radius = radius

    def __repr__(self) -> str:
        """
        Return representation of the circle.

        For this exercise, this should return a string:
        Circle (r: {radius}, color: {color})
        """
        return f"Circle (r: {self.radius}, color: {self.color})"

    def get_area(self) -> float:
        """
        Calculate the area of the circle.

        Area of the circle is pi * r * r.
        """
        return pi * self.radius * self.radius


class Square(Shape):
    """Square is a subclass of Shape."""

    def __init__(self, color: str, side: float):
        """
        Square constructor.

        The color is stored using superclass constructor:
        super().__init__(color)

        The side value is stored here.
        """
        super().__init__(color)
        self.side = side

    def __repr__(self) -> str:
        """
        Return representation of the square.

        For this exercise, this should return a string:
        Square (a: {side}, color: {color})
        """
        return f"Square (a: {self.side}, color: {self.color})"

    def get_area(self) -> float:
        """
        Calculate the area of the square.

        Area of the square is side * side.
        """
        return self.side * self.side


# class Rectangle(Shape):
class Rectangle(Shape):
    """Rectangle is a subclass of Shape."""

    def __init__(self, color: str, length: float, width: float):
        """
        Rectangle constructor.

        The color is stored using superclass constructor:
        super().__init__(color)

        The length and width values are stored here.
        """
        super().__init__(color)
        self.length = length
        self.width = width

    def __repr__(self) -> str:
        """
        Return representation of the rectangle.

        For this exercise, this should return a string:
        Rectangle (l: {self.length}, w: {self.width}, color: {self.color})
        """
        return f"Rectangle (l: {self.length}, w: {self.width}, color: {self.color})"

    def get_area(self) -> float:
        """
        Calculate the area of the square.

        Area of the square is length * width.
        """
        return self.length * self.width


class Paint:
    """The main program to manipulate the shapes."""

    def __init__(self):
        """Paint constructor."""
        self.shapes_list = []

    def add_shape(self, shape: Shape) -> None:
        """Add a shape to the program."""
        self.shapes_list.append(shape)

    def get_shapes(self) -> list:
        """Return all the shapes."""
        return self.shapes_list

    def calculate_total_area(self) -> float:
        """Calculate total area of the shapes."""
        total_area = 0.0
        for shape in self.shapes_list:
            total_area += shape.get_area()
        return total_area

    def get_circles(self) -> list:
        """Return only circles."""
        list_of_circles = []
        for shape in self.shapes_list:
            if isinstance(shape, Circle):
                list_of_circles.append(shape)
        return list_of_circles

    def get_squares(self) -> list:
        """Return only squares."""
        list_of_squares = []
        for shape in self.shapes_list:
            if isinstance(shape, Square):
                list_of_squares.append(shape)
        return list_of_squares

    def get_rectangles(self) -> list:
        """Return only rectangles."""
        list_of_rectangles = []
        for shape in self.shapes_list:
            if isinstance(shape, Rectangle):
                list_of_rectangles.append(shape)
        return list_of_rectangles


if __name__ == '__main__':
    paint = Paint()
    circle = Circle("blue", 10)
    square = Square("red", 11)
    paint.add_shape(circle)
    paint.add_shape(square)
    print(paint.calculate_total_area())
    print(paint.get_circles())
