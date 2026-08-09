/**
 * Question Link: https://leetcode.com/problems/palindromic-substrings/
 */

class Solution {
    func countSubstrings(_ s: String) -> Int {
        let chars = Array(s)
        var count = 0

        for center in 0..<chars.count {
            count += expandAroundCenter(chars, center, center)      // odd-length palindromes, e.g. "aba"
            count += expandAroundCenter(chars, center, center + 1)  // even-length palindromes, e.g. "abba"
        }

        return count
    }

    private func expandAroundCenter(_ chars: [Character], _ left: Int, _ right: Int) -> Int {
        var l = left, r = right
        var count = 0

        while l >= 0, r < chars.count, chars[l] == chars[r] {
            count += 1
            l -= 1
            r += 1
        }

        return count
    }
}
