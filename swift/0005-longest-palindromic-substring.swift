/**
 * Question Link: https://leetcode.com/problems/longest-palindromic-substring/
 *
 * Pattern: Two Pointers - Expand Around Center
 * Time: O(n^2)  Space: O(1) extra (ignoring the output string)
 */

class Solution {
    func longestPalindrome(_ s: String) -> String {
        guard s.count > 1 else { return s }
        let chars = Array(s)
        var start = 0
        var maxLength = 1

        for center in 0..<chars.count {
            let odd = expand(chars, center, center)
            let even = expand(chars, center, center + 1)

            for (l, len) in [odd, even] where len > maxLength {
                maxLength = len
                start = l
            }
        }

        return String(chars[start..<(start + maxLength)])
    }

    // Grows outward from a center while both sides match, returns (left index, length) of the palindrome found.
    private func expand(_ chars: [Character], _ left: Int, _ right: Int) -> (Int, Int) {
        var l = left
        var r = right
        while l >= 0 && r < chars.count && chars[l] == chars[r] {
            l -= 1
            r += 1
        }
        return (l + 1, r - l - 1)
    }
}
