const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const libfizzbuzz = b.addSharedLibrary(.{
        .name = "fizzbuzz",
        .root_source_file = b.path("fizzbuzz.zig"),
        .target = target,
        .optimize = optimize,
        .version = .{ .major = 1, .minor = 2, .patch = 3 },
    });

    const exe = b.addExecutable(.{
        .name = "demo",
        .root_source_file = b.path("demo.zig"),
        .target = target,
        .optimize = optimize,
    });

    b.installArtifact(libfizzbuzz);

    exe.linkLibrary(libfizzbuzz);

    if (b.option(bool, "enable-demo", "install the demo too") orelse false) {
        b.installArtifact(exe);
    }
}
