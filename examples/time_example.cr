require "../src/game"

class TimeExample < Game::Game
  def initialize
    super(name: "Time Example")

    @time = Game::Text.new(
      text: "time: 0.00000",
      size: 30,
      spacing: 10,
      color: Game::Color::Lime
    )

    @frame_time = Game::Text.new(
      text: "frame_time: 0.00000",
      size: 30,
      spacing: 10,
      color: Game::Color::Lime
    )
  end

  def setup
    x = screen_width / 2
    y = screen_height / 2
    margin = 25

    @time.x = x - @time.width / 2
    @time.y = y - @time.height / 2

    @frame_time.x = x - @frame_time.width / 2
    @frame_time.y = y + @time.height + margin - @frame_time.height / 2
  end

  def update(_frame_time)
    @time.text = "time: #{Game::Time.get.round(5)}"
    @frame_time.text = "frame time: #{Game::Time.frame_time.round(5)}"
  end

  def draw
    @time.draw
    @frame_time.draw
  end
end

TimeExample.new.run
