module Game
  class Vector4
    property x : Int32 | Float32
    property y : Int32 | Float32
    property z : Int32 | Float32
    property w : Int32 | Float32

    def self.zero
      Vector4.new
    end

    def initialize(@x = 0, @y = 0, @z = 0, @w = 0)
    end

    def to_struct
      LibRay::Vector4.new(x: x, y: y, z: z, w: w)
    end

    def subtract(v : Vector4) : Vector4
      self.class.new(x: x - v.x, y: y - v.y, z: z - v.z, w: w - v.w)
    end

    def dot(v : Vector4)
      x * v.x + y * v.y + z * v.z + w * v.w
    end

    def ==(v : Vector4)
      x == v.x && y == v.y && z == v.z && w == v.w
    end

    def to_s(io : IO)
      io << "#<" << self.class.name << ":0x"
      object_id.to_s(io, 16)
      io << ":(x: #{x}, y: #{y}, z: #{z}, w: #{w})>"
    end

    def zero?
      self == self.class.zero
    end
  end
end
