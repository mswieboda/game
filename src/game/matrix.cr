module Game
  class Matrix
    property m0 : Int32 | Float32
    property m4 : Int32 | Float32
    property m8 : Int32 | Float32
    property m12 : Int32 | Float32

    property m1 : Int32 | Float32
    property m5 : Int32 | Float32
    property m9 : Int32 | Float32
    property m13 : Int32 | Float32

    property m2 : Int32 | Float32
    property m6 : Int32 | Float32
    property m10 : Int32 | Float32
    property m14 : Int32 | Float32

    property m3 : Int32 | Float32
    property m7 : Int32 | Float32
    property m11 : Int32 | Float32
    property m15 : Int32 | Float32

    def self.identity
      self.class.new
    end

    def initialize(
      @m0 = 1,
      @m4 = 0,
      @m8 = 0,
      @m12 = 0,

      @m1 = 0,
      @m5 = 1,
      @m9 = 0,
      @m13 = 0,

      @m2 = 0,
      @m6 = 0,
      @m10 = 1,
      @m14 = 0,

      @m3 = 0,
      @m7 = 0,
      @m11 = 0,
      @m15 = 1
    )
    end

    def self.from_struct(m : LibRay::Matrix)
      Matrix.new(
        m0: m.m0,
        m4: m.m4,
        m8: m.m8,
        m12: m.m12,

        m1: m.m1,
        m5: m.m5,
        m9: m.m9,
        m13: m.m13,

        m2: m.m2,
        m6: m.m6,
        m10: m.m10,
        m14: m.m14,

        m3: m.m3,
        m7: m.m7,
        m11: m.m11,
        m15: m.m15
      )
    end

    def to_struct
      LibRay::Matrix.new(
        m0: m0,
        m4: m4,
        m8: m8,
        m12: m12,

        m1: m1,
        m5: m5,
        m9: m9,
        m13: m13,

        m2: m2,
        m6: m6,
        m10: m10,
        m14: m14,

        m3: m3,
        m7: m7,
        m11: m11,
        m15: m15
      )
    end

    def add(m : Matrix) : Matrix
      self.class.new(
        m0: m0 + m.m0,
        m4: m4 + m.m4,
        m8: m8 + m.m8,
        m12: m12 + m.m12,

        m1: m1 + m.m1,
        m5: m5 + m.m5,
        m9: m9 + m.m9,
        m13: m13 + m.m13,

        m2: m2 + m.m2,
        m6: m6 + m.m6,
        m10: m10 + m.m10,
        m14: m14 + m.m14,

        m3: m3 + m.m3,
        m7: m7 + m.m7,
        m11: m11 + m.m11,
        m15: m15 + m.m15
      )
    end

    def subtract(m : Matrix) : Matrix
      self.class.new(
        m0: m0 - m.m0,
        m4: m4 - m.m4,
        m8: m8 - m.m8,
        m12: m12 - m.m12,

        m1: m1 - m.m1,
        m5: m5 - m.m5,
        m9: m9 - m.m9,
        m13: m13 - m.m13,

        m2: m2 - m.m2,
        m6: m6 - m.m6,
        m10: m10 - m.m10,
        m14: m14 - m.m14,

        m3: m3 - m.m3,
        m7: m7 - m.m7,
        m11: m11 - m.m11,
        m15: m15 - m.m15
      )
    end

    def dot(v : Int32 | Float32) : Matrix
      self.class.new(
        m0: m0 * v,
        m4: m4 * v,
        m8: m8 * v,
        m12: m12 * v,

        m1: m1 * v,
        m5: m5 * v,
        m9: m9 * v,
        m13: m13 * v,

        m2: m2 * v,
        m6: m6 * v,
        m10: m10 * v,
        m14: m14 * v,

        m3: m3 * v,
        m7: m7 * v,
        m11: m11 * v,
        m15: m15 * v
      )
    end

    def dot(v : Vector4) : Vector4
      Vector4.new(
        x: m0 * v.x + m4 * v.y + m8 * v.z + m12 * v.w,
        y: m1 * v.x + m5 * v.y + m9 * v.z + m13 * v.w,
        z: m2 * v.x + m6 * v.y + m10 * v.z + m14 * v.w,
        w: m3 * v.x + m7 * v.y + m11 * v.z + m15 * v.w
      )
    end

    def dot(m : Matrix)
      self.class.new(
        m0: m0 * m.m0 + m4 * m.m1 + m8 * m.m2 + m12 * m.m3,
        m4: m0 * m.m4 + m4 * m.m5 + m8 * m.m6 + m12 * m.m7,
        m8: m0 * m.m8 + m4 * m.m9 + m8 * m.m10 + m12 * m.m11,
        m12: m0 * m.m12 + m4 * m.m13 + m8 * m.m14 + m12 * m.m15,

        m1: m1 * m.m0 + m5 * m.m1 + m9 * m.m2 + m13 * m.m3,
        m5: m1 * m.m4 + m5 * m.m5 + m9 * m.m6 + m13 * m.m7,
        m9: m1 * m.m8 + m5 * m.m9 + m9 * m.m10 + m13 * m.m11,
        m13: m1 * m.m12 + m5 * m.m13 + m9 * m.m14 + m13 * m.m15,

        m2: m2 * m.m0 + m6 * m.m1 + m10 * m.m2 + m14 * m.m3,
        m6: m2 * m.m4 + m6 * m.m5 + m10 * m.m6 + m14 * m.m7,
        m10: m2 * m.m8 + m6 * m.m9 + m10 * m.m10 + m14 * m.m11,
        m14: m2 * m.m12 + m6 * m.m13 + m10 * m.m14 + m14 * m.m15,

        m3: m3 * m.m0 + m7 * m.m1 + m11 * m.m2 + m15 * m.m3,
        m7: m3 * m.m4 + m7 * m.m5 + m11 * m.m6 + m15 * m.m7,
        m11: m3 * m.m8 + m7 * m.m9 + m11 * m.m10 + m15 * m.m11,
        m15: m3 * m.m12 + m7 * m.m13 + m11 * m.m14 + m15 * m.m15
      )
    end

    def ==(m : Matrix)
      m0 == m.m0 && m4 == m.m4 && m8 == m.m8 && m12 == m.m12 &&
        m1 == m.m1 && m5 == m.m5 && m9 == m.m9 && m13 == m.m13 &&
        m2 == m.m2 && m6 == m.m6 && m10 == m.m10 && m14 == m.m14 &&
        m3 == m.m3 && m7 == m.m7 && m11 == m.m11 && m15 == m.m15
    end

    def to_s(io : IO)
      io << "#<" << self.class.name << ":0x"
      object_id.to_s(io, 16)
      io << ":["
      io << "  [#{m0}, #{m4}, #{m8}, #{m12}],"
      io << "  [#{m1}, #{m5}, #{m9}, #{m13}],"
      io << "  [#{m2}, #{m6}, #{m10}, #{m14}],"
      io << "  [#{m3}, #{m7}, #{m11}, #{m15}],"
      io << "])>"
    end

    def identity?
      self == self.class.identity
    end
  end
end
