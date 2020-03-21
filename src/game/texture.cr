class Texture
  property texture : LibRay::Texture2D

  delegate :width, :height, to: texture

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

  def self.load(filename : String)
    Texture.new(filename)
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
