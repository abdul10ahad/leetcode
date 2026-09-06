// Day 1 — NeetCode Strings series
// LeetCode 125. Valid Palindrome
// Pattern: Two Pointers
//
// Problem
// -------
// Given a string `s`, return true if it's a palindrome after:
//   1. converting all uppercase letters to lowercase, and
//   2. removing all non-alphanumeric characters.
//
// Example: "A man, a plan, a canal: Panama" -> true
//          "race a car"                     -> false
//
// This file shows two Swift solutions, both using modern `Character` /
// `String.Index` APIs instead of NSCharacterSet or manual ASCII math.

import Foundation

class Solution {

    // MARK: - Solution A: Filter + compare (clear, O(n) extra space)
    //
    // Step-by-step:
    // 1. `s.lowercased()` normalizes case in one pass.
    // 2. `.filter { $0.isLetter || $0.isNumber }` keeps only alphanumeric
    //    Characters — `isLetter`/`isNumber` are modern Swift Character
    //    properties, Unicode-aware, no need for CharacterSet bridging.
    // 3. `cleaned.elementsEqual(cleaned.reversed())` compares the cleaned
    //    sequence against its own reverse, short-circuiting on the first
    //    mismatch — no need to build a second reversed String.
    func isPalindromeFiltered(_ s: String) -> Bool {
        let cleaned = s.lowercased().filter { $0.isLetter || $0.isNumber }
        return cleaned.elementsEqual(cleaned.reversed())
    }

    // MARK: - Solution B: True two-pointer (O(1) extra space, interview-style)
    //
    // Step-by-step flow:
    // 1. Start `left` at the first index, `right` at the last index.
    // 2. Walk `left` forward while it's not alphanumeric (skip junk).
    // 3. Walk `right` backward while it's not alphanumeric (skip junk).
    // 4. Compare the two characters case-insensitively.
    //    - Mismatch -> not a palindrome, return false immediately.
    //    - Match    -> move both pointers inward and repeat.
    // 5. Pointers cross (`left >= right`) with no mismatch -> palindrome.
    //
    // This never allocates a cleaned copy of the string, so it's the
    // version to reach for when memory matters (true LeetCode-optimal).
    func isPalindrome(_ s: String) -> Bool {
        guard !s.isEmpty else { return true }

        var left = s.startIndex
        var right = s.index(before: s.endIndex)

        while left < right {
            // Skip non-alphanumeric characters from the left.
            while left < right, !isAlphanumeric(s[left]) {
                left = s.index(after: left)
            }
            // Skip non-alphanumeric characters from the right.
            while left < right, !isAlphanumeric(s[right]) {
                right = s.index(before: right)
            }
            // Case-insensitive compare of the two candidate characters.
            if s[left].lowercased() != s[right].lowercased() {
                return false
            }
            left = s.index(after: left)
            right = s.index(before: right)
        }
        return true
    }

    private func isAlphanumeric(_ c: Character) -> Bool {
        c.isLetter || c.isNumber
    }
}

// MARK: - Complexity
// Solution A: Time O(n), Space O(n) (the filtered copy).
// Solution B: Time O(n), Space O(1) extra (aside from tiny per-character
//             `lowercased()` string allocations, which the compiler/runtime
//             typically handles cheaply for single characters).
//
// Both pointers only ever move forward/inward across the string once each,
// so total pointer movement is bounded by `s.count` — hence O(n) time.
