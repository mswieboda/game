module Game
  KEY_METHODS = [:pressed?, :down?, :released?, :up?]

  enum Key
    Space     = LibRay::KEY_SPACE
    Escape    = LibRay::KEY_ESCAPE
    Enter     = LibRay::KEY_ENTER
    Backspace = LibRay::KEY_BACKSPACE
    Right     = LibRay::KEY_RIGHT
    Left      = LibRay::KEY_LEFT
    Down      = LibRay::KEY_DOWN
    Up        = LibRay::KEY_UP
    F1        = LibRay::KEY_F1
    F2        = LibRay::KEY_F2
    F3        = LibRay::KEY_F3
    F4        = LibRay::KEY_F4
    F5        = LibRay::KEY_F5
    F6        = LibRay::KEY_F6
    F7        = LibRay::KEY_F7
    F8        = LibRay::KEY_F8
    F9        = LibRay::KEY_F9
    F10       = LibRay::KEY_F10
    F11       = LibRay::KEY_F11
    F12       = LibRay::KEY_F12
    LShift    = LibRay::KEY_LEFT_SHIFT
    LControl  = LibRay::KEY_LEFT_CONTROL
    LAlt      = LibRay::KEY_LEFT_ALT
    RShift    = LibRay::KEY_RIGHT_SHIFT
    RControl  = LibRay::KEY_RIGHT_CONTROL
    RAlt      = LibRay::KEY_RIGHT_ALT

    Tab      = 258
    CapsLock = 345

    LMeta = 343
    RMeta = 347

    Backtick    = 96
    Minus       = 45
    Equals      = 61
    LBracket    = 91
    RBracket    = 93
    Backslash   = 92
    SemiColon   = 59
    SingleQuote = 39
    Comma       = 44
    Period      = 46
    Slash       = 47

    One   = LibRay::KEY_ONE
    Two   = LibRay::KEY_TWO
    Three = LibRay::KEY_THREE
    Four  = LibRay::KEY_FOUR
    Five  = LibRay::KEY_FIVE
    Six   = LibRay::KEY_SIX
    Seven = LibRay::KEY_SEVEN
    Eight = LibRay::KEY_EIGHT
    Nine  = LibRay::KEY_NINE
    Zero  = LibRay::KEY_ZERO
    A     = LibRay::KEY_A
    B     = LibRay::KEY_B
    C     = LibRay::KEY_C
    D     = LibRay::KEY_D
    E     = LibRay::KEY_E
    F     = LibRay::KEY_F
    G     = LibRay::KEY_G
    H     = LibRay::KEY_H
    I     = LibRay::KEY_I
    J     = LibRay::KEY_J
    K     = LibRay::KEY_K
    L     = LibRay::KEY_L
    M     = LibRay::KEY_M
    N     = LibRay::KEY_N
    O     = LibRay::KEY_O
    P     = LibRay::KEY_P
    Q     = LibRay::KEY_Q
    R     = LibRay::KEY_R
    S     = LibRay::KEY_S
    T     = LibRay::KEY_T
    U     = LibRay::KEY_U
    V     = LibRay::KEY_V
    W     = LibRay::KEY_W
    X     = LibRay::KEY_X
    Y     = LibRay::KEY_Y
    Z     = LibRay::KEY_Z

    {% for name, index in KEY_METHODS %}
      def {{name.id}}
        Keys.{{name.id}}(self)
      end
    {% end %}

    def exit_key
      Keys.exit_key(self)
    end
  end

  module Keys
    {% for name, index in KEY_METHODS %}
      def self.{{name.id}}(key : Key)
        LibRay.key_{{name.id}}(key.value)
      end

      def self.{{name.id}}(keys : Array(Key))
        keys.any?(&.{{name.id}})
      end

      def self.all_{{name.id}}(keys : Array(Key))
        keys.all?(&.{{name.id}})
      end

      def {{name.id}}(key : Key)
        Keys.{{name.id}}(key)
      end

      def {{name.id}}(keys : Array(Key))
        Keys.{{name.id}}(keys)
      end

      def all_{{name.id}}(keys : Array(Key))
        Keys.all_{{name.id}}(keys)
      end
    {% end %}

    def self.get_pressed : Array(Key)
      (32..348).to_a.select { |num| LibRay.key_down?(num) }.map { |num| Key.new(num) }
    end

    def get_pressed : Array(Key)
      Keys.get_pressed
    end

    def self.exit_key(key : Key)
      LibRay.set_exit_key(key.value)
    end

    def exit_key(key : Key)
      Key.exit_key(key.value)
    end

    def self.any_pressed?
      get_pressed.any?
    end

    def any_pressed?
      Keys.any_pressed?
    end
  end
end
