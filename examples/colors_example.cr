require "../src/game"

# This example will automatically scale with the window.

class ColorsExample < Game
  def initialize
    super(name: "Colors Example")

    # TODO: WIP showcase colors, and color ranges etc, gradients?

    @shapes = [] of Shape

    @shapes << Square.new(x: 650, y: 100, size: 50, filled: false)
    @shapes << Square.new(x: 655, y: 105, size: 40)
  end

  def update
  end

  def draw
    @shapes.each(&.draw)
  end
end

ColorsExample.new.run
