require "./shape"

class Rectangle < Shape
  property x : Int32 | Float32
  property y : Int32 | Float32
  property width : Int32 | Float32
  property height : Int32 | Float32
  property rotation : Int32 | Float32

  def initialize(@x = 0, @y = 0, @width = 1, @height = 1, @rotation = 0, color = nil, filled = Shape::FILLED)
    super(color: color, filled: filled)
  end

  def draw_filled(parent_x = 0, parent_y = 0)
    LibRay.draw_rectangle_pro(
      rec: LibRay::Rectangle.new(
        x: parent_x + x,
        y: parent_y + y,
        width: width,
        height: height
      ),
      origin: LibRay::Vector2.new,
      rotation: rotation,
      color: color.to_struct
    )
  end

  def draw_outlined(parent_x = 0, parent_y = 0)
    LibRay.draw_rectangle_lines(
      pos_x: parent_x + x,
      pos_y: parent_y + y,
      width: width,
      height: height,
      color: color.to_struct
    )
  end
end
