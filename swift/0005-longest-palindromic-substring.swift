class Solution {
    func longestPalindrome(_ s: String) -> String {
        let chars = Array(s)
        guard !chars.isEmpty else { return "" }

        var start = 0
        var end = 0

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
            let odd = expand(i, i)
            if odd.1 - odd.0 > end - start {
                (start, end) = odd
            }

            let even = expand(i, i + 1)
            if even.1 - even.0 > end - start {
                (start, end) = even
            }
        }

        return String(chars[start...end])
    }
}
