require "./shape"

class Circle
  getter center : LibRay::Vector2
  getter radius : Int32 | Float32
  getter tint : LibRay::Color

  def initialize(x, y, @radius, @tint = Shape::TINT)
    @center = LibRay::Vector2.new(x: x, y: y)
  end

  def draw(_parent_x = 0, _parent_y = 0)
    LibRay.draw_circle_v(
      center: center,
      radius: radius,
      color: tint
    )
  end
end
