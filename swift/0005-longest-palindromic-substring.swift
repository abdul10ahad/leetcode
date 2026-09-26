/**
 * Question Link: https://leetcode.com/problems/longest-palindromic-substring/
 */

class LongestPalindromicSubstring {
    // Expand Around Center
    // Time: O(n^2)  — up to n centers, each expansion can walk O(n) characters
    // Space: O(n)   — for the Array(s) buffer and the resulting substring
    func longestPalindrome(_ s: String) -> String {
        let chars = Array(s)
        guard chars.count > 1 else { return s }

        var start = 0
        var maxLength = 1

        for center in 0..<chars.count {
            // odd-length palindromes, e.g. "aba" -> center is the "b"
            let oddRange = expand(chars, center, center)
            // even-length palindromes, e.g. "abba" -> center is between the two "b"s
            let evenRange = expand(chars, center, center + 1)

            for range in [oddRange, evenRange] {
                let length = range.1 - range.0 + 1
                if length > maxLength {
                    maxLength = length
                    start = range.0
                }
            }
        }

        return String(chars[start..<(start + maxLength)])
    }

    // Grows outward from (left, right) while both sides match, then reports
    // the last valid (left, right) bounds of the palindrome it found.
    private func expand(_ chars: [Character], _ left: Int, _ right: Int) -> (Int, Int) {
        var left = left
        var right = right

        while left >= 0 && right < chars.count && chars[left] == chars[right] {
            left -= 1
            right += 1
        }

        // the loop above always overshoots by one step on both sides
        return (left + 1, right - 1)
    }
}
