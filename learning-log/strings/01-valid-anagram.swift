/**
 * Day 1 — NeetCode String Problems Learning Log
 *
 * Problem: Valid Anagram
 * Link:    https://leetcode.com/problems/valid-anagram/
 * Pattern: Hashing / Frequency Count
 *
 * Given two strings `s` and `t`, return true if `t` is an anagram of `s`
 * (i.e. `t` uses exactly the same characters as `s`, the same number of
 * times each, just possibly in a different order).
 *
 * Example:
 *   s = "anagram", t = "nagaram"  -> true
 *   s = "rat",     t = "car"      -> false
 *
 * --- Approach: character frequency histogram --------------------------
 *
 * Two strings are anagrams exactly when their *multisets* of characters
 * are equal. So instead of comparing characters in order, we compare
 * "how many of each character" each string has:
 *
 *   1. If the lengths differ, they can't be anagrams — bail out in O(1).
 *   2. Build a [Character: Int] histogram for `s`.
 *   3. Build the same histogram for `t`.
 *   4. Compare the two histograms for equality.
 *
 * This "count characters into a dictionary" idea is the seed pattern for
 * a lot of later string problems (Group Anagrams, Find All Anagrams in a
 * String, Minimum Window Substring all reuse it), so it's worth internalizing
 * here first.
 *
 * Time:  O(n) — one pass to build each histogram, one pass to compare them.
 * Space: O(k) — k = number of distinct characters (bounded by alphabet size).
 */

struct Solution {
    func isAnagram(_ s: String, _ t: String) -> Bool {
        // Step 1: quick length check. Anagrams must have equal length,
        // so this filters out most "obviously false" cases for free.
        guard s.count == t.count else { return false }

        // Step 2 & 3: build a character -> count histogram for each string.
        //
        // `Dictionary(grouping:by:)` is a modern Swift API that buckets the
        // elements of any Sequence (here, a String, which is a Sequence of
        // Character) by a key you provide. Since we group characters by
        // themselves, each bucket ends up holding every occurrence of that
        // character, e.g. for "aab" -> ["a": ["a", "a"], "b": ["b"]].
        //
        // `.mapValues(\.count)` then turns each bucket (an array of
        // characters) into just its count, using Swift's KeyPath shorthand
        // for `{ $0.count }`. Result: ["a": 2, "b": 1].
        let countS = Dictionary(grouping: s, by: { $0 }).mapValues(\.count)
        let countT = Dictionary(grouping: t, by: { $0 }).mapValues(\.count)

        // Step 4: Swift's Dictionary conforms to Equatable whenever its
        // Value type does (Int does), so `==` directly checks that both
        // dictionaries have the same keys mapped to the same counts —
        // exactly the definition of "same character multiset".
        return countS == countT
    }

    /// Alternative: sort both strings and compare.
    /// Same characters in the same multiset always sort to the same
    /// sequence, so this is correct — just O(n log n) instead of O(n),
    /// and doesn't generalize as a building block for later problems.
    func isAnagramBySorting(_ s: String, _ t: String) -> Bool {
        guard s.count == t.count else { return false }
        return s.sorted() == t.sorted()
    }
}

// --- Quick sanity checks -------------------------------------------------
let sol = Solution()
assert(sol.isAnagram("anagram", "nagaram") == true)
assert(sol.isAnagram("rat", "car") == false)
assert(sol.isAnagram("a", "ab") == false)               // different lengths
assert(sol.isAnagram("", "") == true)                    // both empty
assert(sol.isAnagram("café", "éfac") == true)             // unicode-safe: Character
                                                           // handles grapheme
                                                           // clusters correctly
