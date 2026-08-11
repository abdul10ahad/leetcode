/**
 * Question Link: https://leetcode.com/problems/longest-palindromic-substring/
 *
 * Pattern: Strings — Expand Around Center
 * Time:  O(n^2)  — up to 2n centers, each expansion can walk O(n)
 * Space: O(n)    — Array(s) copy of the characters (O(1) extra beyond that)
 */

class Solution {
    func longestPalindrome(_ s: String) -> String {
        let chars = Array(s)
        guard chars.count > 1 else { return s }

        var start = 0
        var maxLength = 1

        // Grows outward from (left, right) while both sides match,
        // then records the window if it beats the best seen so far.
        func expand(_ left: Int, _ right: Int) {
            var l = left
            var r = right
            while l >= 0, r < chars.count, chars[l] == chars[r] {
                l -= 1
                r += 1
            }
            let length = r - l - 1
            if length > maxLength {
                maxLength = length
                start = l + 1
            }
        }

        for i in 0..<chars.count {
            expand(i, i)      // odd-length palindromes, e.g. "aba" centered on "b"
            expand(i, i + 1)  // even-length palindromes, e.g. "abba" centered between the "bb"
        }

        return String(chars[start..<(start + maxLength)])
    }
}
