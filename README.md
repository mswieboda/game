# game

Game wrapper library internally using [cray](http://github.com/mswieboda/cray) ([RayLib](http://raylib.com) bindings to Crystal).


## Installation

1. Add the dependency to your `shard.yml`:

```yaml
dependencies:
  game:
    github: mswieboda/game
```

2. Run `shards install`


## Usage

For now this is basically just an object-oriented wrapper around Cray/RayLib functionality.

Eventually will include more concepts such as a Viewport, basic Player or Player Controllers, UI messages, loading/saving, and other miscelleneous concepts to assist developing a game.

See the examples `examples/hello_world.cr` and `examples/shapes.cr` on how to use the provided classes.

Inherit your main game project class from `Game` to enable the RayLib setup and game loop.

```crystal
require "game"

class FooGame < Game
  def initialize
    super(
      name: "FooGame",
      screen_width: 1024,
      screen_height: 768
    )
  end

  def update(frame_time)
  end

  def draw
  end
end

FooGame.new.run
```

`Game#run` will initialize RayLib, and begin the game loop, calling `Game#update` and `Game#draw` which are meant to be overriden with your game and drawing logic. Use the built-in classes to draw with using `#draw` or call drawing methods directly with `LibRay` (available via the [cray](http://github.com/mswieboda/cray) shard dependency).

```crystal
def draw
  # use built-in classes created in `initialize` or elsewhere to draw, such as `Rectangle`
  @rectangle.draw

  # or call LibRay draw methods directly
  LibRay.draw_rectangle(x: 30, y: 30, width: 100, height: 25, color: Color::Red.to_struct)
end
```

Note: Since many features are currently WIP, interacting with `LibRay` directly is a valid option.


## Development
- [ ] API docs
  - [ ] auto docs with tools like https://crystal-lang.org/api and other crystal shards
  - [ ] host on github pages, or heroku, etc
- [x] Game (core)
  - [x] basic window: title, size, fullscreen (moving to Window)
  - [x] basic setup: FPS, audio
  - [x] basic game loop: running? frame time, update, draw wrapper, draw
  - [ ] set drawing mode 2D/3D
  - [ ] specific sprite pre loading `Game#load_sprites` method to override
  - [ ] specific sound pre loading `Game#load_sounds` method to override
- [ ] Window
  - [ ] Monitor
  - [ ] Clipboard
  - [ ] Cursor
- [ ] Input
  - [x] Keys
  - [x] Mouse
  - [ ] Gamepad
  - [ ] Touch
- [ ] Camera
  - [ ] Viewport
- [x] Color
- [ ] Vectors/Position/Point
  - [ ] Vector
  - [ ] Vector3D
- [x] Shapes
  - [x] Shape parent class
    - [ ] collision detection
  - [x] Pixel
  - [x] Line
  - [x] Circle
  - [x] Ellipse
  - [x] Ring
  - [x] Rectangle
  - [x] Square
  - [x] Triangle
  - [x] Polygon
- [x] Textures
  - [x] Loading images from files
  - [ ] Loading images from code, data,
  - [x] Loading Texture (into GPU memory) from file or image
  - [x] Sprites
  - [x] Animated Sprites
    - TODO:
      - [ ] reverse
      - [x] pause/stop
- [x] Text
  - [x] Loading Fonts
  - [x] Drawing Text with Fonts
- [x] Sound
  - [ ] Loading Wave
  - [x] Loading Sounds
  - [x] Play, stop, pause, resume
  - [ ]
- [ ] Entity (for inheriting game objects with functionality)
  - [ ] implement children/parent, generic containers
  - [x] SpriteEntity
  - [x] ShapeEntity
- [ ] 3D
  - [ ] Models
  - [ ] Shaders


## Contributing

1. Fork it (<https://github.com/mswieboda/game/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request


## Contributors

- [Matt Swieboda](https://github.com/mswieboda) - creator, maintainer
