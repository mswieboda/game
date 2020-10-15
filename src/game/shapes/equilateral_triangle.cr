require "./polygon"

module Game
  class EquilateralTriangle < Polygon
    def initialize(
      center_x = nil,
      center_y = nil,
      radius = nil,

      x = nil,
      y = nil,
      size = nil,

      @rotation = 0,

      color = nil,
      filled = Shape::FILLED
    )
      super(
        center_x: center_x,
        center_y: center_y,
        radius: radius,

        x: x,
        y: y,
        size: size,

        sides: 3,
        rotation: rotation,

        color: color,
        filled: filled,
      )
    end
  end
end
