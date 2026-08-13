class Solution {
    func longestPalindrome(_ s: String) -> String {
        let chars = Array(s)
        var start = 0
        var maxLength = 0

        // Try every index (and every gap between two indices) as the
        // center of a palindrome, then grow outward while both sides match.
        func expand(_ left: Int, _ right: Int) {
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

        for center in chars.indices {
            expand(center, center)       // odd-length palindromes, e.g. "aba"
            expand(center, center + 1)   // even-length palindromes, e.g. "abba"
        }

        return String(chars[start..<start + maxLength])
    }
}
