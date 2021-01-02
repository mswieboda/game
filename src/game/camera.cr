module Game
  class Camera
    @camera : LibRay::Camera

    enum Type
      Perspective
      Orthographic
    end

    enum Mode
      Custom
      Free
      Orbital
      FirstPerson
      ThirdPerson
    end

    def initialize(position = Vector3.new, target = Vector3.new, up = Vector3.new, fov : Int32 | Float32 = 45, type = Type::Perspective)
      @camera = LibRay::Camera.new(
        position: position.to_struct,
        target: target.to_struct,
        up: up.to_struct,
        fovy: fov.to_f32,
        type: type
      )
    end

    def update
      LibRay.update_camera(pointerof(@camera))
    end

    def mode=(mode : Mode)
      LibRay.set_camera_mode(@camera, mode)
    end

    def to_struct
      @camera
    end
  end
end
