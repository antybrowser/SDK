const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const antybrowser_mod = b.addModule("antybrowser", .{
        .root_source_file = b.path("src/antybrowser.zig"),
        .target = target,
        .optimize = optimize,
    });

    const lib = b.addStaticLibrary(.{
        .name = "antybrowser",
        .root_source_file = b.path("src/antybrowser.zig"),
        .target = target,
        .optimize = optimize,
    });
    b.installArtifact(lib);

    const lib_tests = b.addTest(.{
        .root_source_file = b.path("src/antybrowser.zig"),
        .target = target,
        .optimize = optimize,
    });
    const run_lib_tests = b.addRun(lib_tests);
    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_lib_tests.step);
}
