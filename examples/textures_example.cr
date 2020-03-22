require "../src/game"

class TexturesExample < Game
  @texture : Texture

  def initialize
    super(name: "Textures Example", background_color: Color::White)

    Sprite.load("./assets/explosion.png", frames: 8, rows: 6, fps: 16)

    @text = Text.new(
      text: "click for sprite animation",
      x: 15,
      y: 15,
      size: 20,
      spacing: 2,
      color: Color::Black
    )

    @texture = Texture.load("./assets/crystal_icon.png")

    @sprite = Sprite.get("./assets/explosion.png")

    @x = 0
    @y = 0
  end

  def update
    @sprite.update(frame_time)

    if LibRay.mouse_button_pressed?(LibRay::MOUSE_LEFT_BUTTON)
      @x = LibRay.get_mouse_x
      @y = LibRay.get_mouse_y
    end
  end

  def draw
    @text.draw

    @texture.draw(x: 100, y: 100)

    @sprite.draw(x: @x, y: @y) unless @x == 0 && @y == 0
  end
end

TexturesExample.new.run
