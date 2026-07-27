// Solution: Expand Around Center
//
// Time Complexity: O(n^2)
// Extra Space Complexity: O(n) for the Character array (O(1) beyond the input copy)

class Solution {
    func longestPalindrome(_ s: String) -> String {
        let chars = Array(s)
        guard chars.count > 1 else { return s }

        var bestRange = 0..<1

        func expand(_ left: Int, _ right: Int) {
            var l = left
            var r = right
            while l >= 0, r < chars.count, chars[l] == chars[r] {
                l -= 1
                r += 1
            }
            // l, r overshot by one on each side; the palindrome is (l+1)..<r
            let newLength = r - (l + 1)
            let bestLength = bestRange.upperBound - bestRange.lowerBound
            if newLength > bestLength {
                bestRange = (l + 1)..<r
            }
        }

        for i in chars.indices {
            expand(i, i)       // odd-length palindromes, center on chars[i]
            expand(i, i + 1)   // even-length palindromes, center between chars[i] and chars[i+1]
        }

        return String(chars[bestRange])
    }
}
