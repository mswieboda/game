require "./shape"

class Polygon
  getter center : LibRay::Vector2
  getter sides : Int32
  getter radius : Int32 | Float32
  getter rotation : Int32 | Float32
  getter tint : LibRay::Color
  getter? filled : Bool

  def initialize(x, y, @sides, @radius, @rotation = 0_f32, @tint = Shape::TINT, @filled = true)
    @center = LibRay::Vector2.new(x: x, y: y)
  end

  def draw
    filled? ? draw_filled : draw_outlined
  end

  def draw_filled
    LibRay.draw_poly(center, sides, radius, rotation, tint)
  end

  def draw_outlined
    LibRay.draw_poly_lines(center, sides, radius, rotation, tint)
  end
end
