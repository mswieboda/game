require "./shape"

class Line < Shape
  property start_position : LibRay::Vector2
  property end_position : LibRay::Vector2

  def initialize(start_x, start_y, end_x, end_y, color = nil, filled = Shape::FILLED)
    super(
      color: color,
      filled: filled,
    )

    @start_position = LibRay::Vector2.new(x: start_x, y: start_y)
    @end_position = LibRay::Vector2.new(x: end_x, y: end_y)
  end

  def draw_filled
    LibRay.draw_line_v(
      start_pos: start_position,
      end_pos: end_position,
      color: color.to_struct
    )
  end
end
