require "./shape"

class Circle
  getter center : LibRay::Vector2
  getter radius : Int32 | Float32
  getter tint : LibRay::Color
  getter? filled : Bool

  def initialize(x, y, @radius, @tint = Shape::TINT, @filled = true)
    @center = LibRay::Vector2.new(x: x, y: y)
  end

  def draw
    filled? ? draw_filled : draw_outlined
  end

  def draw_filled
    LibRay.draw_circle_v(
      center: center,
      radius: radius,
      color: tint
    )
  end

  def draw_outlined
    LibRay.draw_circle_lines(
      center_x: center.x,
      center_y: center.y,
      radius: radius,
      color: tint
    )
  end
end
