class Sound
  getter sound : LibRay::Sound
  getter volume : Float32
  getter pitch : Float32

  @@sounds = Hash(String, Sound).new

  DEBUG = false

  def self.load(sounds : Array(NamedTuple(name: String, filename: String, volume: Float32 | Nil, pitch: Float32 | Nil)))
    sounds.each { |sound| load(sound[:name], sound[:filename], sound[:volume], sound[:pitch]) }
  end

  def self.load(name : String, filename : String, volume : Float32 | Nil, pitch : Float32 | Nil)
    puts "loading sound: #{name}" if DEBUG

    bin_dir = Process.executable_path || ""
    last_slash_index = bin_dir.rindex('/')
    bin_dir = bin_dir[0..last_slash_index]

    full_path = File.join(bin_dir, "#{filename}")

    @@sounds[name] ||= Sound.new(
      filename: full_path,
      volume: volume,
      pitch: pitch
    )

    sound = @@sounds[name]

    puts "loaded sound: #{name}" if DEBUG

    sound
  end

  def self.get(name) : Sound
    puts "getting sound: #{name}" if DEBUG

    unless @@sounds.has_key?(name)
      raise "sound: #{name} not found, make sure to load first with Sound.load before using"
    end

    sound = @@sounds[name]

    puts "got sound: #{name}" if DEBUG

    sound
  end

  def self.unload_all
    @@sounds.each do |(_name, sound)|
      sound.stop if sound.playing?
    end

    @@sounds.each do |(_name, sound)|
      sound.unload
    end
  end

  def initialize(filename : String, volume = 1_f32, pitch = 1_f32)
    @pitch = 1_f32
    @volume = 1_f32
    @sound = LibRay::Sound.new

    load(filename)

    self.volume = volume if volume
    self.pitch = pitch if pitch
  end

  def load(filename : String)
    puts "LibRay loading sound: #{filename}" if DEBUG

    @sound = LibRay.load_sound(filename)

    puts "LibRay loaded sound: #{filename}" if DEBUG

    @sound
  end

  # setters for instance to Sound.xyz(sound, value)
  # and helpers for randomize_xyz
  {% for name in [:volume, :pitch] %}
    def {{name.id}}=(value : Float32)
      @{{name.id}} = value
      self.class.{{name.id}}(@sound, value)
    end

    def randomize_{{name.id}}(min : Float32 = 0.5_f32, max : Float32 = 1.5_f32)
      self.{{name.id}} = (min + rand(1.0)).to_f32
    end
  {% end %}

  # wrappers for instance to Sound.xyz(sound)
  {% for name in [:playing?, :play, :stop, :pause, :resume, :unload] %}
    def {{name.id}}
      self.class.{{name.id}}(@sound)
    end
  {% end %}

  def self.playing?(sound : LibRay::Sound)
    LibRay.sound_playing?(sound)
  end

  # LibRay wrappers
  {% for name in [:play, :stop, :pause, :resume, :unload] %}
    def self.{{name.id}}(sound : LibRay::Sound)
      LibRay.{{name.id}}_sound(sound)
    end
  {% end %}

  # LibRay setter wrappers
  {% for name in [:volume, :pitch] %}
    def self.{{name.id}}(sound : LibRay::Sound, value : Float32)
      LibRay.set_sound_{{name.id}}(sound, value)
    end
  {% end %}
end
