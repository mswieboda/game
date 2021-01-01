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
  @texture : Game::Texture
  @texture_resized : Game::Texture
  @image : Game::Image
  @image_zoom : Game::Image
  @texture_zoom : Game::Texture

  def initialize
    super(name: "Textures Example", background_color: Game::Color::White)

    Game::Sprite.load({
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

    @image = Game::Image.load("./assets/crystal_icon.png")
    @texture = Game::Texture.load(@image)

    image_resized = @image.resize(width: 71, height: 71)
    @image_zoom = @image.copy
    @texture_resized = Game::Texture.load(image_resized)
    @texture_zoom = Game::Texture.load(@image_zoom)

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
  end

  def update(frame_time)
    @explosion.update(frame_time)
    @dust.update(frame_time)
    @dust2.update(frame_time)

    if Game::Mouse::Left.pressed?
      @dust.paused? ? @dust.start : @dust.pause
    end

    if Game::Key::Up.down?
      @image_zoom.resize!(@image_zoom.width + 1, @image_zoom.height + 1)
      @texture_zoom = Game::Texture.load(@image_zoom)
    elsif Game::Key::Down.down? && @image_zoom.width > 1 && @image_zoom.height > 1
      @image_zoom.resize!(@image_zoom.width - 1, @image_zoom.height - 1)
      @texture_zoom = Game::Texture.load(@image_zoom)
    end
  end

  def draw
    @text.draw
    @explosion.draw
    @dust.draw(x: 500, y: 500)
    @dust2.draw(x: 700, y: 700)
    @texture.draw(x: 100, y: 100)
    @texture_resized.draw(x: 100, y: 300)
    @texture_zoom.draw(x: 100, y: 500)
  end
end

TexturesExample.new.run
