// Solution: Expand Around Center
// NeetCode Pattern: Strings / Two Pointers

// Time Complexity: O(n^2)
// Space Complexity: O(1)

class Solution {
    func longestPalindrome(_ s: String) -> String {
        let chars = Array(s)
        guard chars.count > 1 else { return s }

        var start = 0
        var end = 0

        // Grows outward from a center pair (l, r) while the characters
        // on both sides match, then hands back the widest valid window.
        func expand(_ left: Int, _ right: Int) -> (Int, Int) {
            var l = left
            var r = right
            while l >= 0, r < chars.count, chars[l] == chars[r] {
                l -= 1
                r += 1
            }
            return (l + 1, r - 1)
        }

        for i in 0..<chars.count {
            // Odd-length palindromes center on a single character, e.g. "aba".
            let (oddL, oddR) = expand(i, i)
            if oddR - oddL > end - start {
                (start, end) = (oddL, oddR)
            }

            // Even-length palindromes center between two characters, e.g. "abba".
            let (evenL, evenR) = expand(i, i + 1)
            if evenR - evenL > end - start {
                (start, end) = (evenL, evenR)
            }
        }

        return String(chars[start...end])
    }
}
