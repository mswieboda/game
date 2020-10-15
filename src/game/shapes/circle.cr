require "./ellipse"

module Game
  class Circle < Ellipse
    def initialize(
      center_x = nil,
      center_y = nil,
      radius = nil,

      x = nil,
      y = nil,
      size = nil,

      color = nil,
      filled = Shape::FILLED
    )
      super(
        center_x: center_x,
        center_y: center_y,
        horizontal_radius: radius,
        vertical_radius: radius,

        x: x,
        y: y,
        width: size,
        height: size,

        color: color,
        filled: filled,
      )
    end

    def radius
      horizontal_radius
    end
  end
end
