abstract class Game::Utils
  def self.expand_path(path)
    if path.starts_with?(".")
      exec_path = Process.executable_path || ""
      last_slash_index = exec_path.rindex('/')
      exec_path = exec_path[0..last_slash_index]

      path = File.join(exec_path, "#{path}")
    else
      path
    end
  end
end
