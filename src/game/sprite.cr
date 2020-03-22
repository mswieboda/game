require "./texture"

class Sprite
  getter name : Symbol
  getter texture : Texture
  getter frames : Int32
  getter cols : Int32
  getter rows : Int32
  getter width : Int32
  getter height : Int32
  getter frame_time : Float32
  property fps : Int32
  getter? loops

  @@sprites = Hash(Symbol, Sprite).new

  FPS = 24

  alias SpriteData = {name: Symbol, filename: String, width: Int32, height: Int32, fps: Int32, loops: Bool}
  alias SpriteDataNoLoops = {name: Symbol, filename: String, width: Int32, height: Int32, fps: Int32}
  alias SpriteDataNoFPS = {name: Symbol, filename: String, width: Int32, height: Int32, loops: Bool}
  alias SpriteDataNoFPSNoLoops = {name: Symbol, filename: String, width: Int32, height: Int32}

  def initialize(@name, filename : String, @width, @height, @fps = FPS, @loops = true)
    @texture = Texture.new
    @texture = Texture.get(filename)

    @cols = (@texture.width / @width).to_i
    @rows = (@texture.height / @height).to_i
    @frames = @cols * @rows

    @frame_time = 0_f32
  end

  # Get a loaded sprite
  def self.get(name) : Sprite
    puts "getting sprite: #{name}" if Game::DEBUG

    sprite = @@sprites[name]

    unless sprite
      raise "sprite: #{name} not found, make sure to load first with Sprite.load before using"
    end

    puts "got sprite: #{name}" if Game::DEBUG

    sprite
  end

  # Load multiple sprites
  def self.load(sprites : Array(SpriteData | SpriteDataNoFPS | SpriteDataNoLoops | SpriteDataNoFPSNoLoops))
    sprites.each { |sprite| load(sprite) }
  end

  # Load a sprite
  def self.load(sprite : SpriteData)
    load(name: sprite[:name], filename: sprite[:filename], width: sprite[:width], height: sprite[:height], fps: sprite[:fps], loops: sprite[:loops])
  end

  def self.load(sprite : SpriteDataNoLoops)
    load(name: sprite[:name], filename: sprite[:filename], width: sprite[:width], height: sprite[:height], fps: sprite[:fps])
  end

  def self.load(sprite : SpriteDataNoFPS)
    load(name: sprite[:name], filename: sprite[:filename], width: sprite[:width], height: sprite[:height], loops: sprite[:loops])
  end

  def self.load(sprite : SpriteDataNoFPSNoLoops)
    load(name: sprite[:name], filename: sprite[:filename], width: sprite[:width], height: sprite[:height])
  end

  def self.load(name, filename, width, height, fps = FPS, loops = true)
    if @@sprites.has_key?(name)
      puts "sprite already loaded: #{name}" if Game::DEBUG
      return @@sprites[name]
    else
      puts "sprite initializing: #{name}" if Game::DEBUG
      sprite = Sprite.new(name: name, filename: filename, width: width, height: height, fps: fps, loops: loops)
      @@sprites[name] = sprite
    end

    puts "sprite loaded: #{filename}" if Game::DEBUG

    sprite
  end

  def update(frame_time)
    animate(frame_time)
  end

  def animate(frame_time)
    if loops? && done?
      restart
    else
      @frame_time += frame_time unless done?
    end
  end

  def done?
    frame >= frames - 1
  end

  def restart
    @frame_time = 0_f32
  end

  def frame
    (@frame_time * @fps).to_i
  end

  def col
    frame % @cols
  end

  def row
    (frame / @cols).to_i
  end

  def frame=(frame)
    @frame_time = frame.to_f32 / @fps
  end

  def draw(x, y, tint = Color::White)
    LibRay.draw_texture_pro(
      texture: texture.to_struct,
      source_rec: LibRay::Rectangle.new(
        x: col * width,
        y: row * height,
        width: width,
        height: height
      ),
      dest_rec: LibRay::Rectangle.new(
        x: x,
        y: y,
        width: width,
        height: height
      ),
      origin: LibRay::Vector2.new(
        x: width / 2,
        y: height / 2
      ),
      rotation: 0,
      tint: tint.to_struct
    )
  end
end
