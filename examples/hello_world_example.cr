require "../src/game"

# This example will automatically scale with the window.

class HelloWorldExample < Game
  def initialize
    super(name: "Hello World Example")

    @text = Text.new(
      text: "hello world",
      size: 30,
      spacing: 10,
      color: Color::Green
    )
  end

  def setup
    @text.x = screen_width / 2.0 - @text.width / 2.0
    @text.y = screen_height / 2.0 - @text.height / 2.0
  end

  def update
  end

  def draw
    @text.draw
  end
end

HelloWorldExample.new.run
