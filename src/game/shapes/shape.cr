class Shape
  property color : Color
  property? filled : Bool

  FILLED = true

  def initialize(color, @filled = FILLED)
    @color = color || Color::Red
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
