class Game::ShapeEntity < Game::Entity
  property x : Int32 | Float32
  property y : Int32 | Float32
  property shape : ::Game::Shape

  delegate :width, :height, to: shape

  def initialize(@x, @y, @shape)
  end

  def update(frame_time)
    shape.update(frame_time)
  end

  def draw(parent_x = 0, parent_y = 0)
    shape.draw(parent_x + x, parent_y + y)
  end
end
