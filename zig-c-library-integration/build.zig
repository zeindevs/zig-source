const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "sine",
        .root_source_file = b.path("src/sine.zig"),
        .target = target,
        .optimize = optimize,
    });

    exe.linkLibC();
    exe.addLibraryPath(b.path("vendor/soundio/include"));
    exe.addObjectFile(b.path("vendor/soundio/lib/x86_64/libsoundio.a"));

    b.installArtifact(exe);
}
