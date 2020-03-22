require "./shape"

class Ellipse < Shape
  property center_x : Int32 | Float32
  property center_y : Int32 | Float32
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

    @horizontal_radius = horizontal_radius || (width && (width / 2).to_f32) || 1
    @vertical_radius = vertical_radius || (height && (height / 2).to_f32) || 1

    if center_x && center_y
      @center_x = center_x
      @center_y = center_y
    elsif x && y
      @center_x = x + @horizontal_radius
      @center_y = y + @vertical_radius
    else
      @center_x = 0
      @center_y = 0
    end
  end

  def x
    center_x - horizontal_radius
  end

  def y
    center_y - vertical_radius
  end

  def x=(x)
    center_x = x + horizontal_radius
  end

  def y=(y)
    center_y = y + vertical_radius
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

  def draw_filled(parent_x = 0, parent_y = 0)
    LibRay.draw_ellipse(
      center_x: parent_x + center_x,
      center_y: parent_y + center_y,
      radius_h: horizontal_radius,
      radius_v: vertical_radius,
      color: color.to_struct
    )
  end

  def draw_outlined(parent_x = 0, parent_y = 0)
    LibRay.draw_ellipse_lines(
      center_x: parent_x + center_x,
      center_y: parent_y + center_y,
      radius_h: horizontal_radius,
      radius_v: vertical_radius,
      color: color.to_struct
    )
  end
end
