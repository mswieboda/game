require "../src/game"

# This example will automatically scale with the window.

class ShapesExample < Game
  SPEED = 150

  def initialize
    super(name: "Shapes Example")

    @shapes = [] of Shape

    @shapes << Pixel.new(x: 50, y: 125)
    @shapes << Pixel.new(x: 55, y: 130)
    @shapes << Pixel.new(x: 60, y: 125)
    @shapes << Pixel.new(x: 50, y: 135)
    @shapes << Pixel.new(x: 60, y: 135)

    @shapes << Line.new(start_x: 100, start_y: 125, end_x: 110, end_y: 135)
    @shapes << Line.new(start_x: 100, start_y: 135, end_x: 110, end_y: 125)

    @shapes << Circle.new(x: 175, y: 100, size: 50, filled: false)
    @shapes << Circle.new(center_x: 200, center_y: 125, radius: 20)

    @shapes << Triangle.new(x1: 275, y1: 160, x2: 300, y2: 100, x3: 325, y3: 160, filled: false)
    @shapes << Triangle.new(x1: 280, y1: 155, x2: 300, y2: 110, x3: 320, y3: 155)

    @shapes << Polygon.new(center_x: 400, center_y: 130, sides: 5, radius: 25, filled: false)
    @shapes << Polygon.new(center_x: 400, center_y: 130, sides: 5, radius: 20)

    @shapes << Ellipse.new(x: 450, y: 70, width: 50, height: 120, filled: false)
    @shapes << Ellipse.new(center_x: 475, center_y: 130, horizontal_radius: 20, vertical_radius: 55)

    @shapes << Ring.new(x: 525, y: 105, inner_radius: 5, size: 50, filled: false)
    @shapes << Ring.new(center_x: 550, center_y: 130, inner_radius: 10, outer_radius: 20)

    @shapes << Rectangle.new(x: 600, y: 100, width: 20, height: 50, filled: false)
    @shapes << Rectangle.new(x: 605, y: 105, width: 10, height: 40)

    @shapes << Rectangle.new(x: 500, y: 500, width: 30, height: 50, rotation: 50)

    @shapes << Square.new(x: 650, y: 100, size: 50, filled: false)
    @shapes << Square.new(x: 655, y: 105, size: 40)

    @shapes << EquilateralTriangle.new(x: 725, y: 100, size: 50, filled: false)
    @shapes << EquilateralTriangle.new(center_x: 750, center_y: 125, radius: 20)

    @moving_shape = ShapeEntity.new(x: 300, y: 300, shape: Square.new(size: 50, color: Color::Purple))
    @rotating_shape = Rectangle.new(x: 500, y: 500, width: 50, height: 100, color: Color::Purple)
  end

  def update(_frame_time)
    if down?([Key::Left, Key::A])
      @moving_shape.x -= SPEED * frame_time
    end

    if down?([Key::Right, Key::D])
      @moving_shape.x += SPEED * frame_time
    end

    if down?([Key::Up, Key::W])
      @moving_shape.y -= SPEED * frame_time
    end

    if down?([Key::Down, Key::S])
      @moving_shape.y += SPEED * frame_time
    end

    if Key::E.down?
      @rotating_shape.rotation += SPEED * frame_time
    end

    if Key::Q.down?
      @rotating_shape.rotation -= SPEED * frame_time
    end
  end

  def draw
    @shapes.each(&.draw)

    @moving_shape.draw
    @rotating_shape.draw
  end
end

ShapesExample.new.run
