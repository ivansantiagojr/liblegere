const std = @import("std");

pub fn isAlphanumeric(codepoint: u21) bool {
    return switch (codepoint) {
        'A'...'Z', 'a'...'z', '0'...'9' => true,
        // Latin-1 Supplement: covers á à â ã ä å æ ç è é ê ë etc.
        0x00C0...0x00D6 => true,
        0x00D8...0x00F6 => true,
        0x00F8...0x00FF => true,
        else => false,
    };
}

test "isAlphanumeric accepts basic latin letters" {
    try std.testing.expect(isAlphanumeric('a'));
    try std.testing.expect(isAlphanumeric('z'));
    try std.testing.expect(isAlphanumeric('A'));
    try std.testing.expect(isAlphanumeric('Z'));
}

test "isAlphanumeric accepts digits" {
    try std.testing.expect(isAlphanumeric('0'));
    try std.testing.expect(isAlphanumeric('9'));
}

test "isAlphanumeric accepts letters with accents" {
    try std.testing.expect(isAlphanumeric('á'));
    try std.testing.expect(isAlphanumeric('ã'));
    try std.testing.expect(isAlphanumeric('â'));
    try std.testing.expect(isAlphanumeric('à'));
    try std.testing.expect(isAlphanumeric('ç'));
    try std.testing.expect(isAlphanumeric('é'));
    try std.testing.expect(isAlphanumeric('ê'));
    try std.testing.expect(isAlphanumeric('í'));
    try std.testing.expect(isAlphanumeric('ó'));
    try std.testing.expect(isAlphanumeric('ô'));
    try std.testing.expect(isAlphanumeric('õ'));
    try std.testing.expect(isAlphanumeric('ú'));
    try std.testing.expect(isAlphanumeric('ü'));
}

test "isAlphanumeric rejects punctuation" {
    try std.testing.expect(!isAlphanumeric('.'));
    try std.testing.expect(!isAlphanumeric(','));
    try std.testing.expect(!isAlphanumeric('!'));
    try std.testing.expect(!isAlphanumeric('?'));
    try std.testing.expect(!isAlphanumeric(';'));
    try std.testing.expect(!isAlphanumeric(':'));
}

test "isAlphanumeric rejects whitespace" {
    try std.testing.expect(!isAlphanumeric(' '));
    try std.testing.expect(!isAlphanumeric('\n'));
    try std.testing.expect(!isAlphanumeric('\t'));
}

test "isAlphanumeric rejects emojis" {
    try std.testing.expect(!isAlphanumeric('🦎'));
    try std.testing.expect(!isAlphanumeric('🎉'));
}

test "isAlphanumeric rejects symbols" {
    try std.testing.expect(!isAlphanumeric('©'));
    try std.testing.expect(!isAlphanumeric('€'));
    try std.testing.expect(!isAlphanumeric('™'));
}
