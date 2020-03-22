require "./shape"

class Polygon < Shape
  property center_x : Int32 | Float32
  property center_y : Int32 | Float32
  property sides : Int32
  property radius : Int32 | Float32
  property rotation : Int32 | Float32

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

    @radius = radius || (size && (size / 2).to_f32) || 1

    if center_x && center_y
      @center_x = center_x
      @center_y = center_y
    elsif x && y
      @center_x = x + @radius
      @center_y = y + @radius
    else
      @center_x = 0
      @center_y = 0
    end
  end

  def x
    center_x - radius
  end

  def y
    center_y - radius
  end

  def x=(x)
    center_x = x + radius
  end

  def y=(y)
    center_y = y + radius
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

  def draw_filled(parent_x = 0, parent_y = 0)
    LibRay.draw_poly(
      center: LibRay::Vector2.new(
        x: parent_x + center_x,
        y: parent_y + center_y
      ),
      sides: sides,
      radius: radius,
      rotation: rotation,
      color: color.to_struct
    )
  end

  def draw_outlined(parent_x = 0, parent_y = 0)
    LibRay.draw_poly_lines(
      center: LibRay::Vector2.new(
        x: parent_x + center_x,
        y: parent_y + center_y
      ),
      sides: sides,
      radius: radius,
      rotation: rotation,
      color: color.to_struct
    )
  end
end
