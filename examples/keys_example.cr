require "../src/game"

class KeysExample < Game::Game
  getter? space
  getter? enter
  getter? any_alt
  getter? all_shift
  getter? any_pressed
  getter keys : Array(Game::Key)

  def initialize
    super(name: "Keys Example")

    @space = false
    @enter = false
    @any_alt = false
    @all_shift = false
    @any_pressed = false
    @keys = [] of Game::Key
  end

  def setup
    Game::Key::X.exit_key
  end

  def update(_frame_time)
    @space = Game::Key::Space.down?
    @enter = Game::Keys.down?(Game::Key::Enter)
    @any_alt = Game::Keys.down?([Game::Key::LAlt, Game::Key::RAlt])
    @all_shift = Game::Keys.all_down?([Game::Key::LShift, Game::Key::RShift])
    @any_pressed = Game::Keys.any_pressed?
    @keys = @any_pressed ? Game::Keys.get_pressed : [] of Game::Key
  end

  def draw
    draw_down
    draw_down_2
    draw_any_down
    draw_all_down
    draw_any_pressed
    draw_get_pressed
    draw_exit_key
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
    text += "x" if any_pressed?

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

  def draw_exit_key
    text = "press \"x\" key to exit (instead of default Escape key)"

    LibRay.draw_text(
      text: text,
      pos_x: 15,
      pos_y: 235,
      font_size: 25,
      color: LibRay::GREEN
    )
  end
end

KeysExample.new.run
