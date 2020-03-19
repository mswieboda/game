require "./shape"

class Rectangle < Shape
  property position : LibRay::Vector2
  property width : Int32 | Float32
  property height : Int32 | Float32

  delegate :x, :y, :x=, :y=, to: position

  def initialize(x, y, @width, @height, tint = Shape::TINT, filled = Shape::FILLED)
    super(
      tint: tint,
      filled: filled,
    )

    @position = LibRay::Vector2.new(x: x, y: y)
  end

  def draw_filled
    LibRay.draw_rectangle(x, y, width, height, tint)
  end

  def draw_outlined
    LibRay.draw_rectangle_lines(x, y, width, height, tint)
  end
end
