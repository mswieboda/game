require "./shape"

class Ring
  getter center : LibRay::Vector2
  getter inner_radius : Int32 | Float32
  getter outer_radius : Int32 | Float32
  getter start_angle : Int32 | Float32
  getter end_angle : Int32 | Float32
  getter segments : Int32
  getter tint : LibRay::Color
  getter? filled : Bool

  def initialize(
    x,
    y,
    @inner_radius,
    @outer_radius,
    @start_angle = 0,
    @end_angle = 360,
    @segments = 0,
    @tint = Shape::TINT,
    @filled = true
  )
    @center = LibRay::Vector2.new(x: x, y: y)
  end

  def draw
    filled? ? draw_filled : draw_outlined
  end

  def draw_filled
    LibRay.draw_ring(
      center: center,
      inner_radius: inner_radius,
      outer_radius: outer_radius,
      start_angle: start_angle,
      end_angle: end_angle,
      segments: segments,
      color: tint
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
      color: tint
    )
  end
end
