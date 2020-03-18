default: run_examples

build:
	mkdir -p build

build_release: build
	mkdir -p build/release

build_hello_world: build
	env LIBRARY_PATH="$(PWD)/lib_ext" crystal build examples/hello_world.cr -o build/hello_world

build_release_hello_world: build_release
	env LIBRARY_PATH="$(PWD)/lib_ext" crystal build --release --no-debug examples/hello_world.cr -o build/release/hello_world

run_hello_world: build_hello_world
	env LD_LIBRARY_PATH="$(PWD)/lib_ext" ./build/hello_world

run_release_hello_world: build_release_hello_world
	env LD_LIBRARY_PATH="$(PWD)/lib_ext" ./build/release/hello_world_release

build_examples: build_hello_world

build_release_examples: build_release_hello_world

run_examples: run_hello_world

run_release_examples: run_release_hello_world
