require "./shape"

class Pixel < Shape
  property position : LibRay::Vector2

  delegate :x, :x=, :y, :y=, to: position

  def initialize(x, y, color = nil, filled = Shape::FILLED)
    super(
      color: color,
      filled: filled,
    )

    @position = LibRay::Vector2.new(x: x, y: y)
  end

  def draw_filled
    LibRay.draw_pixel_v(position, color.to_struct)
  end

  def draw_outlined
    LibRay.draw_rectangle_lines(x - 1, y - 1, 3, 3, color.to_struct)
  end
end
