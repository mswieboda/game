class Game::Game
  getter name : String
  getter target_fps : Int32
  getter background_color : Color
  getter? fullscreen : Bool
  getter? resizeable : Bool
  getter? audio : Bool
  getter? draw_fps : Bool

  @@camera = Camera.new

  NAME = "Game"
  FULLSCREEN = false
  SCREEN_WIDTH  = 1280
  SCREEN_HEIGHT =  768
  BACKGROUND_COLOR = Color::Black
  TARGET_FPS = 60
  RESIZEABLE = false
  AUDIO      = false
  DEBUG = false
  DRAW_FPS = false
  EXIT_WITH_ESC = true

  def initialize(
    @name = NAME,
    @fullscreen = FULLSCREEN,
    screen_width = nil,
    screen_height = nil,
    @target_fps = TARGET_FPS,
    @background_color = BACKGROUND_COLOR,
    @resizeable = RESIZEABLE,
    @audio = AUDIO,
    @draw_fps = DRAW_FPS,
    exit_with_esc = EXIT_WITH_ESC
  )
    LibRay.set_config_flags(LibRay::FLAG_WINDOW_RESIZABLE) if resizeable?
    LibRay.init_window(screen_width || SCREEN_WIDTH, screen_height || SCREEN_HEIGHT, name)
    LibRay.set_exit_key(-1) unless exit_with_esc

    unless screen_height && screen_width
      width = LibRay.get_monitor_width(0)

      # faked maximize, 45 is probably only for macOS
      height = LibRay.get_monitor_height(0) - 45

      LibRay.set_window_size(width, height)
      LibRay.set_window_position(0, 0)

      # TODO: switch to maximize_window when raylib updated to 3.0 or 3.1
      # it might change to a set_window_state(FLAG_WINDOW_MAXIMIZED) etc
      # https://github.com/raysan5/raylib/pull/1357
      # LibRay.maximize_window
    end

    LibRay.toggle_fullscreen if fullscreen?
    LibRay.set_target_fps(target_fps)
    LibRay.init_audio_device if audio?
  end

  def setup
  end

  def run
    setup

    while running?
      update(Time.frame_time)

      draw_wrapper
    end

    close
  end

  def update(_frame_time)
  end

  def draw
  end

  def draw_wrapper
    LibRay.begin_drawing
    LibRay.clear_background(background_color.to_struct)

    draw

    LibRay.draw_fps(0, 0) if draw_fps?
    LibRay.end_drawing
  end

  def self.to_degrees(radians : Int32 | Float32 | Float64)
    radians * 180 / Math::PI
  end

  def self.screen_width
    LibRay.get_screen_width
  end

  def self.screen_height
    LibRay.get_screen_height
  end

  def screen_width
    self.class.screen_width
  end

  def screen_height
    self.class.screen_height
  end

  def should_close?
    LibRay.window_should_close?
  end

  def running?
    !should_close? && !close?
  end

  def close?
    false
  end

  def close
    if audio?
      Sound.unload_all
      LibRay.close_audio_device if audio?
    end

    LibRay.close_window
  end

  def self.camera=(camera : Camera)
    @@camera = camera
  end

  def self.camera
    @@camera
  end

  def self.begin_3d
    LibRay.begin_mode_3d(camera.to_struct)
  end

  def self.end_3d
    LibRay.end_mode_3d
  end
end
