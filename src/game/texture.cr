class Texture
  getter texture : LibRay::Texture2D

  delegate :width, :height, to: texture

  @@textures = Hash(String, Texture).new

  def initialize
    @texture = LibRay::Texture2D.new
  end

  def initialize(image : Image)
    @texture = LibRay::Texture2D.new

    load(image)
  end

  def initialize(filename : String)
    @texture = LibRay::Texture2D.new

    load(filename)
  end

  def self.load(image : Image)
    Texture.new(image)
  end

  def self.load(filename)
    puts "loading texture: #{filename}" if Game::DEBUG

    bin_dir = Process.executable_path || ""
    last_slash_index = bin_dir.rindex('/')
    bin_dir = bin_dir[0..last_slash_index]

    @@textures[filename] ||= Texture.new(File.join(bin_dir, "#{filename}"))

    texture = @@textures[filename]

    puts "loaded texture: #{filename}" if Game::DEBUG

    texture
  end

  def self.get(filename)
    puts "getting texture: #{filename}" if Game::DEBUG

    unless @@textures.has_key?(filename)
      texture = load(filename)
    end

    texture = @@textures[filename]

    puts "got texture: #{filename}" if Game::DEBUG

    texture
  end

  def get(filename)
    @texture = Texture.get(filename)
  end

  def load(image : Image)
    @texture = LibRay.load_texture_from_image(image.to_struct)
  end

  def load(filename : String)
    @texture = LibRay.load_texture(filename)
  end

  def unload
    LibRay.unload_texture(texture)
  end

  def to_image
    image = Image.new
    image.image = LibRay.get_texture_data(texture)
    image
  end

  def to_struct
    texture
  end

  def draw(x, y, rotation = 0, scale = 1, tint = Color::White)
    LibRay.draw_texture_ex(
      texture: texture,
      position: LibRay::Vector2.new(
        x: x,
        y: y
      ),
      rotation: rotation,
      scale: scale,
      tint: tint.to_struct
    )
  end
end
