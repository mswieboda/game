module Game
  class Model
    property position : Vector3
    property scale : Int32 | Float32
    property tint : Color

    @model : LibRay::Model
    @transform : Matrix

    def initialize(@model = LibRay::Model.new, @position = Vector3.new, @scale = 1, @tint = Color::White)
      @transform = Matrix.from_struct(@model.transform)
    end

    def self.from_mesh(mesh : Mesh)
      Model.new(LibRay.load_model_from_mesh(mesh.to_struct))
    end

    def transform=(transform : Matrix)
      @transform = transform
      @model.transform = @transform.to_struct
    end

    def translate(v : Vector3)
      self.transform = @transform.dot(Matrix.new(
        m0: 1, m4: 0, m8: 0, m12: v.x,
        m1: 0, m5: 1, m9: 0, m13: v.y,
        m2: 0, m6: 0, m10: 1, m14: v.z,
        m3: 0, m7: 0, m11: 0, m15: 1
      ))
    end

    def scale(v : Vector3)
      self.transform = @transform.dot(Matrix.new(
        m0: v.x, m4: 0, m8: 0, m12: 0,
        m1: 0, m5: v.y, m9: 0, m13: 0,
        m2: 0, m6: 0, m10: v.z, m14: 0,
        m3: 0, m7: 0, m11: 0, m15: 1
      ))
    end

    def rotate_x(degrees : Int32 | Float32)
      theta = Utils.to_radians(degrees)

      self.transform = @transform.dot(Matrix.new(
        m0: 1, m4: 0, m8: 0, m12: 0,
        m1: 0, m5: Math.cos(theta).to_f32, m9: -Math.sin(theta).to_f32, m13: 0,
        m2: 0, m6: Math.sin(theta).to_f32, m10: Math.cos(theta).to_f32, m14: 0,
        m3: 0, m7: 0, m11: 0, m15: 1
      ))
    end

    def rotate_y(degrees : Int32 | Float32)
      theta = Utils.to_radians(degrees)

      self.transform = @transform.dot(Matrix.new(
        m0: Math.cos(theta).to_f32, m4: 0, m8: Math.sin(theta).to_f32, m12: 0,
        m1: 0, m5: 1, m9: 0, m13: 0,
        m2: -Math.sin(theta).to_f32, m6: 0, m10: Math.cos(theta).to_f32, m14: 0,
        m3: 0, m7: 0, m11: 0, m15: 1
      ))
    end

    def rotate_z(degrees : Int32 | Float32)
      theta = Utils.to_radians(degrees)

      self.transform = @transform.dot(Matrix.new(
        m0: Math.cos(theta).to_f32, m4: -Math.sin(theta).to_f32, m8: 0, m12: 0,
        m1: Math.sin(theta).to_f32, m5: Math.cos(theta).to_f32, m9: 0, m13: 0,
        m2: 0, m6: 0, m10: 1, m14: 0,
        m3: 0, m7: 0, m11: 0, m15: 1
      ))
    end

    def set_texture(texture)
      @model.materials.value.maps.value.texture = texture.to_struct
    end

    def set_mesh_material(mesh_id)
      @model.mesh_material.value = mesh_id
    end

    def draw
      LibRay.draw_model(@model, position.to_struct, scale, tint.to_struct)
    end

    def to_struct
      @model
    end

    def self.draw_grid(slices = 10, spacing = 1)
      LibRay.draw_grid(slices, spacing)
    end
  end
end
