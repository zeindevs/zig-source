build:
	zig build-exe hello.zig

build-release:
	zig build-exe hello.zig -O ReleaseSafe -fstrip -fsingle-threaded

build-small:
	zig build-exe hello.zig -O ReleaseSmall -fstrip -fsingle-threaded -target x86_64-windows
