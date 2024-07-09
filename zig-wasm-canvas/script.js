let memory = new WebAssembly.Memory({
  initial: 2,
  maximum: 2,
});

let importObject = {
  env: {
    consoleLog: (arg) => console.log(arg),
    memory: memory,
  },
};

WebAssembly.instantiateStreaming(
  fetch("zig-out/bin/zig-wasm-canvas.wasm"),
  importObject,
).then((result) => {
  const wasmMemoryArray = new Uint8Array(memory.buffer);

  const checkerboardSize = result.instance.exports.getCheckerboardSize();
  const canvas = document.getElementById("canvas");
  canvas.width = checkerboardSize;
  canvas.height = checkerboardSize;

  const context = canvas.getContext("2d");
  const imageData = context.createImageData(canvas.width, canvas.height);
  context.clearRect(0, 0, canvas.width, canvas.height);

  const getDarkValue = () => {
    return Math.floor(Math.random() * 100);
  };
  const getLightValue = () => {
    return Math.floor(Math.random() * 127) + 127;
  };

  const drawCheckerboard = () => {
    result.instance.exports.colorCheckerboard(
      getDarkValue(),
      getDarkValue(),
      getDarkValue(),
      getLightValue(),
      getLightValue(),
      getLightValue(),
    );

    const bufferOffset = result.instance.exports.getCheckerboardBufferPointer();
    const imageDataArray = wasmMemoryArray.slice(
      bufferOffset,
      bufferOffset + checkerboardSize * checkerboardSize * 4,
    );

    imageData.data.set(imageDataArray);

    context.clearRect(0, 0, canvas.width, canvas.height);
    context.putImageData(imageData, 0, 0);
  };

  drawCheckerboard();
  console.log(memory.buffer);
  setInterval(() => {
    drawCheckerboard();
  }, 1000);
});
