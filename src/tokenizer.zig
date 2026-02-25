const std = @import("std");

pub fn countWords(text: []const u8) usize {
    var count: usize = 0;
    var it = std.mem.tokenizeAny(u8, text, " ");
    while (it.next()) |_| {
        count += 1;
    }

    return count;
}

test "countWords with single word" {
    try std.testing.expectEqual(1, countWords("hello"));
}

test "countWords with single word and punctuation" {
    try std.testing.expectEqual(1, countWords("hello."));
    try std.testing.expectEqual(1, countWords("hello,"));
    try std.testing.expectEqual(1, countWords("hello;"));
}

test "countWords with two words and punctuation" {
    try std.testing.expectEqual(2, countWords("hello world"));
    try std.testing.expectEqual(2, countWords("hello, world!"));
}

test "countWords with complex sentences" {
    try std.testing.expectEqual(7, countWords("All your codebase are belong to us!"));
}

test "countWords with trailing and leading spaces" {
    try std.testing.expectEqual(1, countWords("   hello"));
    try std.testing.expectEqual(1, countWords("hello   "));
    try std.testing.expectEqual(1, countWords("   hello   "));
}

test "countWords with multiple irregular spaces" {
    try std.testing.expectEqual(7, countWords("All    your  codebase are belong    to us!  "));
}

test "countWords considers characters between spaces as a word" {
    try std.testing.expectEqual(2, countWords("Hello !"));
}
