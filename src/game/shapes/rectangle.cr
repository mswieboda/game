require "./shape"

class Rectangle < Shape
  def draw(_parent_x = 0, _parent_y = 0)
    LibRay.draw_rectangle(x, y, width, height, tint)
  end
end
