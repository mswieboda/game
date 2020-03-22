require "./shape"

class Line < Shape
  property start_x : Int32
  property start_y : Int32
  property end_x : Int32
  property end_y : Int32

  def initialize(@end_x, @end_y, @start_x = 0, @start_y = 0, color = nil, filled = Shape::FILLED)
    super(color: color, filled: filled)
  end

  def x
    start_x
  end

  def x=(x)
    @start_x = x
  end

  def y
    start_y
  end

  def y=(y)
    @start_y = y
  end

  def width
    end_x - start_x
  end

  def height
    end_y - start_y
  end

  def width=(width)
    @end_x = start_x + width
  end

  def height=(height)
    @end_y = start_y + height
  end

  def draw_filled(parent_x = 0, parent_y = 0)
    LibRay.draw_line_v(
      start_pos: LibRay::Vector2.new(
        x: parent_x + start_x,
        y: parent_y + start_y
      ),
      end_pos: LibRay::Vector2.new(
        x: parent_x + end_x,
        y: parent_y + end_y
      ),
      color: color.to_struct
    )
  end

  def draw_outlined(parent_x = 0, parent_y = 0)
    draw_filled(parent_x, parent_y)
  end
end
