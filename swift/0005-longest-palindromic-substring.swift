/**
 * Question Link: https://leetcode.com/problems/longest-palindromic-substring/
 */

class Solution {
    func longestPalindrome(_ s: String) -> String {
        let chars = Array(s)
        var start = 0
        var maxLength = 0

        func expandFromCenter(_ left: Int, _ right: Int) {
            var l = left
            var r = right
            while l >= 0 && r < chars.count && chars[l] == chars[r] {
                if r - l + 1 > maxLength {
                    start = l
                    maxLength = r - l + 1
                }
                l -= 1
                r += 1
            }
        }

        for i in 0..<chars.count {
            expandFromCenter(i, i)     // odd-length palindromes, center on i
            expandFromCenter(i, i + 1) // even-length palindromes, center between i and i+1
        }

        return String(chars[start..<(start + maxLength)])
    }
}
