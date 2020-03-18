require "./shape"

class Triangle
  getter v1, v2, v3 : LibRay::Vector2
  getter tint : LibRay::Color
  getter? filled : Bool

  def initialize(x1, y1, x2, y2, x3, y3, @tint = Shape::TINT, @filled = true)
    @v1 = LibRay::Vector2.new(x: x1, y: y1)
    @v2 = LibRay::Vector2.new(x: x2, y: y2)
    @v3 = LibRay::Vector2.new(x: x3, y: y3)
  end

  def draw
    filled? ? draw_filled : draw_outlined
  end

  def draw_filled
    LibRay.draw_triangle(v3, v2, v1, tint)
  end

  def draw_outlined
    LibRay.draw_triangle_lines(v3, v2, v1, tint)
  end
end
