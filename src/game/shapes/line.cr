require "./shape"

class Line
  getter start_position : LibRay::Vector2
  getter end_position : LibRay::Vector2
  getter tint : LibRay::Color

  def initialize(start_x, start_y, end_x, end_y, @tint = Shape::TINT)
    @start_position = LibRay::Vector2.new(x: start_x, y: start_y)
    @end_position = LibRay::Vector2.new(x: end_x, y: end_y)
  end

  def draw(_parent_x = 0, _parent_y = 0)
    LibRay.draw_line_v(
      start_pos: start_position,
      end_pos: end_position,
      color: tint
    )
  end
end
