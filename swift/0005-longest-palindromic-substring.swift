/**
 * Question Link: https://leetcode.com/problems/longest-palindromic-substring/
 */

class Solution {
    func longestPalindrome(_ s: String) -> String {
        let chars = Array(s)
        guard chars.count > 1 else { return s }

        var bestRange = 0..<1

        for center in 0..<chars.count {
            let odd = expand(chars, center, center)
            let even = expand(chars, center, center + 1)
            for range in [odd, even] where range.count > bestRange.count {
                bestRange = range
            }
        }

        return String(chars[bestRange])
    }

    private func expand(_ chars: [Character], _ left: Int, _ right: Int) -> Range<Int> {
        var l = left, r = right
        while l >= 0, r < chars.count, chars[l] == chars[r] {
            l -= 1
            r += 1
        }
        return (l + 1)..<r
    }
}
