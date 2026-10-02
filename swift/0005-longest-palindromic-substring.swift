/**
 * Question Link: https://leetcode.com/problems/longest-palindromic-substring/
 *
 * Solution: Expand Around Center
 * Time Complexity: O(n^2)
 * Extra Space Complexity: O(n) for the character array
 */

class LongestPalindromicSubstring {
    func longestPalindrome(_ s: String) -> String {
        let chars = Array(s)
        guard chars.count > 1 else { return s }

        var best = 0..<1  // range of the longest palindrome found so far

        // Grow outward from (left, right) while the ends match.
        func expand(_ left: Int, _ right: Int) -> Range<Int> {
            var l = left, r = right
            while l >= 0, r < chars.count, chars[l] == chars[r] {
                l -= 1
                r += 1
            }
            return (l + 1)..<r  // last valid window
        }

        for i in chars.indices {
            let odd = expand(i, i)       // center is a character
            let even = expand(i, i + 1)  // center is between two characters
            if odd.count > best.count { best = odd }
            if even.count > best.count { best = even }
        }

        return String(chars[best])
    }
}
