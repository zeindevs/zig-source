const std = @import("std");
const user = @import("models/user.zig");
const User = user.User;
const MAX_POWER = user.MAX_POWER;

pub fn main() !void {
    const goku: User = .{
        .power = 9001,
        .name = "Goku",
    };

    std.debug.print("{s}'s power is {d}\n", .{ goku.name, goku.power });

    goku.diagnose();

    User.diagnose(goku);

    const sum = add(8999, 2);
    std.debug.print("8999 + 2 = {d}\n", .{sum});

    const a = [5]i32{ 1, 2, 3, 4, 5 };
    const b: [5]i32 = .{ 1, 2, 3, 4, 5 };
    const c = [_]i32{ 1, 2, 3, 4, 5 };

    std.debug.print("a {any}\n", .{a});
    std.debug.print("b {any}\n", .{b});
    std.debug.print("c {any}\n", .{c});

    var end: usize = 4;
    end += 1;
    const d = a[1..end];

    std.debug.print("{any}\n", .{d});

    std.debug.print("{any}\n", .{@TypeOf(.{ .year = 202, .month = 8 })});
}

fn add(a: i64, b: i64) i64 {
    return a + b;
}
