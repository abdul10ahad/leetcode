/**
 * Question Link: https://leetcode.com/problems/longest-palindromic-substring/
 *
 * Pattern: Two Pointers — "Expand Around Center"
 *
 * Idea: every palindrome mirrors around some center. A string of length n
 * has 2n - 1 possible centers: n centers sitting on a single character
 * (odd-length palindromes) and n - 1 centers sitting between two characters
 * (even-length palindromes). For each center we grow outward one step at a
 * time while the left/right characters match, then remember the widest
 * palindrome we've seen.
 *
 * Time:  O(n^2)  — n centers, each expansion is O(n) worst case
 * Space: O(n)    — the [Character] buffer for O(1) random access
 */
class Solution {
    func longestPalindrome(_ s: String) -> String {
        let chars = Array(s)
        guard chars.count > 1 else { return s }

        var start = 0
        var maxLength = 0

        // Expands outward from (left, right) as long as it stays a
        // palindrome, then records it if it's the longest seen so far.
        func expand(from left: Int, _ right: Int) {
            var l = left
            var r = right
            while l >= 0 && r < chars.count && chars[l] == chars[r] {
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
            expand(from: i, i)       // odd-length palindrome centered on i
            expand(from: i, i + 1)   // even-length palindrome centered between i and i+1
        }

        return String(chars[start..<(start + maxLength)])
    }
}
