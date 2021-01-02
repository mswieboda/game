default: run_examples

build:
	mkdir -p build

build/release: build
	mkdir -p build/release


# Assets
assets: build
	cp -r examples/assets build/

release_assets: build/release
	cp -r examples/assets build/release/


# Hello World
build_hello_world_example: build
	env LIBRARY_PATH="$(PWD)/lib_ext" crystal build examples/hello_world_example.cr --error-trace -o build/hello_world_example

build_release_hello_world_example: build/release
	env LIBRARY_PATH="$(PWD)/lib_ext" crystal build --release --no-debug examples/hello_world_example.cr -o build/release/hello_world_example

run_hello_world_example: build_hello_world_example
	env LD_LIBRARY_PATH="$(PWD)/lib_ext" ./build/hello_world_example

run_release_hello_world_example: build_release_hello_world_example
	env LD_LIBRARY_PATH="$(PWD)/lib_ext" ./build/release/hello_world_example


# Shapes
build_shapes_example: build
	env LIBRARY_PATH="$(PWD)/lib_ext" crystal build examples/shapes_example.cr --error-trace -o build/shapes_example

build_release_shapes_example: build/release
	env LIBRARY_PATH="$(PWD)/lib_ext" crystal build --release --no-debug examples/shapes_example.cr --error-trace -o build/release/shapes_example

run_shapes_example: build_shapes_example
	env LD_LIBRARY_PATH="$(PWD)/lib_ext" ./build/shapes_example

run_release_shapes_example: build_release_shapes_example
	env LD_LIBRARY_PATH="$(PWD)/lib_ext" ./build/release/shapes_example


# Keys
build_keys_example: build
	env LIBRARY_PATH="$(PWD)/lib_ext" crystal build examples/keys_example.cr --error-trace -o build/keys_example

build_release_keys_example: build/release
	env LIBRARY_PATH="$(PWD)/lib_ext" crystal build --release --no-debug examples/keys_example.cr -o build/release/keys_example

run_keys_example: build_keys_example
	env LD_LIBRARY_PATH="$(PWD)/lib_ext" ./build/keys_example

run_release_keys_example: build_release_keys_example
	env LD_LIBRARY_PATH="$(PWD)/lib_ext" ./build/release/keys_example


# Colors
build_colors_example: build
	env LIBRARY_PATH="$(PWD)/lib_ext" crystal build examples/colors_example.cr --error-trace -o build/colors_example

build_release_colors_example: build/release
	env LIBRARY_PATH="$(PWD)/lib_ext" crystal build --release --no-debug examples/colors_example.cr -o build/release/colors_example

run_colors_example: build_colors_example
	env LD_LIBRARY_PATH="$(PWD)/lib_ext" ./build/colors_example

run_release_colors_example: build_release_colors_example
	env LD_LIBRARY_PATH="$(PWD)/lib_ext" ./build/release/colors_example


# Textures
build_textures_example: assets
	env LIBRARY_PATH="$(PWD)/lib_ext" crystal build examples/textures_example.cr --error-trace -o build/textures_example

build_release_textures_example: release_assets
	env LIBRARY_PATH="$(PWD)/lib_ext" crystal build --release --no-debug examples/textures_example.cr -o build/release/textures_example

run_textures_example: build_textures_example
	env LD_LIBRARY_PATH="$(PWD)/lib_ext" ./build/textures_example

run_release_textures_example: build_release_textures_example
	env LD_LIBRARY_PATH="$(PWD)/lib_ext" ./build/release/textures_example

# Sound
build_sound_example: assets
	env LIBRARY_PATH="$(PWD)/lib_ext" crystal build examples/sound_example.cr --error-trace -o build/sound_example

build_release_sound_example: build/release
	env LIBRARY_PATH="$(PWD)/lib_ext" crystal build --release --no-debug examples/sound_example.cr -o build/release/sound_example

run_sound_example: build_sound_example
	env LD_LIBRARY_PATH="$(PWD)/lib_ext" ./build/sound_example

run_release_sound_example: build_release_sound_example
	env LD_LIBRARY_PATH="$(PWD)/lib_ext" ./build/release/sound_example

# Time
build_time_example: build
	env LIBRARY_PATH="$(PWD)/lib_ext" crystal build examples/time_example.cr -o build/time_example

build_release_time_example: release_assets
	env LIBRARY_PATH="$(PWD)/lib_ext" crystal build --release --no-debug examples/time_example.cr -o build/release/time_example

run_time_example: build_time_example
	env LD_LIBRARY_PATH="$(PWD)/lib_ext" ./build/time_example

run_release_time_example: build_release_time_example
	env LD_LIBRARY_PATH="$(PWD)/lib_ext" ./build/release/time_example


# 3D
build_three_d_example: build
	env LIBRARY_PATH="$(PWD)/lib_ext" crystal build examples/three_d_example.cr -o build/three_d_example

build_release_three_d_example: release_assets
	env LIBRARY_PATH="$(PWD)/lib_ext" crystal build --release --no-debug examples/three_d_example.cr -o build/release/three_d_example

run_three_d_example: build_three_d_example
	env LD_LIBRARY_PATH="$(PWD)/lib_ext" ./build/three_d_example

run_release_three_d_example: build_release_three_d_example
	env LD_LIBRARY_PATH="$(PWD)/lib_ext" ./build/release/three_d_example


# All Examples
build_examples: build_hello_world_example build_shapes_example build_keys_example build_colors_example build_textures_example build_sound_example build_time_example build_three_d_example

build_release_examples: build_release_hello_world_example build_release_shapes_example build_release_keys_example build_release_colors_example build_release_textures_example build_release_sound_example build_release_time_example build_release_three_d_example

run_examples: build_examples run_hello_world_example run_shapes_example run_keys_example run_colors_example run_textures_example run_sound_example run_time_example run_three_d_example

run_release_examples: build_release_examples run_release_hello_world_example run_release_shapes_example run_release_keys_example run_release_colors_example run_release_textures_example run_release_sound_example run_release_time_example run_release_three_d_example
