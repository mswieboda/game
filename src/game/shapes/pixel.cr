require "./shape"

class Pixel < Shape
  def initialize(x, y, @tint = Shape::TINT)
    @position = LibRay::Vector2.new(x: x, y: y)
    @width = 1
    @height = 1
  end

  def draw(_parent_x = 0, _parent_y = 0)
    LibRay.draw_pixel(x, y, tint)
  end
end
