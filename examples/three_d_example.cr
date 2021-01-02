require "../src/game"

class ThreeDExample < Game::Game
  def initialize
    super(name: "3D Example", background_color: Game::Color::White)

    ThreeDExample.camera = Game::Camera.new(
      position: Game::Vector3.new(x: 5.0_f32, y: 5.0_f32, z: 0.0_f32),
      target: Game::Vector3.new(x: 0_f32, y: 0_f32, z: 0_f32),
      up: Game::Vector3.new(x: 0_f32, y: 1_f32, z: 0_f32)
    )

    ThreeDExample.camera.mode = Game::Camera::Mode::Orbital

    image = Game::Image.load("./assets/crystal_icon.png")
    texture = Game::Texture.load(image)

    @model = Game::Model.from_mesh(Game::Mesh.cube(1, 1, 1))
    @model.set_texture(texture)
    @position = Game::Vector3.new(x: 0, y: 0, z: 0)
  end

  def update(_frame_time)
    ThreeDExample.camera.update
  end

  def draw
    ThreeDExample.begin_3d

    LibRay.draw_grid(10, 1.0)
    @model.draw(position: @position, color: Game::Color::Red)

    ThreeDExample.end_3d
  end
end

ThreeDExample.new.run
