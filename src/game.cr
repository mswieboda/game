require "cray"

require "./game/**"

class Game
  include Keys

  getter name : String
  getter target_fps : Int32
  getter background_color : Color
  getter? fullscreen : Bool
  getter? resizeable : Bool
  getter? audio : Bool
  getter? debug : Bool
  getter? draw_fps : Bool

  getter frame_time : Float32

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

  def initialize(
    @name = NAME,
    @fullscreen = FULLSCREEN,
    screen_width = nil,
    screen_height = nil,
    @target_fps = TARGET_FPS,
    @background_color = BACKGROUND_COLOR,
    @resizeable = RESIZEABLE,
    @audio = AUDIO,
    @debug = DEBUG,
    @draw_fps = DRAW_FPS
  )
    @frame_time = 0_f32

    LibRay.set_config_flags(LibRay::FLAG_WINDOW_RESIZABLE) if resizeable?
    LibRay.init_window(screen_width || SCREEN_WIDTH, screen_height || SCREEN_HEIGHT, name)

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
      set_frame_time

      update(frame_time)

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

  def set_frame_time
    @frame_time = LibRay.get_frame_time
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
end
