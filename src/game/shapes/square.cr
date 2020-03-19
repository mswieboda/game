require "./rectangle"

class Square < Rectangle
  def initialize(x, y, size, tint = Shape::TINT, filled = Shape::FILLED)
    super(
      x: x,
      y: y,
      width: size,
      height: size,
      tint: tint,
      filled: filled,
    )
  end

  def size
    width
  end

  def draw_filled
    LibRay.draw_rectangle(x, y, width, height, tint)
  end

  def draw_outlined
    LibRay.draw_rectangle_lines(x, y, width, height, tint)
  end
end
