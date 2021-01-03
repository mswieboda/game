class Game::Text
  property text : String
  property font : Font
  property x : Int32 | Float32 | Float64
  property y : Int32 | Float32 | Float64
  property size : Int32 | Float32
  property spacing : Int32 | Float32
  property color : Color
  getter width : Int32 | Float32
  getter height : Int32 | Float32

  def initialize(@text, @font = Font.default, @x = 0, @y = 0, @size = 16, @spacing = 1, @color = Color::Red)
    @width = 0
    @height = 0

    measure
  end

  def measure
    measure = LibRay.measure_text_ex(
      font: LibRay.get_font_default,
      text: text,
      font_size: size.to_f32,
      spacing: spacing.to_f32
    )

    @width = measure.x
    @height = measure.y
  end

  def font=(font : Font)
    @font = font
    measure
  end

  def size=(size : Int32)
    @size = size
    measure
  end

  def spacing=(spacing : Int32 | Float32)
    @spacing = spacing
    measure
  end

  def draw
    LibRay.draw_text_ex(
      font: font.to_struct,
      text: text,
      position: LibRay::Vector2.new(
        x: x,
        y: y
      ),
      font_size: size,
      spacing: spacing,
      tint: color.to_struct
    )
  end

  def draw(image : Image)
    LibRay.image_draw_text_ex(
      image.to_struct,
      position: LibRay::Vector2.new(
        x: x,
        y: y
      ),
      font: font.to_struct,
      text: text,
      font_size: size,
      spacing: spacing,
      color: color.to_struct
    )
  end
end
