MOUSE_METHODS = [:pressed?, :down?, :released?, :up?]

enum MouseButton
  Left   = LibRay::MOUSE_LEFT_BUTTON
  Right  = LibRay::MOUSE_RIGHT_BUTTON
  Middle = LibRay::MOUSE_MIDDLE_BUTTON

  {% for name, index in MOUSE_METHODS %}
    def {{name.id}}
      Mouse.{{name.id}}(self)
    end
  {% end %}
end

module Mouse
  Left   = MouseButton::Left
  Right  = MouseButton::Right
  Middle = MouseButton::Middle

  {% for name, index in MOUSE_METHODS %}
    def self.{{name.id}}(button : MouseButton)
      LibRay.mouse_button_{{name.id}}(button.value)
    end

    def {{name.id}}(button : MouseButton)
      button.{{name.id}}
    end

    def {{name.id}}(buttons : Array(MouseButton))
      buttons.any?(&.{{name.id}})
    end

    def all_{{name.id}}(buttons : Array(MouseButton))
      buttons.all?(&.{{name.id}})
    end
  {% end %}

  def self.x
    LibRay.get_mouse_x
  end

  def self.y
    LibRay.get_mouse_y
  end

  def self.x=(x)
    LibRay.set_mouse_position(x, y)
  end

  def self.y=(y)
    LibRay.set_mouse_position(x, y)
  end

  def self.wheel
    LibRay.get_mouse_wheel_move
  end
end
