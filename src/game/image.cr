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

    def to_struct
      @image
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

    def flip_horizontal!
      LibRay.image_flip_horizontal(pointerof(@image))
    end

    def flip_horizontal
      image = copy
      image.flip_horizontal!
      image
    end

    def flip_vertical!
      LibRay.image_flip_vertical(pointerof(@image))
    end

    def flip_vertical
      image = copy
      image.flip_vertical!
      image
    end

    def self.from_text(text : String, font_size : Float32, spacing : Float32, color : Color, font = Font.default)
      Image.new(LibRay.image_text_ex(font.to_struct, text, font_size, spacing, color.to_struct))
    end

    def self.from_size(width : Int32, height : Int32, color = Color::Transparent)
      Image.new(LibRay.gen_image_color(width, height, color.to_struct))
    end

    def draw(image : Image, x, y, centered = false, tint = Color::White)
      LibRay.image_draw(
        dst: pointerof(@image),
        src: image.to_struct,
        src_rec: LibRay::Rectangle.new(
          x: 0,
          y: 0,
          width: image.width,
          height: image.height
        ),
        dst_rec: LibRay::Rectangle.new(
          x: centered ? x - image.width / 2_f32 : x,
          y: centered ? y - image.height / 2_f32 : y,
          width: image.width,
          height: image.height
        ),
        tint: tint.to_struct
      )
    end

    def draw(text : Text)
      LibRay.image_draw_text_ex(
        dst: pointerof(@image),
        position: LibRay::Vector2.new(
          x: text.x,
          y: text.y
        ),
        font: text.font.to_struct,
        text: text.text,
        font_size: text.size,
        spacing: text.spacing,
        color: text.color.to_struct
      )
    end
  end
end
