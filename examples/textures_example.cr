require "../src/game"

class Explosion < Game::SpriteEntity
  def initialize(x, y)
    super(x: x, y: y, sprite_name: :explosion)
  end

  def update(frame_time)
    if Game::Mouse::Left.pressed?
      @x = Game::Mouse.x
      @y = Game::Mouse.y

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

class TexturesExample < Game::Game
  @crystal_icon_resized : Game::Sprite
  @crystal_icon_zoom : Game::Sprite
  @from_text : Game::Texture
  @draw_to : Game::Texture

  def initialize
    super(name: "Textures Example", background_color: Game::Color::White)

    Game::Sprite.load({
      :explosion => {
        filename: "./assets/explosion.png",
        width: 128,
        height: 128,
        loops: false
      },
      :dust => {
        filename: "./assets/explosion.png",
        width: 128,
        height: 128,
        loops: true,
        fps: 3,
        start_frame: 40,
        end_frame: 48,
      },
      :crystal_icon => {
        filename: "./assets/crystal_icon.png",
        width: 142,
        height: 142,
        loops: false
      }
    })

    @crystal_icon = Game::Sprite.get(:crystal_icon)
    @crystal_icon_resized = @crystal_icon.resize(width: 71, height: 71)
    @crystal_icon_zoom = @crystal_icon.clone

    @explosion = Explosion.new(x: 0, y: 0)
    @dust = Game::Sprite.get(:dust)
    @dust2 = Game::Sprite.get(:dust)
    @text = Game::Text.new(
      text: "click to start explosion animation, and pause/resume first dust animation\nup/down arrow keys to scale image",
      x: 15,
      y: 15,
      size: 20,
      spacing: 2,
      color: Game::Color::Black
    )

    image_text = Game::Image.from_text("abc123", 20, 2, Game::Color::Red)
    image_text.flip_vertical!
    image_text.flip_horizontal!
    @from_text = Game::Texture.load(image_text)

    image_draw_to = Game::Image.from_size(100, 200, Game::Color::Red.alpha(50_u8))

    @crystal_icon.draw(image: image_draw_to)

    text = Game::Text.new(
      x: 10,
      y: 20,
      text: "123foo",
      size: 20,
      spacing: 2,
      color: Game::Color::Red
    )
    image_draw_to.draw(text)

    @draw_to = Game::Texture.load(image_draw_to)
  end

  def update(frame_time)
    @explosion.update(frame_time)
    @dust.update(frame_time)
    @dust2.update(frame_time)

    if Game::Mouse::Left.pressed?
      @dust.paused? ? @dust.start : @dust.pause
    end

    if Game::Key::Up.down?
      @crystal_icon_zoom.resize!(@crystal_icon_zoom.width + 1, @crystal_icon_zoom.height + 1)
    elsif Game::Key::Down.down? && @crystal_icon_zoom.width > 1 && @crystal_icon_zoom.height > 1
      @crystal_icon_zoom.resize!(@crystal_icon_zoom.width - 1, @crystal_icon_zoom.height - 1)
    end
  end

  def draw
    @text.draw
    @explosion.draw
    @dust.draw(x: 500, y: 500)
    @dust2.draw(x: 700, y: 700)
    @crystal_icon.draw(x: 100, y: 100)
    @crystal_icon_resized.draw(x: 100, y: 300)
    @crystal_icon_zoom.draw(x: 100, y: 500)

    @from_text.draw(x: 300, y: 300)
    @draw_to.draw(x: 500, y: 100)
  end
end

TexturesExample.new.run
