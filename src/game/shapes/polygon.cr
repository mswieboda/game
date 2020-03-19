require "./shape"

class Polygon < Shape
  property center : LibRay::Vector2
  property sides : Int32
  property radius : Int32 | Float32
  property rotation : Int32 | Float32

  delegate :x, :y, :x=, :y=, to: center

  def initialize(x, y, @sides, @radius, @rotation = 0_f32, tint = Shape::TINT, filled = Shape::FILLED)
    super(
      tint: tint,
      filled: filled,
    )

    @center = LibRay::Vector2.new(x: x, y: y)
  end

  def draw_filled
    LibRay.draw_poly(center, sides, radius, rotation, tint)
  end

  def draw_outlined
    LibRay.draw_poly_lines(center, sides, radius, rotation, tint)
  end
end
