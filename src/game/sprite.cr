require "./texture"

class Sprite
  getter texture : Texture
  getter frames : Int32
  getter rows : Int32
  getter width : Int32
  getter height : Int32
  getter frame_time : Float32
  property fps : Int32

  @frame : Int32
  @row : Int32

  @@sprites = Hash(String, NamedTuple(texture: Texture, frames: Int32, rows: Int32, fps: Int32)).new

  def initialize(image : Image, @frames = 1, @rows = 1, @frame = 0, @row = 0, @fps = 0)
    @texture = Texture.new
    @texture = Texture.get(image)

    @width = (@texture.width / @frames).to_i
    @height = (@texture.height / @rows).to_i
    @frame_time = 0_f32
  end

  # Intialize a sprite that wasn't already loaded
  def initialize(filename : String, @frames = 1, @rows = 1, @frame = 0, @row = 0, @fps = 0)
    @texture = Texture.new
    @texture = Texture.get(filename)

    @width = (@texture.width / @frames).to_i
    @height = (@texture.height / @rows).to_i

    @frame_time = 0_f32

    @@sprites[filename] = {texture: @texture, frames: @frames, rows: @rows, fps: @fps}
  end

  def initialize(@texture : Texture, @frames = 1, @rows = 1, @frame = 0, @row = 0, @fps = 0)
    @width = (@texture.width / @frames).to_i
    @height = (@texture.height / @rows).to_i
    @frame_time = 0_f32
  end

  # Get a loaded sprite
  def self.get(filename)
    puts "getting sprite: #{filename}" if Game::DEBUG

    sprite = @@sprites[filename]

    unless sprite
      raise "sprite: #{filename} not found, make sure to load first with Sprite.load before using"
    end

    puts "got sprite: #{filename}" if Game::DEBUG

    Sprite.new(texture: sprite[:texture], frames: sprite[:frames], rows: sprite[:rows], fps: sprite[:fps])
  end

  # Load multiple sprites
  def self.load(sprites : Array(NamedTuple(filename: String, frames: Int32, rows: Int32, fps: Int32)))
    sprites.each { |sprite| load(filename: sprite[:filename], frames: sprite[:frames], rows: sprite[:rows], fps: sprite[:fps]) }
  end

  # Load a sprite
  def self.load(filename, frames, rows, fps)
    if @@sprites.has_key?(filename)
      puts "sprite reloading: #{filename}" if Game::DEBUG
      sprite_info = @@sprites[filename]
      sprite = Sprite.new(texture: sprite_info[:texture], frames: frames, rows: rows, fps: fps)
    else
      puts "sprite initializing: #{filename}" if Game::DEBUG
      sprite = Sprite.new(filename: filename, frames: frames, rows: rows, fps: fps)
    end

    puts "sprite loaded: #{filename}" if Game::DEBUG

    sprite
  end

  def update(frame_time)
    @frame_time += frame_time
  end

  def frame
    (@frame_time * @fps).to_i
  end

  def frame=(frame)
    @frame_time = frame.to_f32 / @fps
  end

  def draw(x, y, tint = Color::White)
    LibRay.draw_texture_pro(
      texture: texture.to_struct,
      source_rec: LibRay::Rectangle.new(
        x: frame * width,
        y: @row * height,
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
