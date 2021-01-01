module Game
  class Image
    getter image : LibRay::Image

    delegate :width, :height, to: image

    @image_source : LibRay::Image

    @@images = Hash(String, Image).new

    def initialize(@image = LibRay::Image.new)
      @image_source = @image
    end

    def initialize(filename : String)
      @image = LibRay::Image.new
      @image_source = @image
      load(filename)
    end

    def self.load(filename)
      Image.new(filename)
    end

    def self.get_screen_shot
      Image.new(LibRay.get_screen_data)
    end

    def load(filename : String)
      filename = Utils.expand_path(filename)

      puts "loading image: #{filename}" if Game::DEBUG

      @image = LibRay.load_image(filename)
      @image_source = @image

      @@images[filename] = self

      self
    end

    def self.get(filename)
      filename = Utils.expand_path(filename)

      puts "getting image: #{filename}" if Game::DEBUG

      unless @@images.has_key?(filename)
        @@images[filename] = load(filename)
      end

      image = @@images[filename]

      puts "got image: #{filename}" if Game::DEBUG

      image
    end

    def get(filename)
      @image = Image.get(filename)
    end

    def unload
      LibRay.unload_image(@image_source)
      LibRay.unload_image(@image) if @image != @image_source
    end

    def width
      @image.width
    end

    def height
      @image.height
    end

    def copy(resize = true)
      image = Image.new(LibRay.image_copy(@image_source))
      image.resize!(@image.width, @image.height) if resize
      image
    end

    def resize(width : Int32, height : Int32) : Image
      image = copy(resize: false)
      image.resize!(width, height)
      image
    end

    def resize!(width : Int32, height : Int32)
      LibRay.unload_image(@image) if @image.width != @image_source.width || @image.height != @image.height

      @image = LibRay.image_copy(@image_source)
      LibRay.image_resize(pointerof(@image), width, height)
    end

    def to_struct
      @image
    end
  end
end
