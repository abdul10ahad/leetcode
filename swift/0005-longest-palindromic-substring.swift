/**
 * Question Link: https://leetcode.com/problems/longest-palindromic-substring/
 *
 * Pattern: Two Pointers — "Expand Around Center"
 *
 * Given a string `s`, return the longest substring of `s` that reads the
 * same forwards and backwards.
 *
 * Key insight:
 * Every palindrome mirrors around a center, and that center is one of two
 * shapes:
 *   - a single character, for odd-length palindromes like "bab"
 *   - the gap between two characters, for even-length palindromes like "bb"
 *
 * A string of length `n` has exactly `n` character centers and `n - 1` gap
 * centers. If we try expanding outward from every one of them and keep the
 * widest match that stays a palindrome, we're guaranteed to find the
 * longest palindromic substring — because whatever the answer is, its own
 * center is one of the ones we tried.
 *
 * Time complexity:  O(n^2) — n centers, each expansion is O(n) worst case
 *                    (e.g. "aaaaaa").
 * Space complexity: O(n) for the `Array(s)` snapshot, O(1) extra otherwise.
 */

class Solution {
    func longestPalindrome(_ s: String) -> String {
        let chars = Array(s)
        guard !chars.isEmpty else { return "" }

        var start = 0
        var maxLength = 1

        // Expands outward from `left`/`right` while both sides match, then
        // records the range if it beats the best palindrome seen so far.
        func expand(_ left: Int, _ right: Int) {
            var l = left
            var r = right
            while l >= 0, r < chars.count, chars[l] == chars[r] {
                l -= 1
                r += 1
            }
            // The loop always overshoots by one step on both sides (or hits
            // an array bound), so the real palindrome sits strictly inside
            // that window: chars[l+1...r-1].
            let length = r - l - 1
            if length > maxLength {
                maxLength = length
                start = l + 1
            }
        }

        for center in 0..<chars.count {
            expand(center, center)       // odd-length palindrome, e.g. "bab"
            expand(center, center + 1)   // even-length palindrome, e.g. "bb"
        }

        return String(chars[start..<start + maxLength])
    }
}
