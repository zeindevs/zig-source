const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe_c = b.addExecutable(.{
        .name = "mainc",
        .target = target,
        .optimize = optimize,
    });
    exe_c.addCSourceFile(.{ .file = b.path("main.c"), .flags = &.{"-std=c99"} });
    exe_c.linkSystemLibrary("c");

    b.installArtifact(exe_c);
}
