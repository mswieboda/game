require "../src/game"

# This example will automatically scale with the window.

class Shapes < Game
  def initialize
    super(name: "Shapes")

    @rectangle = Rectangle.new(
      x: 30,
      y: 100,
      width: 100,
      height: 100
    )

    @pixels = [
      Pixel.new(x: 150, y: 125),
      Pixel.new(x: 155, y: 130),
      Pixel.new(x: 160, y: 125),
      Pixel.new(x: 150, y: 135),
      Pixel.new(x: 160, y: 135),
    ]
  end

  def update
  end

  def draw
    @rectangle.draw

    @pixels.each(&.draw)
  end
end

Shapes.new.run
