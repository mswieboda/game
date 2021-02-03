class Game::TextInput < Game::Text
  property? focused

  def initialize(text = "", font = Font.default, x = 0, y = 0, size = 16, spacing = 1, color = Color::Red)
    super

    @focused = false
  end

  def update(frame_time)
    if focused?
      key = LibRay.get_key_pressed

      if key > 0
        @text += key.chr
      elsif Key::Backspace.pressed?
        @text = @text.rchop
      end
    end
  end

  def draw
    super
  end
end
