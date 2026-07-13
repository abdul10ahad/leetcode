class Solution {
    func longestPalindrome(_ s: String) -> String {
        let chars = Array(s)
        var start = 0
        var maxLength = 1

        func expandFromCenter(_ left: Int, _ right: Int) -> Int {
            var l = left, r = right
            while l >= 0, r < chars.count, chars[l] == chars[r] {
                l -= 1
                r += 1
            }
            return r - l - 1
        }

        for i in 0..<chars.count {
            let oddLength = expandFromCenter(i, i)
            let evenLength = expandFromCenter(i, i + 1)
            let length = max(oddLength, evenLength)

            if length > maxLength {
                maxLength = length
                start = i - (length - 1) / 2
            }
        }

        return String(chars[start..<start + maxLength])
    }
}
