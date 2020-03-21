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
    @screen_width = SCREEN_WIDTH,
    @screen_height = SCREEN_HEIGHT,
    @target_fps = TARGET_FPS,
    @background_color = BACKGROUND_COLOR,
    @resizeable = RESIZEABLE,
    @audio = AUDIO,
    @debug = DEBUG,
    @draw_fps = DRAW_FPS
  )
    @frame_time = 0_f32

    LibRay.set_config_flags(LibRay::FLAG_WINDOW_RESIZABLE) if resizeable?
    LibRay.init_window(@screen_width, @screen_height, name)
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

      update

      draw_wrapper
    end

    close
  end

  def update
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

  def screen_width
    LibRay.get_screen_width
  end

  def screen_height
    LibRay.get_screen_height
  end

  def set_frame_time
    @frame_time = LibRay.get_frame_time
  end

  def should_close?
    LibRay.window_should_close?
  end

  def running?
    !should_close?
  end

  def close
    LibRay.close_audio_device if audio?

    LibRay.close_window
  end
end
