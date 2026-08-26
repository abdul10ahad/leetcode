/**
 * Question Link: https://leetcode.com/problems/longest-palindromic-substring/
 *
 * Approach: Expand Around Center
 * Every palindrome has a center (a single character for odd-length palindromes,
 * or a gap between two characters for even-length palindromes). There are
 * 2n - 1 such centers for a string of length n. For each center we grow
 * outward while the characters on both sides match, tracking the widest
 * palindrome we've seen.
 *
 * Time complexity: O(n^2) — n centers, each expansion can take O(n)
 * Space complexity: O(n) — for the character array (the algorithm itself uses O(1) extra space)
 */
class Solution {
    func longestPalindrome(_ s: String) -> String {
        let chars = Array(s)
        guard chars.count > 1 else { return s }

        var start = 0
        var maxLength = 1

        func expandFromCenter(_ left: Int, _ right: Int) {
            var l = left
            var r = right
            while l >= 0, r < chars.count, chars[l] == chars[r] {
                l -= 1
                r += 1
            }
            // After the loop, (l+1)...(r-1) is the widest valid palindrome for this center
            let currentLength = r - l - 1
            if currentLength > maxLength {
                maxLength = currentLength
                start = l + 1
            }
        }

        for center in 0..<chars.count {
            expandFromCenter(center, center)     // odd-length palindromes, e.g. "aba"
            expandFromCenter(center, center + 1) // even-length palindromes, e.g. "abba"
        }

        let startIndex = s.index(s.startIndex, offsetBy: start)
        let endIndex = s.index(startIndex, offsetBy: maxLength)
        return String(s[startIndex..<endIndex])
    }
}
