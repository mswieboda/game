class Game::SpriteEntity < Game::Entity
  property x : Int32 | Float32
  property y : Int32 | Float32
  property width : Int32 | Float32
  property height : Int32 | Float32
  property rotation : Int32 | Float32

  delegate :pause, :start, :restart, to: @sprite

  def initialize(@x, @y, sprite_name, width = nil, height = nil, @rotation = 0)
    @sprite = Sprite.get(sprite_name)
    @width = width || @sprite.width
    @height = height || @sprite.width
  end

  def update(frame_time)
    @sprite.update(frame_time)
  end

  def draw(parent_x = 0, parent_y = 0)
    draw_x = parent_x + x
    draw_y = parent_y + y

    if width != @sprite.width || height != @sprite.height
      draw_x += (width + @sprite.width) / 2_f32
      draw_y += (height + @sprite.height) / 2_f32
    end

    @sprite.draw(draw_x, draw_y, rotation)
  end
end
