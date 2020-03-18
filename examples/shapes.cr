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
  end

  def update
  end

  def draw
    @rectangle.draw
  end
end

Shapes.new.run
