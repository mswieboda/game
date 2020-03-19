require "../src/game"

# This example will automatically scale with the window.

class Shapes < Game
  def initialize
    super(name: "Shapes")

    @rectangles = [
      Rectangle.new(
        x: 30,
        y: 100,
        width: 60,
        height: 60,
        filled: false
      ),
      Rectangle.new(
        x: 35,
        y: 105,
        width: 50,
        height: 50,
      ),
    ]

    @pixels = [
      Pixel.new(x: 150, y: 125),
      Pixel.new(x: 155, y: 130),
      Pixel.new(x: 160, y: 125),
      Pixel.new(x: 150, y: 135),
      Pixel.new(x: 160, y: 135),
    ]

    @lines = [
      Line.new(
        start_x: 200,
        start_y: 125,
        end_x: 210,
        end_y: 135
      ),
      Line.new(
        start_x: 200,
        start_y: 135,
        end_x: 210,
        end_y: 125
      ),
    ]

    @circles = [
      Circle.new(x: 300, y: 130, radius: 30, filled: false),
      Circle.new(x: 300, y: 130, radius: 25),
    ]

    @triangles = [
      Triangle.new(x1: 360, y1: 160, x2: 400, y2: 100, x3: 440, y3: 160, filled: false),
      Triangle.new(x1: 370, y1: 155, x2: 400, y2: 110, x3: 430, y3: 155),
    ]

    @polygons = [
      Polygon.new(x: 500, y: 130, sides: 5, radius: 30, filled: false),
      Polygon.new(x: 500, y: 130, sides: 5, radius: 25),
    ]

    @ellipses = [
      Ellipse.new(x: 600, y: 130, horizontal_radius: 30, vertical_radius: 60, filled: false),
      Ellipse.new(x: 600, y: 130, horizontal_radius: 25, vertical_radius: 55),
    ]

    @rings = [
      Ring.new(x: 700, y: 130, inner_radius: 30, outer_radius: 60, filled: false),
      Ring.new(x: 700, y: 130, inner_radius: 25, outer_radius: 55),
    ]
  end

  def update
  end

  def draw
    @rectangles.each(&.draw)

    @pixels.each(&.draw)

    @lines.each(&.draw)

    @circles.each(&.draw)

    @triangles.each(&.draw)

    @polygons.each(&.draw)

    @ellipses.each(&.draw)

    @rings.each(&.draw)
  end
end

Shapes.new.run
