/**
 * Question Link: https://leetcode.com/problems/longest-palindromic-substring/
 *
 * Given a string `s`, return the longest palindromic substring in `s`.
 *
 * Example:
 * Input:  s = "babad"
 * Output: "bab"   (note: "aba" is also a valid answer)
 *
 * Pattern: Two Pointers — "Expand Around Center"
 * Time:  O(n^2)  — n centers, each expansion can walk up to n/2 steps
 * Space: O(1)    — only a handful of index variables (output string aside)
 */

class Solution {
    func longestPalindrome(_ s: String) -> String {
        guard s.count > 1 else { return s }

        let chars = Array(s)
        var start = 0
        var maxLength = 1

        // Grows outward from a center as long as both sides match.
        // Every palindrome has either ONE character at its center (odd length,
        // e.g. "bab") or TWO characters at its center (even length, e.g. "abba").
        func expand(_ left: Int, _ right: Int) {
            var l = left
            var r = right
            while l >= 0, r < chars.count, chars[l] == chars[r] {
                l -= 1
                r += 1
            }
            // Loop stops one step past the real boundary on both sides,
            // so the true palindrome is (l+1)...(r-1).
            let length = r - l - 1
            if length > maxLength {
                maxLength = length
                start = l + 1
            }
        }

        for i in 0..<chars.count {
            expand(i, i)       // odd-length palindromes, centered on chars[i]
            expand(i, i + 1)   // even-length palindromes, centered between chars[i] and chars[i+1]
        }

        let startIndex = s.index(s.startIndex, offsetBy: start)
        let endIndex = s.index(startIndex, offsetBy: maxLength)
        return String(s[startIndex..<endIndex])
    }
}
