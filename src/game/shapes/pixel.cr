require "./shape"

class Pixel < Shape
  property x : Int32 | Float32
  property y : Int32 | Float32

  def initialize(@x, @y, color = nil, filled = Shape::FILLED)
    super(color: color, filled: filled)
  end

  def width
    1
  end

  def height
    1
  end

  def draw_filled(parent_x = 0, parent_y = 0)
    LibRay.draw_pixel_v(
      position: LibRay::Vector2.new(
        x: parent_x + x,
        y: parent_y + y,
      ),
      color: color.to_struct
    )
  end

  def draw_outlined(parent_x = 0, parent_y = 0)
    draw_filled(parent_x, parent_y)
  end
end
