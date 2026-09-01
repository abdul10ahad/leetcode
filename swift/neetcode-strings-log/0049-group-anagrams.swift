/**
 * NeetCode Strings — Day log entry 2026-09-01
 * Problem: Group Anagrams
 * Link: https://leetcode.com/problems/group-anagrams/
 * Pattern: Hashing / grouping — natural follow-up to Valid Anagram (242),
 *          which this routine has already covered several times.
 *
 * Given an array of strings, group the ones that are anagrams of each
 * other together. Order of the groups (and order within a group) does
 * not matter.
 *
 * Example:
 *   Input:  ["eat", "tea", "tan", "ate", "nat", "bat"]
 *   Output: [["eat","tea","ate"], ["tan","nat"], ["bat"]]
 */

final class Solution {

    // MARK: - Version 1: sorted-letters key (simplest, easiest to reason about)
    //
    // Flow:
    // 1. For every word, compute a "canonical form" by sorting its
    //    characters. Anagrams share the exact same canonical form
    //    ("eat" -> "aet", "tea" -> "aet", "ate" -> "aet").
    // 2. Use that canonical form as a dictionary key and bucket the
    //    original words under it.
    // 3. Return the dictionary's values as the final grouping.
    //
    // `Dictionary(grouping:by:)` is the modern Swift API for exactly this
    // "bucket items by a computed key" shape — no manual `if let` /
    // `default: []` bookkeeping needed.
    //
    // Time:  O(n * k log k)  — n words, k = average word length, because
    //        of the per-word sort.
    // Space: O(n * k) for the buckets.
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        let groups = Dictionary(grouping: strs) { word in
            String(word.sorted())
        }
        return Array(groups.values)
    }

    // MARK: - Version 2: character-count key (optimized, no sorting)
    //
    // Flow:
    // 1. For every word, build a 26-slot count array (`counts[0]` = number
    //    of 'a's, `counts[1]` = number of 'b's, ...) by walking its
    //    unicode scalars once. This is the same counting idea as Valid
    //    Anagram, just producing a *key* instead of a *comparison*.
    // 2. Swift's `Array` conforms to `Hashable` whenever its `Element`
    //    does (`Int` does), so the count array itself can be used directly
    //    as a dictionary key — no need to flatten it into a String.
    // 3. Group by that key with `Dictionary(grouping:by:)`, same as
    //    Version 1, then return the buckets.
    //
    // Time:  O(n * k) — one pass per word instead of a sort.
    // Space: O(n * k) for the buckets, O(1) extra per word for the count
    //        array (fixed size 26).
    func groupAnagramsOptimized(_ strs: [String]) -> [[String]] {
        let aValue = Unicode.Scalar("a").value

        let groups = Dictionary(grouping: strs) { word -> [Int] in
            var counts = [Int](repeating: 0, count: 26)
            for scalar in word.unicodeScalars {
                counts[Int(scalar.value - aValue)] += 1
            }
            return counts
        }
        return Array(groups.values)
    }
}

// MARK: - Quick manual check

let solution = Solution()
print(solution.groupAnagrams(["eat", "tea", "tan", "ate", "nat", "bat"]))
print(solution.groupAnagramsOptimized(["eat", "tea", "tan", "ate", "nat", "bat"]))
// Expected (order of groups/elements may vary):
// [["eat", "tea", "ate"], ["tan", "nat"], ["bat"]]
