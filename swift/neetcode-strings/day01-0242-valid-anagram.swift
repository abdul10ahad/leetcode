/**
 * NeetCode Strings — Day 1
 * 242. Valid Anagram
 * https://leetcode.com/problems/valid-anagram/
 * Difficulty: Easy
 * Pattern: Hashing / Frequency Count
 *
 * Given two strings s and t, return true if t is an anagram of s
 * (same letters, same counts, any order).
 */

class Solution {

    // Approach: single frequency dictionary, increment for s, decrement for t.
    // Time: O(n)  Space: O(k) where k = number of distinct characters.
    func isAnagram(_ s: String, _ t: String) -> Bool {
        guard s.count == t.count else { return false }

        var counts = [Character: Int]()

        for char in s {
            counts[char, default: 0] += 1
        }
        for char in t {
            counts[char, default: 0] -= 1
        }

        return counts.values.allSatisfy { $0 == 0 }
    }

    // Alternative: modern one-liner using Dictionary(grouping:) + mapValues.
    // Same O(n) time, reads closer to the problem statement ("group letters,
    // compare counts") but allocates two extra dictionaries.
    func isAnagramDeclarative(_ s: String, _ t: String) -> Bool {
        guard s.count == t.count else { return false }
        let sCounts = Dictionary(grouping: s, by: { $0 }).mapValues(\.count)
        let tCounts = Dictionary(grouping: t, by: { $0 }).mapValues(\.count)
        return sCounts == tCounts
    }
}
