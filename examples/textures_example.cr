require "../src/game"

class TexturesExample < Game
  @texture : Texture

  def initialize
    super(name: "Textures Example", background_color: Color::White)

    Sprite.load([
      {
        name:     :explosion,
        filename: "./assets/explosion.png",
        width:    128,
        height:   128,
        loops:    false,
      },
      {
        name:        :dust,
        filename:    "./assets/explosion.png",
        width:       128,
        height:      128,
        loops:       true,
        fps:         3,
        start_frame: 40,
        end_frame:   48,
      },
    ])

    @explosion = Sprite.get(:explosion)

    @texture = Texture.load("./assets/crystal_icon.png")

    @text = Text.new(
      text: "click for sprite animation",
      x: 15,
      y: 15,
      size: 20,
      spacing: 2,
      color: Color::Black
    )

    @dust = Sprite.get(:dust)

    @x = 0
    @y = 0
  end

  def update
    @explosion.update(frame_time) unless @x == 0 && @y == 0
    @dust.update(frame_time)

    if LibRay.mouse_button_pressed?(LibRay::MOUSE_LEFT_BUTTON)
      @x = LibRay.get_mouse_x
      @y = LibRay.get_mouse_y
      @explosion.restart
    end
  end

  def draw
    @text.draw

    @texture.draw(x: 100, y: 100)

    @explosion.draw(x: @x, y: @y) unless @x == 0 && @y == 0

    @dust.draw(x: 500, y: 500)
  end
end

TexturesExample.new.run
