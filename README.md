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
      name: "FooGame"
      screen_width: 1024,
      screen_height: 768
    )
  end

  def update
  end

  def draw
  end
end

FooGame.new.run
```

`Game#run` will initialize RayLib, and begin the game loop, calling `Game#update` and `Game#draw` which are meant to be overriden with your game and drawing logic. Use the built-in classes to draw with using `#draw` or call drawing methods directly with `LibRay` (available via the [cray](http://github.com/mswieboda/cray) shard dependency).

```crystal
def draw
  # use built-in classes created in `intialize` or elsewhere to draw like Rectangle
  @rectangle.draw

  # or call LibRay draw methods directly if you'd prefer, and if this library doesn't wrap it yet, like 3D
  LibRay.draw_rectangle(x: 30, y: 30, width: 100, height: 25, color: LibRay::RED)
end
```


## Development

- [x] Game (core/window)
  - [x] basic window: title, size, fullscreen
  - [x] basic setup: fps, audio
  - [x] basic game loop: running? frame time, update, draw wrapper, draw
  - [ ] sprite loading
- [x] Shapes
  - Classes:
    - [x] Pixel
    - [x] Line
    - [x] Circle
    - [x] Ellipse
    - [x] Ring
    - [x] Rectangle
    - [x] Triangle
    - [x] Polygon
  - [ ] needs more class structure, hierarchy, shared code
  - [ ] collision detection
- [ ] Textures
  - [ ] Loading images from files
  - [ ] Loading images from code, data,
  - [ ] Loading Texture (into GPU memory) from file or image
  - [ ] Sprites
  - [ ] Animated Sprites
- [ ] Text
  - [ ] Loading Fonts
  - [ ] Drawing Text with Fonts
- [ ] Models (for 3D)
- [ ] Shaders (for 3D)
- [ ] Audio


## Contributing

1. Fork it (<https://github.com/mswieboda/game/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Matt Swieboda](https://github.com/mswieboda) - creator, maintainer
