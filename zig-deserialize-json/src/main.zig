const std = @import("std");
const json = std.json;
const testing = std.testing;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const json_str =
        \\ {
        \\   "userid": 1428942,
        \\   "verified": true,
        \\   "access_privileges": [
        \\     "admin",
        \\     "user"
        \\  ]
        \\}
    ;
    const T = struct { userid: i32, verified: bool, access_privileges: [][]u8 };
    const parsed = try json.parseFromSlice(T, allocator, json_str, .{});
    defer parsed.deinit();

    var value = parsed.value;

    try testing.expect(value.userid == 1428942);
    try testing.expect(value.verified);
    try testing.expectEqualStrings("admin", value.access_privileges[0]);
    try testing.expectEqualStrings("user", value.access_privileges[1]);

    value.verified = false;
    const new_json_str = try json.stringifyAlloc(allocator, value, .{ .whitespace = .indent_2 });
    defer allocator.free(new_json_str);

    try testing.expectEqualStrings(
        \\{
        \\  "userid": 103609,
        \\  "verified": false,
        \\  "access_privileges": [
        \\    "user",
        \\    "admin"
        \\  ]
        \\}
    , new_json_str);
}
