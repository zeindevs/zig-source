const std = @import("std");
const expectEqual = std.testing.expectEqual;
const expectError = std.testing.expectError;
const parseInt = std.fmt.parseInt;
const parseFloat = std.fmt.parseFloat;
const stringToEnum = std.meta.stringToEnum;

pub fn main() !void {
    try expectEqual(parseInt(i32, "123", 10), 123);
    try expectEqual(parseInt(i32, "-123", 10), -123);
    try expectError(error.Overflow, parseInt(u4, "123", 10));

    try expectEqual(parseInt(i32, "0xf", 0), 15);
    try expectEqual(parseInt(i32, "0b1111", 0), 15);

    try expectEqual(parseInt(i32, "0o17", 0), 15);

    try expectEqual(parseFloat(f32, "1.23", 0), 1.23);
    try expectEqual(parseFloat(f32, "-1.23", 0), -1.23);

    const Color = enum {
        Red,
        Blue,
        Green,
    };
    try expectEqual(stringToEnum(Color, "Red").?, Color.Red);
    try expectEqual(stringToEnum(Color, "Yello"), null);
}
