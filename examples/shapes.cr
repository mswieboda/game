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
  end

  def update
  end

  def draw
    @rectangles.each(&.draw)

    @pixels.each(&.draw)

    @lines.each(&.draw)

    @circles.each(&.draw)
  end
end

Shapes.new.run
