const JS = @import("js.zig");

export fn step(timestamp: f32) void {
    JS.Console.log("timestamp: {}\n", .{timestamp});
}
