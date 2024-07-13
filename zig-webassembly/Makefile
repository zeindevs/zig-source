build-wasm:
	zig build-exe math.zig -target wasm32-freestanding -fno-entry --export=add

build-wasi:
	zig build-exe wasi_args.zig -target wasm32-wasi

build-wasi2:
	zig build-exe wasi_preopens.zig -target wasm32-wasi
