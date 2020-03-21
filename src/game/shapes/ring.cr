require "./shape"

class Ring < Shape
  property center : LibRay::Vector2
  property inner_radius : Int32 | Float32
  property outer_radius : Int32 | Float32
  property start_angle : Int32 | Float32
  property end_angle : Int32 | Float32
  property segments : Int32

  delegate :x, :y, :x=, :y=, to: center

  def initialize(
    x,
    y,
    @inner_radius,
    @outer_radius,
    @start_angle = 0,
    @end_angle = 360,
    @segments = 0,
    color = nil,
    filled = Shape::FILLED
  )
    super(
      color: color,
      filled: filled,
    )

    @center = LibRay::Vector2.new(x: x, y: y)
  end

  def draw_filled
    LibRay.draw_ring(
      center: center,
      inner_radius: inner_radius,
      outer_radius: outer_radius,
      start_angle: start_angle,
      end_angle: end_angle,
      segments: segments,
      color: color.to_struct
    )
  end

  def draw_outlined
    LibRay.draw_ring_lines(
      center: center,
      inner_radius: inner_radius,
      outer_radius: outer_radius,
      start_angle: start_angle,
      end_angle: end_angle,
      segments: segments,
      color: color.to_struct
    )
  end
end
