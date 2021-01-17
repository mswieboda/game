module Game
  class Color
    getter red : UInt8
    getter green : UInt8
    getter blue : UInt8
    getter alpha : UInt8

    # Transparent
    Transparent = new(color: 0, alpha: 0)

    # Blacks
    Black = new

    # Whites
    White = new(color: 255)

    # Grays
    Gray       = new(color: 128)
    Grey       = Game::Color::Gray
    LightGray  = new(color: 211)
    LightGrey  = Game::Color::LightGray
    DarkGray   = new(color: 169)
    DarkGrey   = Game::Color::DarkGray
    DarkerGray = new(color: 70)
    DarkerGrey = Game::Color::DarkerGray
    DimGray    = new(color: 105)
    DimGrey    = Game::Color::DimGray
    Silver     = new(color: 192)
    Snow       = new(red: 255, green: 250, blue: 250)
    WhiteSmoke = new(red: 245, green: 245, blue: 245)
    GunSmoke   = new(red: 122, green: 124, blue: 118)
    Ivory      = new(red: 255, green: 255, blue: 240)

    # Reds
    Red       = new(red: 255)
    DarkRed   = new(red: 139)
    Maroon    = new(red: 128)
    FireBrick = new(red: 178, green: 34, blue: 34)
    Crimson   = new(red: 220, green: 20, blue: 60)
    Tomato    = new(red: 255, green: 99, blue: 71)
    Salmon    = new(red: 250, green: 128, blue: 114)

    # Oranges
    Orange     = new(red: 255, green: 165)
    OrangeRed  = new(red: 255, green: 69)
    DarkOrange = new(red: 255, green: 140)
    Coral      = new(red: 255, green: 127, blue: 80)

    # Yellows
    Yellow      = new(red: 255, green: 255)
    Gold        = new(red: 255, green: 215)
    GoldenRod   = new(red: 218, green: 165, blue: 32)
    Khaki       = new(red: 240, green: 230, blue: 140)
    DarkKhaki   = new(red: 189, green: 183, blue: 107)
    YellowGreen = new(red: 154, green: 205, blue: 50)
    Olive       = new(red: 128, green: 128)

    # Green
    Green       = new(green: 128)
    Lime        = new(green: 255)
    LimeGreen   = new(red: 50, green: 205, blue: 50)
    DarkGreen   = new(green: 100)
    ForestGreen = new(red: 34, green: 139, blue: 34)
    SpringGreen = new(green: 255, blue: 127)
    SeaGreen    = new(red: 46, green: 139, blue: 87)
    GreenYellow = new(red: 173, green: 255, blue: 47)

    # Blues
    Blue          = new(blue: 255)
    LightBlue     = new(red: 173, green: 216, blue: 230)
    DarkBlue      = new(blue: 139)
    Navy          = new(blue: 128)
    RoyalBlue     = new(red: 65, green: 105, blue: 225)
    Cyan          = new(blue: 255, green: 255)
    Aqua          = Game::Color::Cyan
    DarkCyan      = new(green: 139, blue: 139)
    Teal          = new(green: 128, blue: 128)
    Turquoise     = new(red: 64, green: 224, blue: 208)
    DarkTurquoise = new(green: 206, blue: 209)

    # Purples
    Purple      = new(red: 128, blue: 128)
    Magenta     = new(red: 255, blue: 255)
    Fuschia     = Game::Color::Magenta
    DarkMagenta = new(red: 139, blue: 139)
    Indigo      = new(red: 75, blue: 130)
    Violet      = new(red: 238, green: 130, blue: 238)
    DarkViolet  = new(red: 138, green: 43, blue: 226)
    Lavender    = new(red: 230, green: 230, blue: 250)
    DeepPink    = new(red: 255, green: 20, blue: 147)
    HotPink     = new(red: 255, green: 105, blue: 180)
    Pink        = new(red: 255, green: 192, blue: 203)

    # Browns
    Brown       = new(red: 165, green: 42, blue: 42)
    SaddleBrown = new(red: 139, green: 69, blue: 19)
    DarkEbony   = new(red: 55, green: 49, blue: 43)
    Sienna      = new(red: 160, green: 82, blue: 45)
    Chocolate   = new(red: 210, green: 105, blue: 30)
    Peru        = new(red: 205, green: 133, blue: 63)
    SandyWood   = new(red: 244, green: 164, blue: 96)
    Tan         = new(red: 210, green: 180, blue: 140)
    Moccasin    = new(red: 255, green: 228, blue: 181)

    def initialize(color = nil, red = 0, green = 0, blue = 0, alpha = 255)
      @red = red.to_u8
      @green = green.to_u8
      @blue = blue.to_u8
      @alpha = alpha.to_u8

      if color
        @red = color.to_u8
        @green = color.to_u8
        @blue = color.to_u8
      end
    end

    def self.from_hex(hex_input)
      hex = hex_input.lchop('#').lchop("0x")

      new(
        red: hex[0..1].to_u8(base: 16),
        green: hex[4..5].to_u8(base: 16),
        blue: hex[2..3].to_u8(base: 16),
        alpha: hex[6..7].to_u8(base: 16)
      )
    end

    def self.random
      new(
        red: rand(256),
        green: rand(256),
        blue: rand(256)
      )
    end

    def to_hex
      hex = "#" + red.to_s(base: 16, upcase: true)
      hex += green.to_s(base: 16, upcase: true)
      hex += blue.to_s(base: 16, upcase: true)
      hex += alpha.to_s(base: 16, upcase: true)
    end

    def to_struct
      LibRay::Color.new(
        r: red,
        g: green,
        b: blue,
        a: alpha
      )
    end

    def dup
      self.class.new(red: red, blue: blue, green: green, alpha: alpha)
    end

    def to_s(io : IO)
      io << "#<Color: "
      io << "r: #{red}, "
      io << "g: #{green}, "
      io << "b: #{blue}, "
      io << "a: #{alpha}"
      io << ">"
    end

    # red, green, blue, alpha chainable methods
    # ex: `some_color.red(5_u8)` returns the color with red set to 5
    # ex: `some_color.add_red(5_u8)` returns the color with 5 red added
    {% for var in [:red, :green, :blue, :alpha] %}
      def {{var.id}}(value : UInt8)
        Color.new(
          red: {{var}} == :red ? value : red,
          blue: {{var}} == :blue ? value : blue,
          green: {{var}} == :green ? value : green,
          alpha: {{var}} == :alpha ? value : alpha
        )
      end

      def add_{{var.id}}(value : UInt8)
        {{var.id}}((value.to_u16 + {{var.id}}).clamp(UInt8::MIN, UInt8::MAX).to_u8)
      end

      def {{var.id}}(percent : Float32 | Float64)
        {{var.id}}((percent * 255).clamp(UInt8::MIN, UInt8::MAX).to_u8)
      end

      def add_{{var.id}}(percent : Float32 | Float64)
        add_{{var.id}}((percent * 255).clamp(UInt8::MIN, UInt8::MAX).to_u8)
      end
    {% end %}
  end
end
