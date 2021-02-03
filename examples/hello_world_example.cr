require "../src/game"

class HelloWorldExample < Game::Game
  def initialize
    super(name: "Hello World Example", screen_width: 1024, screen_height: 768)

    @text = Game::Text.new(
      text: "hello world",
      size: 30,
      spacing: 10,
      color: Game::Color::Lime
    )

    @text_input = Game::TextInput.new(
      text: "foo",
      size: 30,
      spacing: 10,
      color: Game::Color::Lime
    )
    @text_input.focused = true
  end

  def setup
    @text.x = screen_width / 2.0 - @text.width / 2.0
    @text.y = screen_height / 2.0 - @text.height / 2.0

    @text_input.x = screen_width / 2.0
    @text_input.y = screen_height / 1.5
  end

  def update(frame_time)
    @text_input.update(frame_time)
  end

  def draw
    @text.draw
    @text_input.draw
  end
end

HelloWorldExample.new.run
