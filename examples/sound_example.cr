require "../src/game"

class SoundExample < Game::Game
  def initialize
    super(name: "Sound Example", audio: true)

    @text = Game::Text.new(
      text: "press SPACE to play sound",
      size: 30,
      spacing: 10,
      color: Game::Color::Green
    )

    # load all sounds after initializing the game
    Game::Sound.load([
      {name: "test", filename: "./assets/sound.wav", volume: 0.5_f32, pitch: 0.5_f32},
    ])

    # instantiates a new sound
    @sound = Game::Sound.get("test")
  end

  def setup
    @text.x = screen_width / 2.0 - @text.width / 2.0
    @text.y = screen_height / 2.0 - @text.height / 2.0
  end

  def update(_frame_time)
    if Game::Key::Space.pressed?
      @sound.randomize_pitch(min: 0.5_f32, max: 1.5_f32)
      @sound.play
    end
  end

  def draw
    @text.draw
  end
end

SoundExample.new.run
