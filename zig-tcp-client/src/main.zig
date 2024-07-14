const std = @import("std");
const net = std.net;
const print = std.debug.print;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();
    var args = try std.process.argsWithAllocator(allocator);

    _ = args.skip();
    const port_value = args.next() orelse {
        print("expect port as commane line arguments\n", .{});
        return error.NoPort;
    };
    const port = try std.fmt.parseInt(u16, port_value, 10);

    const peer = try net.Address.parseIp4("127.0.0.1", port);
    const stream = try net.tcpConnectToAddress(peer);
    defer stream.close();
    print("Connecting to {}\n", .{peer});

    const data = "hello zig";
    var writer = stream.writer();
    const size = try writer.write(data);
    print("Sending '{s} to peer, total written: {d} bytes\n", .{ data, size });
    // try writer.writeAll("hello zig");
}
