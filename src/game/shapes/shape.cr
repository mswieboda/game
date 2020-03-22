abstract class Shape
  property color : Color
  property? filled : Bool

  FILLED = true

  def initialize(color, @filled = FILLED)
    @color = color || Color::Red
  end

  def x
    0
  end

  def y
    0
  end

  def x=(_x)
  end

  def y=(_y)
  end

  def width
    0
  end

  def height
    0
  end

  def width=(_width)
  end

  def height=(_height)
  end

  def update(_frame_time)
  end

  def draw(parent_x = 0, parent_y = 0)
    filled? ? draw_filled(parent_x, parent_y) : draw_outlined(parent_x, parent_y)
  end

  def draw_filled(parent_x = 0, parent_y = 0)
  end

  def draw_outlined(parent_x = 0, parent_y = 0)
  end
end
