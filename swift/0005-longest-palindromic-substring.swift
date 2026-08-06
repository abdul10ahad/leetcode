class Solution {
    func longestPalindrome(_ s: String) -> String {
        let chars = Array(s)
        var start = 0
        var maxLength = 0

        // Expands outward from a center pair (left, right) as long as the
        // characters on both sides still match. Updates the best window
        // found so far.
        func expandFromCenter(_ left: Int, _ right: Int) {
            var l = left
            var r = right
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

        for center in 0..<chars.count {
            expandFromCenter(center, center)     // odd-length palindrome, single-character center
            expandFromCenter(center, center + 1) // even-length palindrome, center between two characters
        }

        return String(chars[start..<(start + maxLength)])
    }
}
