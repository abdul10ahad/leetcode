/**
 * Question Link: https://leetcode.com/problems/longest-palindromic-substring/
 *
 * NeetCode pattern: Two Pointers — Expand Around Center
 *
 * Idea:
 *   A palindrome is symmetric around its middle. That middle is either
 *   - a single character (odd-length palindrome, e.g. "bab" centers on 'a'), or
 *   - the gap between two characters (even-length palindrome, e.g. "abba"
 *     centers on the gap between the two 'b's).
 *
 *   There are exactly (2n - 1) possible centers for a string of length n:
 *   n "on a character" centers and (n - 1) "between characters" centers.
 *   For each one, grow outward while the two sides keep matching, then
 *   remember the widest palindrome seen.
 *
 * Complexity:
 *   Time:  O(n^2)  — n centers, each can expand up to O(n) times.
 *   Space: O(1)    — only index bookkeeping (aside from the returned String).
 *
 * Modern Swift note:
 *   This walks the string using native `String.Index` (not `Array(s)` +
 *   integer offsets). That keeps every step Unicode-correct — indexing is
 *   done per-grapheme-cluster the way Swift's `String` actually models
 *   text — and lets us slice the answer directly with `s[left...right]`
 *   instead of rebuilding a `String` from a `[Character]` slice.
 */
class Solution {
    func longestPalindrome(_ s: String) -> String {
        guard !s.isEmpty else { return "" }

        // Every non-empty string has at least one palindrome: any single
        // character. Seed the answer with the very first one.
        var longest = s.startIndex...s.startIndex

        for center in s.indices {
            // 1) Odd-length palindromes: center sits ON a character, so the
            //    match at width zero is guaranteed (a char equals itself).
            if let odd = expand(s, left: center, right: center), width(s, odd) > width(s, longest) {
                longest = odd
            }

            // 2) Even-length palindromes: center sits BETWEEN `center` and
            //    the next character. Skip this at the very last index —
            //    there's no "next" character to pair it with.
            let next = s.index(after: center)
            if next < s.endIndex,
               let even = expand(s, left: center, right: next),
               width(s, even) > width(s, longest) {
                longest = even
            }
        }

        return String(s[longest])
    }

    /// Grows outward from `left`/`right` one step at a time while the
    /// characters mirror each other, returning the widest matching bounds
    /// (inclusive on both ends), or `nil` if `left`/`right` don't match at all
    /// (only possible for an even-length center whose two starting
    /// characters already differ).
    private func expand(
        _ s: String,
        left: String.Index,
        right: String.Index
    ) -> ClosedRange<String.Index>? {
        var confirmed: ClosedRange<String.Index>? = nil
        var l: String.Index? = left
        var r: String.Index? = right

        while let currentL = l, let currentR = r, s[currentL] == s[currentR] {
            // This pair matches — it's a valid (if not yet maximal) palindrome.
            confirmed = currentL...currentR

            // Step outward one character on each side, but stop offering a
            // next step once we'd fall off either end of the string.
            l = currentL == s.startIndex ? nil : s.index(before: currentL)
            let afterR = s.index(after: currentR)
            r = afterR == s.endIndex ? nil : afterR
        }

        return confirmed
    }

    /// Number of characters covered by an inclusive index range.
    private func width(_ s: String, _ range: ClosedRange<String.Index>) -> Int {
        s.distance(from: range.lowerBound, to: range.upperBound) + 1
    }
}
