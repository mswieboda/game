require "../src/game"

class ColorsExample < Game::Game
  def initialize
    super(name: "Colors Example")

    @shapes = [] of Game::Shape

    @shapes << Game::Square.new(x: 650, y: 100, size: 50, color: Game::Color::Silver, filled: false)
    @shapes << Game::Square.new(x: 655, y: 105, size: 40, color: Game::Color::Lime)

    @shapes << Game::Square.new(x: 300, y: 300, size: 100, color: Game::Color::Blue)
    @shapes << Game::Square.new(x: 350, y: 350, size: 100, color: Game::Color::Red.alpha(0.5_f32))
    @shapes << Game::Square.new(x: 413, y: 313, size: 25, color: Game::Color::Blue.red(0.5))
    @shapes << Game::Square.new(x: 600, y: 350, size: 100, color: Game::Color::Yellow.alpha(0.025))
  end

  def update(_frame_time)
  end

  def draw
    @shapes.each(&.draw)
  end
end

ColorsExample.new.run
