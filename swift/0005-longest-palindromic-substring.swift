class Solution {
    func longestPalindrome(_ s: String) -> String {
        let chars = Array(s)
        guard chars.count > 1 else { return s }

        var start = 0
        var maxLength = 1

        func expandFromCenter(_ left: Int, _ right: Int) {
            var l = left
            var r = right
            while l >= 0 && r < chars.count && chars[l] == chars[r] {
                l -= 1
                r += 1
            }
            let currentLength = r - l - 1
            if currentLength > maxLength {
                maxLength = currentLength
                start = l + 1
            }
        }

        for i in 0..<chars.count {
            expandFromCenter(i, i)     // odd-length palindromes, center at i
            expandFromCenter(i, i + 1) // even-length palindromes, center between i and i+1
        }

        return String(chars[start..<(start + maxLength)])
    }
}
