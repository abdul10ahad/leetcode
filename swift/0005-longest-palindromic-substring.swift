class Solution {
    func longestPalindrome(_ s: String) -> String {
        let chars = Array(s)
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
            let (l1, r1) = expand(i, i)
            if r1 - l1 > end - start {
                (start, end) = (l1, r1)
            }

            let (l2, r2) = expand(i, i + 1)
            if r2 - l2 > end - start {
                (start, end) = (l2, r2)
            }
        }

        return String(chars[start...end])
    }
}
