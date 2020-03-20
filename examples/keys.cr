require "../src/game"

class Input < Game
  getter? space
  getter? enter
  getter? any_alt
  getter? all_shift
  getter keys : Array(Key)

  def initialize
    super(name: "Input")

    @space = false
    @enter = false
    @any_alt = false
    @all_shift = false
    @any_pressed = false
    @keys = [] of Key
  end

  def update
    @space = Key::Space.down?
    @enter = down?(Key::Enter)
    @any_alt = down?([Key::LAlt, Key::RAlt])
    @all_shift = all_down?([Key::LShift, Key::RShift])
    @any_pressed = any_pressed?
    @keys = @any_pressed ? get_pressed : [] of Key
  end

  def draw
    draw_down
    draw_down_2
    draw_any_down
    draw_all_down
    draw_any_pressed
    draw_get_pressed
  end

  def draw_down
    text = "space: "
    text += "x" if space?

    LibRay.draw_text(
      text: text,
      pos_x: 15,
      pos_y: 15,
      font_size: 25,
      color: LibRay::GREEN
    )
  end

  def draw_down_2
    text = "enter: "
    text += "x" if enter?

    LibRay.draw_text(
      text: text,
      pos_x: 15,
      pos_y: 55,
      font_size: 25,
      color: LibRay::GREEN
    )
  end

  def draw_any_down
    text = "any alt: "
    text += "x" if any_alt?

    LibRay.draw_text(
      text: text,
      pos_x: 15,
      pos_y: 95,
      font_size: 25,
      color: LibRay::GREEN
    )
  end

  def draw_all_down
    text = "all shift: "
    text += "x" if all_shift?

    LibRay.draw_text(
      text: text,
      pos_x: 15,
      pos_y: 130,
      font_size: 25,
      color: LibRay::GREEN
    )
  end

  def draw_any_pressed
    text = "any pressed: "
    text += "x" if @any_pressed

    LibRay.draw_text(
      text: text,
      pos_x: 15,
      pos_y: 165,
      font_size: 25,
      color: LibRay::GREEN
    )
  end

  def draw_get_pressed
    text = "get pressed: "
    text += keys.join(", ")

    LibRay.draw_text(
      text: text,
      pos_x: 15,
      pos_y: 200,
      font_size: 25,
      color: LibRay::GREEN
    )
  end
end

Input.new.run
