const std = @import("std");

pub fn main() !void {
    var args = std.process.args();
    const exe_name = args.next() orelse "zelf-serve";
    const public_path = args.next() orelse {
        std.log.err("Usage: {s} <dir to serve files from>", .{exe_name});
        return;
    };

    var dir = try std.fs.cwd().openDir(public_path, .{});
    const self_addr = try std.net.Address.resolveIp("127.0.0.1", 9000);
}
