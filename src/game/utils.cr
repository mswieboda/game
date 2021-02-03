abstract class Game::Utils
  def self.expand_path(path)
    if path.starts_with?(".")
      exec_path = Process.executable_path || ""
      last_slash_index = exec_path.rindex('/')
      exec_path = exec_path[0..last_slash_index]

      Path[exec_path].join(path).normalize.to_s
    else
      Path[path].normalize.to_s
    end
  end

  def self.to_radians(degrees : Int32 | Float32)
    degrees * Math::PI / 180
  end

  def self.to_degrees(radians : Int32 | Float32)
    radians * 180 / Math::PI
  end
end
