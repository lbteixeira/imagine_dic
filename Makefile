MAKEFLAGS += --silent

.PHONY: debug
debug:
		cmake -D CMAKE_EXPORT_COMPILE_COMMANDS=1 -D CMAKE_BUILD_TYPE="Debug" -S . -B build/debug/
		cp build/debug/compile_commands.json .
		cmake --build ./build/debug

.PHONY: release
release:
		cmake -D CMAKE_EXPORT_COMPILE_COMMANDS=1 -D CMAKE_BUILD_TYPE="Release" -S . -B build/release/
		cp build/release/compile_commands.json .
		cmake --build ./build/release

.PHONY: test
test:
		cmake -D CMAKE_EXPORT_COMPILE_COMMANDS=1 -D IMAGINE_BUILD_TESTS="ON" -D CMAKE_BUILD_TYPE="Debug" -S . -B build/debug
		cmake --build ./build/debug
		ctest --test-dir ./build/debug/tests/imagine/ --output-on-failure

.PHONY: valgrind
valgrind: test
		cmake --build ./build/debug -t memcheck-imagine_tests

.PHONY: valgrind-app
valgrind-app: debug
		cmake --build ./build/debug -t memcheck-imagine_app

.PHONY: doc-lib
doc-lib: debug
		cmake --build ./build/debug -t doxygen-imagine_static

.PHONY: doc-app
doc-app: debug
		cmake --build ./build/debug -t doxygen-imagine_app

.PHONY: clean
clean:
		rm -rf build/debug/*
		rm -rf build/release/*
