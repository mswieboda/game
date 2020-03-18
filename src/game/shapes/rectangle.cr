require "./shape"

class Rectangle
  getter position : LibRay::Vector2
  getter width : Int32 | Float32
  getter height : Int32 | Float32
  getter tint : LibRay::Color
  getter? filled : Bool

  delegate :x, :y, to: position

  def initialize(x, y, @width, @height, @tint = Shape::TINT, @filled = true)
    @position = LibRay::Vector2.new(x: x, y: y)
  end

  def draw
    filled? ? draw_filled : draw_outlined
  end

  def draw_filled
    LibRay.draw_rectangle(x, y, width, height, tint)
  end

  def draw_outlined
    LibRay.draw_rectangle_lines(x, y, width, height, tint)
  end
end
