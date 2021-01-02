module Game
  class Vector3
    property x : Int32 | Float32
    property y : Int32 | Float32
    property z : Int32 | Float32

    def self.zero
      Vector3.new
    end

    def initialize(@x = 0, @y = 0, @z = 0)
    end

    def to_struct
      LibRay::Vector3.new(x: x, y: y, z: z)
    end

    def subtract(v : Vector3) : Vector3
      self.class.new(x: x - v.x, y: y - v.y, z: z - v.z)
    end

    def dot(v : Vector3)
      x * v.x + y * v.y + z * v.z
    end

    def ==(v : Vector3)
      x == v.x && y == v.y && z == v.z
    end

    def to_s(io : IO)
      io << "#<" << self.class.name << ":0x"
      object_id.to_s(io, 16)
      io << ":(x: #{x}, y: #{y}, z: #{z})>"
    end

    def zero?
      self == self.class.zero
    end
  end
end
