module Game
  class Mesh
    @mesh : LibRay::Mesh

    def initialize(@mesh = LibRay::Mesh.new)
    end

    def self.cube(width, height, length)
      Mesh.new(LibRay.gen_mesh_cube(width, height, length))
    end

    def to_struct
      @mesh
    end
  end
end
