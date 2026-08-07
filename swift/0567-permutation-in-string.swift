/**
 * Question Link: https://leetcode.com/problems/permutation-in-string/
 * Pattern: Sliding Window (fixed size) + frequency counting
 */
class Solution {
    func checkInclusion(_ s1: String, _ s2: String) -> Bool {
        let n1 = s1.count, n2 = s2.count
        guard n1 <= n2 else { return false }

        let aValue = Character("a").asciiValue!
        func slot(_ c: Character) -> Int { Int(c.asciiValue! - aValue) }

        var need = [Int](repeating: 0, count: 26)
        var window = [Int](repeating: 0, count: 26)

        let s2Chars = Array(s2)
        for c in s1 { need[slot(c)] += 1 }
        for i in 0..<n1 { window[slot(s2Chars[i])] += 1 }

        if window == need { return true }

        for i in n1..<n2 {
            window[slot(s2Chars[i])] += 1
            window[slot(s2Chars[i - n1])] -= 1
            if window == need { return true }
        }

        return false
    }
}
