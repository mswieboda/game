require "./shape"

class Pixel < Shape
  property position : LibRay::Vector2

  delegate :x, :x=, :y, :y=, to: position

  def initialize(x, y, tint = Shape::TINT, filled = Shape::FILLED)
    super(
      tint: tint,
      filled: filled,
    )

    @position = LibRay::Vector2.new(x: x, y: y)
  end

  def draw_filled
    LibRay.draw_pixel_v(position, tint)
  end
end
