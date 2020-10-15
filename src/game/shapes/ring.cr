module Game
  class Ring < Shape
    property center_x : Int32 | Float32
    property center_y : Int32 | Float32
    property inner_radius : Int32 | Float32
    property outer_radius : Int32 | Float32
    property start_angle : Int32 | Float32
    property end_angle : Int32 | Float32
    property segments : Int32

    def initialize(
      center_x = nil,
      center_y = nil,
      outer_radius = nil,

      x = nil,
      y = nil,
      size = nil,

      @inner_radius = 0,
      @start_angle = 0,
      @end_angle = 360,
      @segments = 0,

      color = nil,
      filled = Shape::FILLED
    )
      super(
        color: color,
        filled: filled,
      )

      @outer_radius = outer_radius || (size && (size / 2).to_f32) || 1

      if center_x && center_y
        @center_x = center_x
        @center_y = center_y
      elsif x && y
        @center_x = x + @outer_radius
        @center_y = y + @outer_radius
      else
        @center_x = 0
        @center_y = 0
      end
    end

    def x
      center_x - outer_radius
    end

    def y
      center_y - outer_radius
    end

    def x=(x)
      center_x = x + outer_radius
    end

    def y=(y)
      center_y = y + outer_radius
    end

    def width
      outer_radius * 2
    end

    def height
      width
    end

    def width=(width)
      @outer_radius = (width / 2).to_f32
    end

    def height=(height)
      width = height
    end

    def draw_filled(parent_x = 0, parent_y = 0)
      LibRay.draw_ring(
        center: LibRay::Vector2.new(
          x: parent_x + center_x,
          y: parent_y + center_y
        ),
        inner_radius: inner_radius,
        outer_radius: outer_radius,
        start_angle: start_angle,
        end_angle: end_angle,
        segments: segments,
        color: color.to_struct
      )
    end

    def draw_outlined(parent_x = 0, parent_y = 0)
      LibRay.draw_ring_lines(
        center: LibRay::Vector2.new(
          x: parent_x + center_x,
          y: parent_y + center_y
        ),
        inner_radius: inner_radius,
        outer_radius: outer_radius,
        start_angle: start_angle,
        end_angle: end_angle,
        segments: segments,
        color: color.to_struct
      )
    end
  end
end
