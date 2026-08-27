/**
 * Day 1 — NeetCode Daily String Practice
 * LeetCode 242: Valid Anagram
 * https://leetcode.com/problems/valid-anagram/
 * Pattern: Hashing / frequency counting
 *
 * Problem
 * -------
 * Given two strings `s` and `t`, return true if `t` is an anagram of `s`
 * (i.e. `t` uses exactly the same letters as `s`, same counts, any order).
 *
 * Example: s = "anagram", t = "nagaram" -> true
 *          s = "rat",     t = "car"     -> false
 *
 * Constraints (from LeetCode): 1 <= s.length, t.length <= 5 * 10^4,
 * both strings consist of lowercase English letters only.
 */

struct ValidAnagramSolution {

    /// Optimal solution: single-pass frequency counting using a fixed-size
    /// array instead of a Dictionary.
    ///
    /// Why an array of 26 Ints instead of `[Character: Int]`?
    /// The problem guarantees lowercase a...z only, so we can map every
    /// letter straight to an array index (0...25) with `asciiValue`.
    /// Array subscripting is O(1) with no hashing overhead, so this beats
    /// a dictionary in both time and space constant factors.
    ///
    /// Time:  O(n)  — one pass over `s`, one pass over `t`.
    /// Space: O(1)  — the counts array is always exactly 26 elements,
    ///                independent of input size.
    func isAnagram(_ s: String, _ t: String) -> Bool {
        // Step 1: quick length check.
        // Two strings with different lengths can never be anagrams, so
        // bail out immediately instead of doing any counting work.
        guard s.count == t.count else { return false }

        // Step 2: set up one counts bucket, indexed by letter.
        // `counts[0]` tracks 'a', `counts[1]` tracks 'b', ... `counts[25]` tracks 'z'.
        var counts = [Int](repeating: 0, count: 26)

        // Step 3: walk both strings *at the same time* with `zip`.
        // `zip(s, t)` is a modern, allocation-light way to iterate two
        // Sequences in lockstep without manually indexing — it stops as
        // soon as either sequence runs out, and since we already checked
        // the lengths match, it visits every character of both exactly once.
        for (charFromS, charFromT) in zip(s, t) {
            // `Character.asciiValue` gives us a `UInt8?`. For "a"..."z" it's
            // always non-nil (97...122), so we can safely map it into 0...25
            // by subtracting the ascii value of "a".
            let sIndex = Int(charFromS.asciiValue! - Character("a").asciiValue!)
            let tIndex = Int(charFromT.asciiValue! - Character("a").asciiValue!)

            // Bump the count for the letter seen in `s`,
            // and drop the count for the letter seen in `t`.
            // If s and t are true anagrams, every letter's net count
            // will land back on exactly 0 once both strings are consumed.
            counts[sIndex] += 1
            counts[tIndex] -= 1
        }

        // Step 4: an anagram means every bucket balanced back to zero.
        // `allSatisfy` is the modern, declarative replacement for a manual
        // for-loop-with-early-return over "is every element zero?".
        return counts.allSatisfy { $0 == 0 }
    }

    /// Alternative, more "Swifty" one-liner using `Dictionary(grouping:by:)`.
    /// Not the fastest (dictionary hashing + Character-keyed, and it builds
    /// two full dictionaries), but a good example of expressing the same
    /// idea — "same letters, same counts" — with a modern collection API.
    ///
    /// `Dictionary(grouping: s, by: { $0 })` groups every character of `s`
    /// into buckets keyed by that character itself, e.g. for "aab" it
    /// produces ["a": ["a", "a"], "b": ["b"]]. Mapping `.count` over the
    /// values turns that into a letter -> frequency map, which is exactly
    /// what we compared manually above.
    func isAnagramDeclarative(_ s: String, _ t: String) -> Bool {
        guard s.count == t.count else { return false }

        let sFrequencies = Dictionary(grouping: s, by: { $0 }).mapValues(\.count)
        let tFrequencies = Dictionary(grouping: t, by: { $0 }).mapValues(\.count)

        return sFrequencies == tFrequencies
    }

    /// Simplest possible solution (good baseline to reason about, not the
    /// one to reach for once you understand the pattern): sort both
    /// strings and compare. Two strings are anagrams exactly when their
    /// sorted character sequences are identical.
    ///
    /// Time:  O(n log n) because of the two sorts — strictly worse than
    ///        the counting approach above.
    /// Space: O(n) for the sorted character arrays.
    func isAnagramBySorting(_ s: String, _ t: String) -> Bool {
        guard s.count == t.count else { return false }
        return s.sorted() == t.sorted()
    }
}
