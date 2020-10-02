require "../src/game"

# This example will automatically scale with the window.

class ColorsExample < Game
  def initialize
    super(name: "Colors Example")

    @shapes = [] of Shape

    @shapes << Square.new(x: 650, y: 100, size: 50, color: Color::Silver, filled: false)
    @shapes << Square.new(x: 655, y: 105, size: 40, color: Color::Lime)

    @shapes << Square.new(x: 300, y: 300, size: 100, color: Color::Blue)
    @shapes << Square.new(x: 350, y: 350, size: 100, color: Color::Red.alpha(0.5_f32))
    @shapes << Square.new(x: 413, y: 313, size: 25, color: Color::Blue.red(0.5))
    @shapes << Square.new(x: 600, y: 350, size: 100, color: Color::Yellow.alpha(0.025))
  end

  def update(_frame_time)
  end

  def draw
    @shapes.each(&.draw)
  end
end

ColorsExample.new.run
