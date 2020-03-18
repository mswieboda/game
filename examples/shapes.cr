require "../src/game"

# This example will automatically scale with the window.

class Shapes < Game
  def initialize
    super(name: "Shapes")

    @rectangle = Rectangle.new(
      x: 30,
      y: 100,
      width: 50,
      height: 50
    )

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

    @circle = Circle.new(x: 300, y: 125, radius: 25)
  end

  def update
  end

  def draw
    @rectangle.draw

    @pixels.each(&.draw)

    @lines.each(&.draw)

    @circle.draw
  end
end

Shapes.new.run
