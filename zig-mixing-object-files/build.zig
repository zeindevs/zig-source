const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const obj = b.addObject(.{
        .name = "base64",
        .root_source_file = b.path("base64.zig"),
        .target = target,
        .optimize = optimize,
    });

    const exe = b.addExecutable(.{
        .name = "test",
        .target = target,
        .optimize = optimize,
    });

    exe.addCSourceFile(.{ .file = b.path("test.c"), .flags = &.{"-std=c99"} });
    exe.addObject(obj);
    exe.linkSystemLibrary("c");
    b.installArtifact(exe);
}
