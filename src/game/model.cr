module Game
  class Model
    @model : LibRay::Model

    def initialize(@model = LibRay::Model.new)
    end

    def self.from_mesh(mesh : Mesh)
      Model.new(LibRay.load_model_from_mesh(mesh.to_struct))
    end

    def set_texture(texture)
      LibRay.set_material_texture(@model.materials, 0, texture.to_struct)
    end

    def set_mesh_material(mesh_id)
      LibRay.set_model_mesh_material(pointerof(@model), 0, mesh_id)
    end

    def draw(position : Vector3, scale : Int32 | Float32 = 1, color : Color = Color::White)
      LibRay.draw_model(@model, position.to_struct, scale, color.to_struct)
    end

    def to_struct
      @model
    end
  end
end
