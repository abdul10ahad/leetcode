class Solution {
    func longestPalindrome(_ s: String) -> String {
        let chars = Array(s)
        var start = 0
        var maxLength = 0

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

        for i in 0..<chars.count {
            expand(i, i)
            expand(i, i + 1)
        }

        return String(chars[start..<start + maxLength])
    }
}
