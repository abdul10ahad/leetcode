/**
 * Question Link: https://leetcode.com/problems/longest-palindromic-substring/
 *
 * Approach: Expand Around Center
 * Time:  O(n^2) — n possible centers, each expansion up to O(n)
 * Space: O(n)   — for the Array(s) conversion (O(1) extra beyond that)
 */

class Solution {
    func longestPalindrome(_ s: String) -> String {
        let chars = Array(s)
        guard chars.count > 1 else { return s }

        var start = 0
        var maxLength = 1

        func expand(_ left: Int, _ right: Int) {
            var l = left, r = right
            while l >= 0, r < chars.count, chars[l] == chars[r] {
                let length = r - l + 1
                if length > maxLength {
                    start = l
                    maxLength = length
                }
                l -= 1
                r += 1
            }
        }

        for i in 0..<chars.count {
            expand(i, i)      // odd-length palindromes, centered on i
            expand(i, i + 1)  // even-length palindromes, centered between i and i+1
        }

        return String(chars[start..<(start + maxLength)])
    }
}
