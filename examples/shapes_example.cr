require "../src/game"

class ShapesExample < Game::Game
  SPEED = 150

  def initialize
    super(name: "Shapes Example")

    @shapes = [] of Game::Shape

    @shapes << Game::Pixel.new(x: 50, y: 125)
    @shapes << Game::Pixel.new(x: 55, y: 130)
    @shapes << Game::Pixel.new(x: 60, y: 125)
    @shapes << Game::Pixel.new(x: 50, y: 135)
    @shapes << Game::Pixel.new(x: 60, y: 135)

    @shapes << Game::Line.new(start_x: 100, start_y: 125, end_x: 110, end_y: 135)
    @shapes << Game::Line.new(start_x: 100, start_y: 135, end_x: 110, end_y: 125)

    @shapes << Game::Line.new(start_x: 50, start_y: 200, end_x: 100, end_y: 250, thickness: 15)
    @shapes << Game::Line.new(start_x: 50, start_y: 250, end_x: 100, end_y: 200, thickness: 15)
    @shapes << Game::Line.new(start_x: 75, start_y: 200, end_x: 75, end_y: 250, thickness: 3, color: Game::Color::Purple)
    @shapes << Game::Line.new(start_x: 50, start_y: 225, end_x: 100, end_y: 225, thickness: 3, color: Game::Color::Purple)

    @shapes << Game::Circle.new(x: 175, y: 100, size: 50, filled: false)
    @shapes << Game::Circle.new(center_x: 200, center_y: 125, radius: 20)

    @shapes << Game::Triangle.new(x1: 275, y1: 160, x2: 300, y2: 100, x3: 325, y3: 160, filled: false)
    @shapes << Game::Triangle.new(x1: 280, y1: 155, x2: 300, y2: 110, x3: 320, y3: 155)

    @shapes << Game::Polygon.new(center_x: 400, center_y: 130, sides: 5, radius: 25, filled: false)
    @shapes << Game::Polygon.new(center_x: 400, center_y: 130, sides: 5, radius: 20)

    @shapes << Game::Ellipse.new(x: 450, y: 70, width: 50, height: 120, filled: false)
    @shapes << Game::Ellipse.new(center_x: 475, center_y: 130, horizontal_radius: 20, vertical_radius: 55)

    @shapes << Game::Ring.new(x: 525, y: 105, inner_radius: 5, size: 50, filled: false)
    @shapes << Game::Ring.new(center_x: 550, center_y: 130, inner_radius: 10, outer_radius: 20)

    @shapes << Game::Rectangle.new(x: 600, y: 100, width: 20, height: 50, filled: false)
    @shapes << Game::Rectangle.new(x: 605, y: 105, width: 10, height: 40)

    @shapes << Game::Rectangle.new(x: 500, y: 500, width: 30, height: 50, rotation: 50)

    @shapes << Game::Square.new(x: 650, y: 100, size: 50, filled: false)
    @shapes << Game::Square.new(x: 655, y: 105, size: 40)

    @shapes << Game::EquilateralTriangle.new(x: 725, y: 100, size: 50, filled: false)
    @shapes << Game::EquilateralTriangle.new(center_x: 750, center_y: 125, radius: 20)

    @shapes << Game::RoundedRectangle.new(x: 810, y: 110, width: 30, height: 80, roundness: 0.333_f32, segments: 10)
    @shapes << Game::RoundedRectangle.new(x: 800, y: 100, width: 50, height: 100, roundness: 0.333_f32, segments: 10, thickness: 3, filled: false)

    @moving_shape = Game::ShapeEntity.new(x: 300, y: 300, shape: Game::Square.new(size: 50, color: Game::Color::Purple))
    @rotating_shape = Game::Rectangle.new(x: 500, y: 500, width: 50, height: 100, color: Game::Color::Purple)

  end

  def update(frame_time)
    if Game::Keys.down?([Game::Key::Left, Game::Key::A])
      @moving_shape.x -= SPEED * frame_time
    end

    if Game::Keys.down?([Game::Key::Right, Game::Key::D])
      @moving_shape.x += SPEED * frame_time
    end

    if Game::Keys.down?([Game::Key::Up, Game::Key::W])
      @moving_shape.y -= SPEED * frame_time
    end

    if Game::Keys.down?([Game::Key::Down, Game::Key::S])
      @moving_shape.y += SPEED * frame_time
    end

    if Game::Key::E.down?
      @rotating_shape.rotation += SPEED * frame_time
    end

    if Game::Key::Q.down?
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
