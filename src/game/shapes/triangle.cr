require "./shape"

class Triangle < Shape
  property x1 : Int32 | Float32
  property x2 : Int32 | Float32
  property x3 : Int32 | Float32
  property y1 : Int32 | Float32
  property y2 : Int32 | Float32
  property y3 : Int32 | Float32

  def initialize(@x1, @y1, @x2, @y2, @x3, @y3, color = nil, filled = Shape::FILLED)
    super(color: color, filled: filled)
  end

  def x
    [x1, x2, x3].min
  end

  # TODO:
  def x=(x)
  end

  def y
    [y1, y2, y3].min
  end

  # TODO:
  def y=(y)
  end

  def width
    max_x = [x1, x2, x3].max

    max_x - x
  end

  # TODO:
  def width=(width)
  end

  def height
    max_y = [y1, y2, y3].max

    max_y - y
  end

  # TODO:
  def height=(height)
  end

  def draw
    filled? ? draw_filled : draw_outlined
  end

  def draw_filled(parent_x = 0, parent_y = 0)
    LibRay.draw_triangle(
      v1: LibRay::Vector2.new(
        x: parent_x + x3,
        y: parent_y + y3,
      ),
      v2: LibRay::Vector2.new(
        x: parent_x + x2,
        y: parent_y + y2
      ),
      v3: LibRay::Vector2.new(
        x: parent_x + x1,
        y: parent_y + y1
      ),
      color: color.to_struct
    )
  end

  def draw_outlined(parent_x = 0, parent_y = 0)
    LibRay.draw_triangle_lines(
      v1: LibRay::Vector2.new(
        x: parent_x + x3,
        y: parent_y + y3,
      ),
      v2: LibRay::Vector2.new(
        x: parent_x + x2,
        y: parent_y + y2
      ),
      v3: LibRay::Vector2.new(
        x: parent_x + x1,
        y: parent_y + y1
      ),
      color: color.to_struct
    )
  end
end
