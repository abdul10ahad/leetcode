class Solution {
    func longestPalindrome(_ s: String) -> String {
        let chars = Array(s)
        var start = 0
        var maxLength = 0

        // Grows outward from a center as long as both sides still match.
        // Passing (i, i) checks an odd-length palindrome (single-char center).
        // Passing (i, i + 1) checks an even-length palindrome (center between two chars).
        func expand(_ left: Int, _ right: Int) {
            var l = left
            var r = right
            while l >= 0, r < chars.count, chars[l] == chars[r] {
                l -= 1
                r += 1
            }
            // The loop always overshoots by one step on both sides,
            // so the valid palindrome is (l + 1)...(r - 1).
            let length = r - l - 1
            if length > maxLength {
                maxLength = length
                start = l + 1
            }
        }

        for i in 0..<chars.count {
            expand(i, i)
            expand(i, i + 1)
        }

        return String(chars[start..<start + maxLength])
    }
}
