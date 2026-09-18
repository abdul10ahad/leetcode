/**
 * Question Link: https://leetcode.com/problems/longest-palindromic-substring/
 */

class LongestPalindromicSubstring {
    func longestPalindrome(_ s: String) -> String {
        let chars = Array(s)
        guard !chars.isEmpty else { return "" }

        var start = 0
        var maxLength = 1

        func expand(from left: Int, to right: Int) {
            var l = left, r = right
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
            expand(from: i, to: i)      // odd-length palindrome centered on i
            expand(from: i, to: i + 1)  // even-length palindrome centered between i and i+1
        }

        return String(chars[start..<(start + maxLength)])
    }
}
