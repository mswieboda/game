require "./shape"

class Ellipse < Shape
  property center : LibRay::Vector2
  property horizontal_radius : Int32 | Float32
  property vertical_radius : Int32 | Float32

  def initialize(
    center_x = nil,
    center_y = nil,
    horizontal_radius = nil,
    vertical_radius = nil,

    x = nil,
    y = nil,
    width = nil,
    height = nil,

    color = nil,
    filled = Shape::FILLED
  )
    super(
      color: color,
      filled: filled,
    )

    if center_x && center_y && horizontal_radius && vertical_radius
      @horizontal_radius = horizontal_radius
      @vertical_radius = vertical_radius
      @center = LibRay::Vector2.new(x: center_x, y: center_y)
    elsif x && y && width && height
      @horizontal_radius = (width / 2).to_f32
      @vertical_radius = (height / 2).to_f32
      @center = LibRay::Vector2.new(x: x + @horizontal_radius, y: y + @vertical_radius)
    else
      @horizontal_radius = 0
      @vertical_radius = 0
      @center = LibRay::Vector2.new
    end
  end

  def x
    center.x - horizontal_radius
  end

  def y
    center.y - vertical_radius
  end

  def x=(x)
    center.x = x + horizontal_radius
  end

  def y=(y)
    center.y = y + vertical_radius
  end

  def width
    horizontal_radius * 2
  end

  def height
    vertical_radius * 2
  end

  def width=(width)
    @horizontal_radius = (width / 2).to_f32
  end

  def height=(height)
    @vertical_radius = (height / 2).to_f32
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
