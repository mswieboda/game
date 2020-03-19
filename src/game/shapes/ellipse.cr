require "./shape"

class Ellipse
  getter center : LibRay::Vector2
  getter horizontal_radius : Int32 | Float32
  getter vertical_radius : Int32 | Float32
  getter tint : LibRay::Color
  getter? filled : Bool

  def initialize(x, y, @horizontal_radius, @vertical_radius, @tint = Shape::TINT, @filled = true)
    @center = LibRay::Vector2.new(x: x, y: y)
  end

  def draw
    filled? ? draw_filled : draw_outlined
  end

  def draw_filled
    LibRay.draw_ellipse(
      center_x: center.x,
      center_y: center.y,
      radius_h: horizontal_radius,
      radius_v: vertical_radius,
      color: tint
    )
  end

  def draw_outlined
    LibRay.draw_ellipse_lines(
      center_x: center.x,
      center_y: center.y,
      radius_h: horizontal_radius,
      radius_v: vertical_radius,
      color: tint
    )
  end
end
