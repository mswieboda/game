class Game::Time
  property start_time : Float64

  def self.get
    LibRay.get_time
  end

  def self.frame_time
    LibRay.get_frame_time
  end

  def initialize(@start_time = 0.0, start = false)
    self.start if start
  end

  def start
    @start_time = self.class.get
  end

  def get
    return 0.0 if @start_time <= 0.0
    time = self.class.get - @start_time
    return 0.0 if time <= 0.0
    time
  end
end
