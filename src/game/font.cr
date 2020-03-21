class Font
  property font : LibRay::Font

  def initialize
    @font = LibRay::Font.new
    @font = Font.default_font
  end

  def initialize(filename : String)
    @font = LibRay::Font.new
    load(filename)
  end

  def self.default_font
    @@default_font = LibRay.get_font_default
  end

  def self.default
    @@default = Font.new
  end

  def load(filename : String) : LibRay::Font
    @font = LibRay.load_font(filename)
  end

  def unload
    LibRay.unload_font(font)
  end

  def to_struct
    font
  end
end
