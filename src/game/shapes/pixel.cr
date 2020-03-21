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

  def width
    1
  end

  def height
    1
  end

  def draw_filled
    LibRay.draw_pixel_v(position, color.to_struct)
  end

  def draw_outlined
    draw_filled
  end
end
