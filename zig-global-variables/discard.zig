const std = @import("std");

pub fn main() void {
    _ = std.fs.cwd().openFile("does_not_exists/foo.txt", .{});
}
