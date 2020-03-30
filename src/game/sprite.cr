require "./texture"

class Sprite
  getter texture : Texture
  getter frame_time : Float32
  getter cols : Int32
  getter rows : Int32
  getter? paused

  getter frames : Int32
  getter width : Int32
  getter height : Int32
  property fps : Int32
  getter? loops
  getter start_frame : Int32
  getter end_frame : Int32

  FPS = 24

  @@sprite_data = SpriteData.new

  alias SpriteData = Hash(Symbol, SpriteDataAny)
  alias SpriteDataFull = {filename: String, width: Int32, height: Int32, fps: Int32, loops: Bool, start_frame: Int32, end_frame: Int32}
  alias SpriteDataNoFPS = {filename: String, width: Int32, height: Int32, loops: Bool, start_frame: Int32, end_frame: Int32}
  alias SpriteDataNoLoops = {filename: String, width: Int32, height: Int32, fps: Int32, start_frame: Int32, end_frame: Int32}
  alias SpriteDataNoStartEndFrames = {filename: String, width: Int32, height: Int32, fps: Int32, loops: Bool}
  alias SpriteDataNoFPSNoStartEndFrames = {filename: String, width: Int32, height: Int32, loops: Bool}
  alias SpriteDataNoLoopsNoStartEndFrames = {filename: String, width: Int32, height: Int32, fps: Int32}
  alias SpriteDataNoFPSNoLoopsNoStartEndFrames = {filename: String, width: Int32, height: Int32}

  SPRITE_DATA_TYPES = [
    SpriteDataFull,
    SpriteDataNoFPS,
    SpriteDataNoLoops,
    SpriteDataNoStartEndFrames,
    SpriteDataNoFPSNoStartEndFrames,
    SpriteDataNoLoopsNoStartEndFrames,
    SpriteDataNoFPSNoLoopsNoStartEndFrames,
  ]

  macro define_sprite_data_union
    alias SpriteDataAny = {% for t in SPRITE_DATA_TYPES[0..-2] %} {{t}} | {% end %} {{SPRITE_DATA_TYPES[-1]}}
  end

  define_sprite_data_union

  macro define_load_sprite_data
    {% for t in SPRITE_DATA_TYPES %}
      def self.load(name : Symbol, sprite_data : {{t}})
        load(name, **sprite_data)
      end
    {% end %}
  end

  def initialize(filename : String, @width, @height, fps = FPS, loops = true, start_frame = nil, end_frame = nil)
    @texture = Texture.new
    @texture = Texture.get(filename)

    @cols = (@texture.width / @width).to_i
    @rows = (@texture.height / @height).to_i

    @fps = (fps || FPS).to_i
    @loops = loops.nil? ? true : !!loops

    @start_frame = (start_frame || 0).to_i
    @end_frame = (end_frame || @cols * @rows - 1).to_i

    @frames = @end_frame - @start_frame + 1

    @paused = false
    @frame_time = 0_f32
  end

  # Initialize a new sprite with previously loaded SpriteData attributes
  def self.get(name) : Sprite
    puts "getting sprite data: #{name}" if Game::DEBUG

    sprite_data = @@sprite_data[name]

    unless sprite_data
      raise "sprite data: #{name} not found, make sure to load first with Sprite.load before using"
    end

    puts "got sprite data: #{name}" if Game::DEBUG

    sprite = Sprite.new(
      filename: sprite_data[:filename],
      width: sprite_data[:width],
      height: sprite_data[:height],
      fps: sprite_data[:fps]?,
      loops: sprite_data[:loops]?,
      start_frame: sprite_data[:start_frame]?,
      end_frame: sprite_data[:end_frame]?
    )
  end

  # Load multiple sprites
  def self.load(sprites : SpriteData)
    sprites.each { |name, sprite_data| load(name, sprite_data) }
  end

  define_load_sprite_data

  def self.load(name, filename, width, height, fps = FPS, loops = true, start_frame = nil, end_frame = nil)
    puts "sprite initializing: #{name}" if Game::DEBUG

    fps_test = (fps || FPS).to_i

    if start_frame && end_frame
      sprite_data = {
        filename:    filename,
        width:       width,
        height:      height,
        fps:         fps_test,
        loops:       loops,
        start_frame: start_frame,
        end_frame:   end_frame,
      }
    else
      sprite_data = {
        filename: filename,
        width:    width,
        height:   height,
        fps:      fps_test,
        loops:    loops,
      }
    end

    puts "sprite loaded: #{name}" if Game::DEBUG

    @@sprite_data[name] = sprite_data
  end

  def update(frame_time)
    animate(frame_time) unless paused?
  end

  def animate(frame_time)
    if loops? && done?
      restart
    else
      @frame_time += frame_time unless done?
    end
  end

  def pause
    @paused = true
  end

  def start
    @paused = false
  end

  def done?
    frame >= end_frame
  end

  def restart
    @frame_time = 0_f32
    start
  end

  def frame
    start_frame + (@frame_time * @fps).to_i
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
