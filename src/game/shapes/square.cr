module Game
  class Square < Rectangle
    def initialize(x = 0, y = 0, size = 1, color = nil, filled = Shape::FILLED)
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
end
