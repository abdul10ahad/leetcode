// LeetCode 242. Valid Anagram
// https://leetcode.com/problems/valid-anagram/
//
// Given two strings s and t, return true if t is an anagram of s.

class Solution {
    func isAnagram(_ s: String, _ t: String) -> Bool {
        guard s.count == t.count else { return false }

        let sCounts = s.reduce(into: [Character: Int]()) { counts, char in
            counts[char, default: 0] += 1
        }

        let remainder = t.reduce(into: sCounts) { counts, char in
            counts[char, default: 0] -= 1
        }

        return remainder.values.allSatisfy { $0 == 0 }
    }
}
