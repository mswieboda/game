default: run_examples

build:
	mkdir -p build

build/release: build
	mkdir -p build/release


# Hello World
build/hello_world_example: build
	env LIBRARY_PATH="$(PWD)/lib_ext" crystal build examples/hello_world_example.cr -o build/hello_world_example

build/release/hello_world_example: build/release
	env LIBRARY_PATH="$(PWD)/lib_ext" crystal build --release --no-debug examples/hello_world_example.cr -o build/release/hello_world_example

run_hello_world_example: build/hello_world_example
	env LD_LIBRARY_PATH="$(PWD)/lib_ext" ./build/hello_world_example

run_release_hello_world_example: build/release/hello_world_example
	env LD_LIBRARY_PATH="$(PWD)/lib_ext" ./build/release/hello_world_example


# Entities
build/shapes_example: build
	env LIBRARY_PATH="$(PWD)/lib_ext" crystal build examples/shapes_example.cr -o build/shapes_example

build/release/shapes_example: build/release
	env LIBRARY_PATH="$(PWD)/lib_ext" crystal build --release --no-debug examples/shapes_example.cr -o build/release/shapes_example

run_shapes_example: build/shapes_example
	env LD_LIBRARY_PATH="$(PWD)/lib_ext" ./build/shapes_example

run_release_shapes_example: build/release/shapes_example
	env LD_LIBRARY_PATH="$(PWD)/lib_ext" ./build/release/shapes_example


# Hello World
build/keys_example: build
	env LIBRARY_PATH="$(PWD)/lib_ext" crystal build examples/keys_example.cr -o build/keys_example

build/release/keys_example: build/release
	env LIBRARY_PATH="$(PWD)/lib_ext" crystal build --release --no-debug examples/keys_example.cr -o build/release/keys_example

run_keys_example: build/keys_example
	env LD_LIBRARY_PATH="$(PWD)/lib_ext" ./build/keys_example

run_release_keys_example: build/release/keys_example
	env LD_LIBRARY_PATH="$(PWD)/lib_ext" ./build/release/keys_example


# All Examples
build_examples: build/hello_world_example build/shapes_example build/keys_example

build_release_examples: build/release/hello_world_example build/release/shapes_example build/release/keys_example

run_examples: build_examples run_hello_world_example run_shapes_example run_keys_example

run_release_examples: build_release_examples run_release_hello_world_example run_release_shapes_example run_release_keys_example
