class Solution {
    func longestPalindrome(_ s: String) -> String {
        let chars = Array(s)
        guard chars.count > 1 else { return s }

        var start = 0
        var maxLength = 1

        func expandAroundCenter(_ left: Int, _ right: Int) {
            var l = left
            var r = right
            while l >= 0 && r < chars.count && chars[l] == chars[r] {
                let currentLength = r - l + 1
                if currentLength > maxLength {
                    start = l
                    maxLength = currentLength
                }
                l -= 1
                r += 1
            }
        }

        for i in 0..<chars.count {
            expandAroundCenter(i, i)     // odd-length palindromes, center on i
            expandAroundCenter(i, i + 1) // even-length palindromes, center between i and i+1
        }

        return String(chars[start..<(start + maxLength)])
    }
}
