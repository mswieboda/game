class Shape
  property color : Color
  property? filled : Bool

  FILLED = true

  def initialize(color, @filled = FILLED)
    @color = color || Color::Red
  end

  def x
  end

  def y
  end

  def x=(_x)
  end

  def y=(_y)
  end

  def width
  end

  def height
  end

  def width=(_width)
  end

  def height=(_height)
  end

  def update(_frame_time)
  end

  def draw
    filled? ? draw_filled : draw_outlined
  end

  def draw_filled
  end

  def draw_outlined
  end
end
