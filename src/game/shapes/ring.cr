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
    @inner_radius,

    center_x = nil,
    center_y = nil,
    outer_radius = nil,

    x = nil,
    y = nil,
    size = nil,

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

    if center_x && center_y && outer_radius
      @outer_radius = outer_radius
      @center = LibRay::Vector2.new(x: center_x, y: center_y)
    elsif x && y && size
      @outer_radius = (size / 2).to_f32
      @center = LibRay::Vector2.new(x: x + @outer_radius, y: y + @outer_radius)
    else
      @outer_radius = 0
      @center = LibRay::Vector2.new
    end
  end

  def x
    center.x - outer_radius
  end

  def y
    center.y - outer_radius
  end

  def x=(x)
    center.x = x + outer_radius
  end

  def y=(y)
    center.y = y + outer_radius
  end

  def width
    outer_radius * 2
  end

  def height
    width
  end

  def width=(width)
    @outer_radius = (width / 2).to_f32
  end

  def height=(height)
    width = height
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
