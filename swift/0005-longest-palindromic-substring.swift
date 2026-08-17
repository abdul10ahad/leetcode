/**
 * 5. Longest Palindromic Substring
 * https://leetcode.com/problems/longest-palindromic-substring/
 *
 * Given a string `s`, return the longest palindromic substring in `s`.
 *
 * ── Pattern: Expand Around Center ───────────────────────────────────────────
 * A palindrome is symmetric around a center. In a string of length n there
 * are exactly 2n - 1 possible centers:
 *   • n centers that sit ON a character       -> odd-length palindromes ("aba")
 *   • n - 1 centers that sit BETWEEN two chars -> even-length palindromes ("abba")
 *
 * Brute force checks every substring for the palindrome property: O(n^3).
 * Expand-around-center instead starts AT each of the 2n - 1 centers and
 * grows left/right one step at a time only while both ends still match.
 * Each center's expansion is O(n) worst case, so the whole scan is O(n^2)
 * time and O(1) *extra* space (besides the O(n) character buffer we read from
 * and the answer we return).
 */
final class Solution {
    func longestPalindrome(_ s: String) -> String {
        // Array(s) gives O(1) random-access indexing; subscripting a String
        // directly by integer offset would be O(n) per access because
        // String is a collection of Characters (which can be multi-scalar
        // grapheme clusters), not a fixed-stride buffer.
        let chars = Array(s)
        guard chars.count > 1 else { return s }

        var best = 0..<1 // half-open range into `chars`; starts as "first char"

        // `center` walks every one of the 2n - 1 candidate centers.
        // For center = 2k   -> odd case,  single character k is the pivot.
        // For center = 2k+1 -> even case, the gap between k and k+1 is the pivot.
        for center in 0..<(2 * chars.count - 1) {
            var left = center / 2
            var right = left + center % 2 // even center -> right starts one past left

            while left >= 0, right < chars.count, chars[left] == chars[right] {
                left -= 1
                right += 1
            }
            // The while loop always overshoots by exactly one step on both
            // sides right before it fails, so pull `left` back in to land on
            // the actual palindrome boundaries. (`right` is already correct
            // as an exclusive upper bound.)
            left += 1

            if right - left > best.count {
                best = left..<right
            }
        }

        return String(chars[best])
    }
}
