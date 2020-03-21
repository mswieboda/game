require "../src/game"

# This example will automatically scale with the window.

class ShapesExample < Game
  def initialize
    super(name: "Shapes Example")

    @shapes = [] of Shape

    @shapes << Pixel.new(x: 50, y: 125)
    @shapes << Pixel.new(x: 55, y: 130)
    @shapes << Pixel.new(x: 60, y: 125)
    @shapes << Pixel.new(x: 50, y: 135)
    @shapes << Pixel.new(x: 60, y: 135)

    @shapes << Line.new(start_x: 100, start_y: 125, end_x: 110, end_y: 135)
    @shapes << Line.new(start_x: 100, start_y: 135, end_x: 110, end_y: 125)

    @shapes << Circle.new(x: 175, y: 100, size: 50, filled: false)
    @shapes << Circle.new(center_x: 200, center_y: 125, radius: 20)

    @shapes << Triangle.new(x1: 275, y1: 160, x2: 300, y2: 100, x3: 325, y3: 160, filled: false)
    @shapes << Triangle.new(x1: 280, y1: 155, x2: 300, y2: 110, x3: 320, y3: 155)

    @shapes << Polygon.new(center_x: 400, center_y: 130, sides: 5, radius: 25, filled: false)
    @shapes << Polygon.new(center_x: 400, center_y: 130, sides: 5, radius: 20)

    @shapes << Ellipse.new(x: 450, y: 70, width: 50, height: 120, filled: false)
    @shapes << Ellipse.new(center_x: 475, center_y: 130, horizontal_radius: 20, vertical_radius: 55)

    @shapes << Ring.new(x: 525, y: 105, inner_radius: 5, size: 50, filled: false)
    @shapes << Ring.new(center_x: 550, center_y: 130, inner_radius: 10, outer_radius: 20)

    @shapes << Rectangle.new(x: 600, y: 100, width: 20, height: 50, filled: false)
    @shapes << Rectangle.new(x: 605, y: 105, width: 10, height: 40)

    @shapes << Square.new(x: 650, y: 100, size: 50, filled: false)
    @shapes << Square.new(x: 655, y: 105, size: 40)

    @shapes << EquilateralTriangle.new(x: 725, y: 100, size: 50, filled: false)
    @shapes << EquilateralTriangle.new(center_x: 750, center_y: 125, radius: 20)
  end

  def update
  end

  def draw
    @shapes.each(&.draw)
  end
end

ShapesExample.new.run
