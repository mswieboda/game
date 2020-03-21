class Image
  property image : LibRay::Image

  def initialize
    @image = LibRay::Image.new
  end

  def initialize(filename : String)
    @image = LibRay::Image.new
    load(filename)
  end

  def self.load(filename)
    Image.new(filename)
  end

  def self.get_screen_shot
    image = Image.new
    image.image = LibRay.get_screen_data
    image
  end

  def load(filename : String)
    @image = LibRay.load_image(filename)
  end

  def unload
    LibRay.unload_image(image)
  end

  def to_struct
    image
  end
end
