class Solution {
    func longestPalindrome(_ s: String) -> String {
        let chars = Array(s)
        var bestStart = 0
        var bestLength = 0

        func expand(_ left: Int, _ right: Int) {
            var l = left
            var r = right
            while l >= 0, r < chars.count, chars[l] == chars[r] {
                l -= 1
                r += 1
            }
            let length = r - l - 1
            if length > bestLength {
                bestLength = length
                bestStart = l + 1
            }
        }

        for center in 0..<chars.count {
            expand(center, center)     // odd-length palindromes, e.g. "aba"
            expand(center, center + 1) // even-length palindromes, e.g. "abba"
        }

        return String(chars[bestStart..<bestStart + bestLength])
    }
}
