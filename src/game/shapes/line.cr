module Game
  class Line < Shape
    property start_x : Int32 | Float32
    property start_y : Int32 | Float32
    property end_x : Int32 | Float32
    property end_y : Int32 | Float32
    property thickness : Int32 | Float32

    @rectangle : Rectangle?

    DEFAULT_THICKNESS = 1

    def initialize(@end_x, @end_y, @start_x = 0, @start_y = 0, color = nil, @thickness = DEFAULT_THICKNESS, filled = Shape::FILLED)
      super(color: color, filled: filled)

      @rectangle = nil
    end

    # setters
    {% for name in [:start_x, :start_y, :end_x, :end_y, :color, :thickness] %}
      def {{name.id}}=(value : Int32 | Float32)
        @{{name.id}} = value
        @rectangle = nil
      end
    {% end %}

    # TODO: needs to be reworked since start x,y isn't always top left
    def x
      start_x
    end

    def x=(x)
      @start_x = x
    end

    # TODO: needs to be reworked since start x,y isn't always top left
    def y
      start_y
    end

    def y=(y)
      @start_y = y
    end

    def width
      (end_x - start_x).abs
    end

    def height
      (end_y - start_y).abs
    end

    def width=(width)
      @end_x = start_x + width
    end

    def height=(height)
      @end_y = start_y + height
    end

    def rectangle
      if rectangle = @rectangle
        return rectangle
      end

      p1x = [start_x, end_x].min
      p1y = p1x == start_x ? start_y : end_y

      p2x = p1x == start_x ? end_x : start_x
      p2y = p1y == start_y ? end_y : start_y

      dx = p2x - p1x
      dy = p2y - p1y
      theta = Math.atan(dx / dy)

      radius = @thickness / 2

      x = p1x + radius * Math.cos(theta) + (dy.sign < 0 ? dx : 0)
      y = p1y - radius * Math.sin(theta) + (dy.sign < 0 ? dy : 0)

      width = Math.sqrt(dx ** 2 + dy ** 2)

      rectangle = Rectangle.new(
        x: x.to_f32,
        y: y.to_f32,
        width: width.to_f32,
        height: @thickness,
        rotation: (90 - Game.to_degrees(theta)).to_f32,
        color: color,
      )

      @rectangle = rectangle

      rectangle
    end

    def draw_line(parent_x = 0, parent_y = 0)
      LibRay.draw_line_v(
        start_pos: LibRay::Vector2.new(
          x: parent_x + start_x,
          y: parent_y + start_y
        ),
        end_pos: LibRay::Vector2.new(
          x: parent_x + end_x,
          y: parent_y + end_y
        ),
        color: color.to_struct
      )
    end

    def draw_filled(parent_x = 0, parent_y = 0)
      thickness > 0 ? rectangle.draw(parent_x, parent_y) : draw_line(parent_x, parent_y)
    end

    def draw_outlined(parent_x = 0, parent_y = 0)
      draw_filled(parent_x, parent_y)
    end
  end
end
