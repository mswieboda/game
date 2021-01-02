module Game
  class RoundedRectangle < Shape
    property x : Int32 | Float32
    property y : Int32 | Float32
    property width : Int32 | Float32
    property height : Int32 | Float32
    property roundness : Int32 | Float32
    property segments : Int32
    property thickness : Int32

    def initialize(@x = 0, @y = 0, @width = 1, @height = 1, @roundness = 10, @segments = 10, @thickness = 1, color = nil, filled = Shape::FILLED)
      super(color: color, filled: filled)
    end

    def draw_filled(parent_x = 0, parent_y = 0)
      LibRay.draw_rectangle_rounded(
        rec: LibRay::Rectangle.new(
          x: parent_x + x,
          y: parent_y + y,
          width: width,
          height: height
        ),
        roundness: roundness,
        segments: segments,
        color: color.to_struct
      )
    end

    def draw_outlined(parent_x = 0, parent_y = 0)
      LibRay.draw_rectangle_rounded_lines(
        rec: LibRay::Rectangle.new(
          x: parent_x + x,
          y: parent_y + y,
          width: width,
          height: height
        ),
        roundness: roundness,
        segments: segments,
        line_thick: thickness,
        color: color.to_struct
      )
    end
  end
end
