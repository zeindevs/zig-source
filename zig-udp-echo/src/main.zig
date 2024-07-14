const std = @import("std");
const net = std.net;
const posix = std.posix;
const print = std.debug.print;

pub fn main() !void {
    const addr = try net.Address.parseIp("127.0.0.1", 32100);

    const sock = try posix.socket(
        posix.AF.INET,
        posix.SOCK.DGRAM,
        posix.IPPROTO.UDP,
    );

    defer posix.close(sock);

    try posix.bind(sock, &addr.any, addr.getOsSockLen());

    var other_addr: posix.sockaddr = undefined;
    var other_addrlen: posix.socklen_t = @sizeOf(posix.sockaddr);

    var buf: [1204]u8 = undefined;

    print("Listen on {any}...\n", .{addr});

    const n_recv = try posix.recvfrom(
        sock,
        buf[0..],
        0,
        &other_addr,
        &other_addrlen,
    );
    print("received {d} byte(s) from {any};\n string: {s}\n", .{ n_recv, other_addr, buf[0..n_recv] });

    const n_sent = try posix.sendto(
        sock,
        buf[0..n_recv],
        0,
        &other_addr,
        other_addrlen,
    );
    print("echoed {d} byte(s) back\n", .{n_sent});
}
