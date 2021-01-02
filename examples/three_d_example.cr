require "../src/game"

class ThreeDExample < Game::Game
  def initialize
    super(name: "3D Example", background_color: Game::Color::White)

    ThreeDExample.camera = Game::Camera.new(
      position: Game::Vector3.new(x: 0, y: 15, z: 15),
      target: Game::Vector3.new(x: 0, y: 0, z: 0),
      up: Game::Vector3.new(x: 0, y: 1, z: 0)
    )

    ThreeDExample.camera.mode = Game::Camera::Mode::Orbital

    image = Game::Image.load("./assets/crystal_icon.png")
    texture = Game::Texture.load(image)

    @model = Game::Model.from_mesh(Game::Mesh.cube(1, 1, 1))
    @model.set_texture(texture)

    @model.translate(Game::Vector3.new(x: 1, y: 2, z: -3))
    @model.scale(Game::Vector3.new(x: 2, y: 2, z: 2))
    @model.rotate_x(45)
    @model.rotate_y(45)
    @model.rotate_z(45)
  end

  def update(_frame_time)
    ThreeDExample.camera.update
  end

  def draw
    ThreeDExample.begin_3d

    @model.draw
    Game::Model.draw_grid(slices: 30, spacing: 0.5_f32)

    ThreeDExample.end_3d
  end
end

ThreeDExample.new.run
