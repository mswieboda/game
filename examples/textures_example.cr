require "../src/game"

# This example will automatically scale with the window.

class TexturesExample < Game
  @texture : Texture

  def initialize
    super(name: "TexturesExample", background_color: Color::White)

    @texture = Texture.load("./examples/assets/crystal_icon.png")
  end

  def update
  end

  def draw
    @texture.draw(x: 30, y: 30)
  end
end

TexturesExample.new.run
