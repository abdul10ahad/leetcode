/**
 * Question Link: https://leetcode.com/problems/longest-palindromic-substring/
 *
 * Pattern: Two Pointers — Expand Around Center
 * Time:  O(n^2)  — n centers, each expansion can take up to O(n)
 * Space: O(1)    — excluding the result String itself
 */
class Solution {
    func longestPalindrome(_ s: String) -> String {
        let chars = Array(s)
        guard chars.count > 1 else { return s }

        var start = 0
        var maxLength = 1

        func expand(_ left: Int, _ right: Int) {
            var l = left
            var r = right
            while l >= 0, r < chars.count, chars[l] == chars[r] {
                let currentLength = r - l + 1
                if currentLength > maxLength {
                    start = l
                    maxLength = currentLength
                }
                l -= 1
                r += 1
            }
        }

        for center in 0..<chars.count {
            expand(center, center)       // odd-length palindrome, e.g. "bab"
            expand(center, center + 1)   // even-length palindrome, e.g. "abba"
        }

        return String(chars[start..<(start + maxLength)])
    }
}
