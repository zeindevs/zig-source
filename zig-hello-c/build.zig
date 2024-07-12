const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addSharedLibrary(.{
        .name = "mathtest",
        .root_source_file = b.path("mathtest.zig"),
        .target = target,
        .optimize = optimize,
    });
    const exe = b.addExecutable(.{
        .name = "test",
        .target = target,
        .optimize = optimize,
    });
    exe.addCSourceFile(.{ .file = b.path("test.c"), .flags = &[_][]const u8{"-std=c99"} });
    exe.linkLibrary(lib);
    exe.linkSystemLibrary("c");

    b.default_step.dependOn(&exe.step);
    b.installArtifact(exe);
}
