class Shape
  property tint : LibRay::Color
  property? filled : Bool

  TINT   = LibRay::RED
  FILLED = true

  def initialize(@tint = TINT, @filled = FILLED)
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
