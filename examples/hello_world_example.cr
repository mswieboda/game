require "../src/game"

class HelloWorldExample < Game::Game
  def initialize
    super(name: "Hello World Example")

    @text = Game::Text.new(
      text: "hello world",
      size: 30,
      spacing: 10,
      color: Game::Color::Lime
    )
  end

  def setup
    @text.x = screen_width / 2.0 - @text.width / 2.0
    @text.y = screen_height / 2.0 - @text.height / 2.0
  end

  def update(_frame_time)
  end

  def draw
    @text.draw
  end
end

HelloWorldExample.new.run
