require "./shape"

class Polygon < Shape
  property center : LibRay::Vector2
  property sides : Int32
  property radius : Int32 | Float32
  property rotation : Int32 | Float32

  delegate :x, :y, :x=, :y=, to: center

  def initialize(x, y, @sides, @radius, @rotation = 0_f32, color = nil, filled = Shape::FILLED)
    super(
      color: color,
      filled: filled,
    )

    @center = LibRay::Vector2.new(x: x, y: y)
  end

  def draw_filled
    LibRay.draw_poly(center, sides, radius, rotation, color.to_struct)
  end

  def draw_outlined
    LibRay.draw_poly_lines(center, sides, radius, rotation, color.to_struct)
  end
end
