require "../src/game"

# This example will automatically scale with the window.

class HelloWorld < Game
  @color : LibRay::Color

  def initialize
    super(name: "Hello World")

    @font = LibRay::Font.new
    @text = "hello world"
    @font_size = 20
    @spacing = 10
    @color = LibRay::GREEN

    @text_size = LibRay::Vector2.new
    @position = LibRay::Vector2.new
  end

  def setup
    @font = LibRay.get_font_default
    @text_size = LibRay.measure_text_ex(@font, @text, @font_size, @spacing)
    @position = LibRay::Vector2.new(
      x: screen_width / 2.0 - @text_size.x,
      y: screen_height / 2.0 - @text_size.y
    )
  end

  def update
  end

  def draw
    LibRay.draw_text_ex(@font, @text, @position, @font_size, @spacing, @color)
  end
end

HelloWorld.new.run
