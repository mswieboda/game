require "./shape"

class Pixel
  getter position : LibRay::Vector2
  getter tint : LibRay::Color

  delegate :x, :y, to: position

  def initialize(x, y, @tint = Shape::TINT)
    @position = LibRay::Vector2.new(x: x, y: y)
  end

  def draw(_parent_x = 0, _parent_y = 0)
    LibRay.draw_pixel_v(position, tint)
  end
end
