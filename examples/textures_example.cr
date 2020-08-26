require "../src/game"

class Explosion < SpriteEntity
  def initialize(x, y)
    super(x: x, y: y, sprite_name: :explosion)
  end

  def update(frame_time)
    if Mouse::Left.pressed?
      @x = Mouse.x
      @y = Mouse.y

      restart
    end

    return if x == 0 && y == 0

    super(frame_time)
  end

  def draw
    return if x == 0 && y == 0

    super
  end
end

class TexturesExample < Game
  @texture : Texture

  def initialize
    super(name: "Textures Example", background_color: Color::White)

    Sprite.load({
      :explosion => {
        filename: "./assets/explosion.png",
        width:    128,
        height:   128,
        loops:    false,
      },
      :dust => {
        filename:    "./assets/explosion.png",
        width:       128,
        height:      128,
        loops:       true,
        fps:         3,
        start_frame: 40,
        end_frame:   48,
      },
    })

    @texture = Texture.load("./assets/crystal_icon.png")
    @explosion = Explosion.new(x: 0, y: 0)
    @dust = Sprite.get(:dust)
    @dust2 = Sprite.get(:dust)
    @text = Text.new(
      text: "click to start explosion animation\nand pause/resume first dust animation",
      x: 15,
      y: 15,
      size: 20,
      spacing: 2,
      color: Color::Black
    )
  end

  def update(_frame_time)
    @explosion.update(frame_time)
    @dust.update(frame_time)
    @dust2.update(frame_time)

    if Mouse::Left.pressed?
      @dust.paused? ? @dust.start : @dust.pause
    end
  end

  def draw
    @text.draw
    @texture.draw(x: 100, y: 100)
    @explosion.draw
    @dust.draw(x: 500, y: 500)
    @dust2.draw(x: 700, y: 700)
  end
end

TexturesExample.new.run
