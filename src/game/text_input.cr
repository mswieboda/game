class Game::TextInput < Game::Text
  property? focused
  property backspace_delay

  def initialize(
    text = "",
    font = Font.default,
    x = 0,
    y = 0,
    size = 16,
    spacing = 1,
    color = Color::Red,
    @backspace_delay = 0.035_f32
  )
    super(
      text: text,
      font: font,
      x: x,
      y: y,
      size: size,
      spacing: spacing,
      color: color
    )

    @focused = false
    @backspace_delay_t = 0_f32
  end

  def update(frame_time)
    if focused?
      key = LibRay.get_key_pressed

      if key > 0
        self.text += key.chr
        measure
      elsif Key::Backspace.down?
        if backspace_delay?
          @backspace_delay_t += frame_time
          return
        end

        self.text = @text.rchop
        measure

        @backspace_delay_t = 0_f32
      end
    end
  end

  def draw
    super
  end

  def backspace_delay?
    @backspace_delay_t < backspace_delay
  end
end
