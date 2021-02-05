require "json"

module Game
  class Vector
    include JSON::Serializable

    property x : Int32 | Float32
    property y : Int32 | Float32

    def self.zero
      new
    end

    def initialize(@x = 0, @y = 0)
    end

    def to_struct
      LibRay::Vector2.new(x: x, y: y)
    end

    def length
      Math.sqrt(x ** 2 + y ** 2).to_f32
    end

    def clone
      self.class.new(x: x, y: y)
    end

    def add(v : Vector) : Vector
      self + v
    end

    def subtract(v : Vector) : Vector
      self - v
    end

    # methods: +, -, *
    # TODO: figure out how to do +=, -=, *=
    #       as `def +=(v)` causes syntax error
    {% for var in [:+, :-, :*] %}
      def {{var.id}}(value : Int32 | Float32)
        self.class.new(x: x {{var.id}} value, y: y {{var.id}} value)
      end

      def {{var.id}}(v : Vector)
        self.class.new(x: x {{var.id}} v.x, y: y {{var.id}} v.y)
      end
    {% end %}

    def /(value : Int32 | Float32)
      self.class.new(x: (x / value).to_f32, y: (y / value).to_f32)
    end

    def /(v : Vector)
      self.class.new(x: (x / v.x).to_f32, y: (y / v.y).to_f32)
    end

    def dot(v : Vector)
      x * v.x + y * v.y
    end

    def ==(other : Vector)
      x == other.x && y == other.y
    end

    def to_s(io : IO)
      io << "#<" << self.class.name << ":0x"
      object_id.to_s(io, 16)
      io << ":(x: #{x}, y: #{y})>"
    end

    def zero?
      self == self.class.zero
    end

    def collision?(tri : Triangle)
      # Barycentric Technique to test if a point is in a triangle
      # https://blackpawn.com/texts/pointinpoly/default.html

      a = Vector.new(x: tri.x1, y: tri.y1)
      b = Vector.new(x: tri.x2, y: tri.y2)
      c = Vector.new(x: tri.x3, y: tri.y3)

      # Compute vectors
      v0 = c.subtract(a)
      v1 = b.subtract(a)
      v2 = subtract(a)

      # Compute dot products
      dot_0_0 = v0.dot(v0)
      dot_0_1 = v0.dot(v1)
      dot_0_2 = v0.dot(v2)
      dot_1_1 = v1.dot(v1)
      dot_1_2 = v1.dot(v2)

      # Compute barycentric coordinates
      inv_denom = 1 / (dot_0_0 * dot_1_1 - dot_0_1 * dot_0_1)
      u = (dot_1_1 * dot_0_2 - dot_0_1 * dot_1_2) * inv_denom
      v = (dot_0_0 * dot_1_2 - dot_0_1 * dot_0_2) * inv_denom

      # Check if point is in triangle
      u >= 0 && v >= 0 && u + v < 1
    end

    def self.collision?(a1 : Vector, a2 : Vector, b1 : Vector, b2 : Vector)
      # // a1 is line1 start, a2 is line1 end, b1 is line2 start, b2 is line2 end
      # https://stackoverflow.com/a/14561664/1183537

      # if we need the intersection vector later:
      # intersection = Vector.zero

      b = a2.subtract(a1)
      d = b2.subtract(b1)
      b_dot_d_perp = b.x * d.y - b.y * d.x

      # if b dot d == 0, it means the lines are parallel so have infinite intersection points
      return false if b_dot_d_perp == 0

      c = b1.subtract(a1)
      t = (c.x * d.y - c.y * d.x) / b_dot_d_perp

      return false if t < 0 || t > 1

      u = (c.x * b.y - c.y * b.x) / b_dot_d_perp

      return false if u < 0 || u > 1

      # intersection = Vector2.Sum(a1,Vector2.Multiply(b,t));

      true
    end
  end
end
