class Shape
  getter position : LibRay::Vector2
  getter width : Int32 | Float32
  getter height : Int32 | Float32
  getter tint : LibRay::Color

  delegate :x, :y, to: position

  TINT = LibRay::RED

  def initialize(x, y, @width, @height, @tint = TINT)
    @position = LibRay::Vector2.new(x: x, y: y)
  end

  def collision?(other : Shape)
    x < other.x &&
      x + width > other.x &&
      y < other.y &&
      y + height > other.y
  end

  def update(_frame_time)
  end

  def draw(_parent_x = 0, _parent_y = 0)
  end
end
