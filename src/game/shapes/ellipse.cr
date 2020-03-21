require "./shape"

class Ellipse < Shape
  property center : LibRay::Vector2
  property horizontal_radius : Int32 | Float32
  property vertical_radius : Int32 | Float32

  delegate :x, :y, :x=, :y=, to: center

  def initialize(x, y, @horizontal_radius, @vertical_radius, color = nil, filled = Shape::FILLED)
    super(
      color: color,
      filled: filled,
    )

    @center = LibRay::Vector2.new(x: x, y: y)
  end

  def draw_filled
    LibRay.draw_ellipse(
      center_x: center.x,
      center_y: center.y,
      radius_h: horizontal_radius,
      radius_v: vertical_radius,
      color: color.to_struct
    )
  end

  def draw_outlined
    LibRay.draw_ellipse_lines(
      center_x: center.x,
      center_y: center.y,
      radius_h: horizontal_radius,
      radius_v: vertical_radius,
      color: color.to_struct
    )
  end
end
