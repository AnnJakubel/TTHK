class Point2D:
    def __init__(self, x=0, y=0):
        self.x = x
        self.y = y
    
    def __repr__(self):
        return  f"Point2D({self.x}, {self.y})"
    
#    def __str__(self):
#       return  f"({self.x}, {self.y})"
    
p1 = Point2D(6, 7)
p2 = eval(str(p1))
print(type(p2))