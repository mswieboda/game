require "./shape"

class Polygon < Shape
  property center : LibRay::Vector2
  property sides : Int32
  property radius : Int32 | Float32
  property rotation : Int32 | Float32

  delegate :x, :y, :x=, :y=, to: center

  def initialize(
    center_x = nil,
    center_y = nil,
    radius = nil,

    x = nil,
    y = nil,
    size = nil,

    @sides = 5,
    @rotation = 0,

    color = nil,
    filled = Shape::FILLED
  )
    super(
      color: color,
      filled: filled,
    )

    if center_x && center_y && radius
      @radius = radius
      @center = LibRay::Vector2.new(x: center_x, y: center_y)
    elsif x && y && size
      @radius = (size / 2).to_f32
      @center = LibRay::Vector2.new(x: x + @radius, y: y + @radius)
    else
      @radius = 0
      @center = LibRay::Vector2.new
    end
  end

  def x
    center.x - radius
  end

  def y
    center.y - radius
  end

  def x=(x)
    center.x = x + radius
  end

  def y=(y)
    center.y = y + radius
  end

  def width
    radius * 2
  end

  def height
    width
  end

  def width=(width)
    @radius = (width / 2).to_f32
  end

  def height=(height)
    width = height
  end

  def draw_filled
    LibRay.draw_poly(center, sides, radius, rotation, color.to_struct)
  end

  def draw_outlined
    LibRay.draw_poly_lines(center, sides, radius, rotation, color.to_struct)
  end
end
