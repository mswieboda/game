require "./rectangle"

class Square < Rectangle
  def initialize(x, y, size, color = nil, filled = Shape::FILLED)
    super(
      x: x,
      y: y,
      width: size,
      height: size,
      color: color,
      filled: filled,
    )
  end

  def size
    width
  end
end
