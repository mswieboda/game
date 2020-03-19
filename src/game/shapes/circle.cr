require "./shape"

class Circle < Shape
  property center : LibRay::Vector2
  property radius : Int32 | Float32

  delegate :x, :y, :x=, :y=, to: center

  def initialize(x, y, @radius, tint = Shape::TINT, filled = Shape::FILLED)
    super(
      tint: tint,
      filled: filled,
    )

    @center = LibRay::Vector2.new(x: x, y: y)
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
