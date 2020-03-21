require "./shape"

class Triangle < Shape
  property v1, v2, v3 : LibRay::Vector2

  def initialize(x1, y1, x2, y2, x3, y3, color = nil, filled = Shape::FILLED)
    super(
      color: color,
      filled: filled,
    )

    @v1 = LibRay::Vector2.new(x: x1, y: y1)
    @v2 = LibRay::Vector2.new(x: x2, y: y2)
    @v3 = LibRay::Vector2.new(x: x3, y: y3)
  end

  def x
    [v1.x, v2.x, v3.x].min
  end

  # TODO:
  def x=(x)
  end

  def y
    [v1.y, v2.y, v3.y].min
  end

  # TODO:
  def y=(y)
  end

  def width
    max_x = [v1.x, v2.x, v3.x].max

    max_x - x
  end

  # TODO:
  def width=(width)
  end

  def height
    max_y = [v1.y, v2.y, v3.y].max

    max_y - y
  end

  # TODO:
  def height=(height)
  end

  def draw
    filled? ? draw_filled : draw_outlined
  end

  def draw_filled
    LibRay.draw_triangle(v3, v2, v1, color.to_struct)
  end

  def draw_outlined
    LibRay.draw_triangle_lines(v3, v2, v1, color.to_struct)
  end
end
