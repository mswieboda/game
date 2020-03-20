require "../src/game"

# This example will automatically scale with the window.

class ShapesExample < Game
  def initialize
    super(name: "Shapes")

    @shapes = [] of Shape

    @shapes << Pixel.new(x: 50, y: 125)
    @shapes << Pixel.new(x: 55, y: 130)
    @shapes << Pixel.new(x: 60, y: 125)
    @shapes << Pixel.new(x: 50, y: 135)
    @shapes << Pixel.new(x: 60, y: 135)

    @shapes << Line.new(start_x: 100, start_y: 125, end_x: 110, end_y: 135)
    @shapes << Line.new(start_x: 100, start_y: 135, end_x: 110, end_y: 125)

    @shapes << Circle.new(x: 200, y: 130, radius: 25, filled: false)
    @shapes << Circle.new(x: 200, y: 130, radius: 20)

    @shapes << Triangle.new(x1: 260, y1: 160, x2: 300, y2: 100, x3: 340, y3: 160, filled: false)
    @shapes << Triangle.new(x1: 270, y1: 155, x2: 300, y2: 110, x3: 330, y3: 155)

    @shapes << Polygon.new(x: 400, y: 130, sides: 5, radius: 25, filled: false)
    @shapes << Polygon.new(x: 400, y: 130, sides: 5, radius: 20)

    @shapes << Ellipse.new(x: 475, y: 130, horizontal_radius: 25, vertical_radius: 60, filled: false)
    @shapes << Ellipse.new(x: 475, y: 130, horizontal_radius: 20, vertical_radius: 55)

    @shapes << Ring.new(x: 550, y: 130, inner_radius: 5, outer_radius: 25, filled: false)
    @shapes << Ring.new(x: 550, y: 130, inner_radius: 10, outer_radius: 20)

    @shapes << Rectangle.new(x: 600, y: 100, width: 20, height: 50, filled: false)
    @shapes << Rectangle.new(x: 605, y: 105, width: 10, height: 40)

    @shapes << Square.new(x: 650, y: 100, size: 50, filled: false)
    @shapes << Square.new(x: 655, y: 105, size: 40)
  end

  def update
  end

  def draw
    @shapes.each(&.draw)
  end
end

ShapesExample.new.run
