class ShapeEntity < Entity
  property x : Int32 | Float32
  property y : Int32 | Float32
  property width : Int32 | Float32
  property height : Int32 | Float32

  @shape : Shape

  delegate :pause, :start, :restart, to: @shape

  def initialize(@x, @y, @shape, width = nil, height = nil)
    @width = width || @shape.width || 0
    @height = height || @shape.width || 0
  end

  def update(frame_time)
    @shape.update(frame_time)
  end

  def draw(parent_x = 0, parent_y = 0)
    draw_x = parent_x + x
    draw_y = parent_y + y

    if width != @shape.width || height != @shape.height
      draw_x += (width + @shape.width) / 2_f32
      draw_y += (height + @shape.height) / 2_f32
    end

    @shape.draw(draw_x, draw_y)
  end
end
