/**
 * Day 1 — NeetCode Strings: Valid Anagram
 * Question Link: https://leetcode.com/problems/valid-anagram/
 *
 * Pattern: Hashing / frequency counting
 *
 * PROBLEM
 * -------
 * Given two strings `s` and `t`, return true if `t` is an anagram of `s`
 * (i.e. same letters, same counts, any order) and false otherwise.
 *
 * STEP-BY-STEP REASONING
 * -----------------------
 * 1. Two strings can only be anagrams if they have the same length.
 *    Checking this first is a free early-exit — no need to build any
 *    data structure if the lengths already disagree.
 *
 * 2. An anagram means "same multiset of characters." The natural way to
 *    compare two multisets is to count how many times each element
 *    appears and compare the counts.
 *
 * 3. Because the alphabet here is small and fixed (lowercase a-z per the
 *    constraints), we don't need a general `[Character: Int]` dictionary.
 *    A fixed-size array of 26 counters is faster (no hashing overhead,
 *    contiguous memory) and still O(1) extra space.
 *
 * 4. Walk `s` incrementing counters, walk `t` decrementing the *same*
 *    counters. If `s` and `t` are true anagrams, every counter returns
 *    to exactly zero. This lets us do it in ONE pass over both strings
 *    combined (via `zip`) instead of two separate passes + a comparison.
 *
 * 5. Modern Swift API notes used below:
 *    - `Character.asciiValue` gives a `UInt8?` — safe, no force-unwrapping
 *      needed if we guard on `isLowercase` first (constraints guarantee
 *      lowercase a-z, but we defend anyway).
 *    - `zip(s, t)` iterates `String` directly as a `Sequence` of
 *      `Character` — no need to materialize `Array(s)` first.
 *    - `allSatisfy` reads as a declarative "is everything true?" check
 *      instead of a manual loop with a boolean flag.
 */

class ValidAnagram {

    /// O(n) time, O(1) extra space (26 fixed buckets).
    func isAnagram(_ s: String, _ t: String) -> Bool {
        guard s.count == t.count else { return false }

        var counts = [Int](repeating: 0, count: 26)
        let aValue = Character("a").asciiValue!

        for (charS, charT) in zip(s, t) {
            guard let s0 = charS.asciiValue, let t0 = charT.asciiValue else {
                return false // non-lowercase input guard
            }
            counts[Int(s0 - aValue)] += 1
            counts[Int(t0 - aValue)] -= 1
        }

        // If s and t are anagrams, every bucket nets to zero.
        return counts.allSatisfy { $0 == 0 }
    }

    /// General-alphabet version (works for Unicode/emoji too), using a
    /// dictionary instead of a fixed array. Slightly more overhead, but
    /// no assumption about the character set.
    func isAnagramGeneral(_ s: String, _ t: String) -> Bool {
        guard s.count == t.count else { return false }

        var counts: [Character: Int] = [:]
        for char in s { counts[char, default: 0] += 1 }
        for char in t { counts[char, default: 0] -= 1 }

        return counts.values.allSatisfy { $0 == 0 }
    }

    /// One-liner using `sorted()` — O(n log n), but the clearest possible
    /// statement of "same letters, same counts": sorting canonicalizes
    /// order, so equal multisets become equal sequences.
    func isAnagramBySorting(_ s: String, _ t: String) -> Bool {
        s.count == t.count && s.sorted() == t.sorted()
    }
}

// MARK: - Quick sanity checks (uncomment to run locally)
// let sol = ValidAnagram()
// assert(sol.isAnagram("anagram", "nagaram") == true)
// assert(sol.isAnagram("rat", "car") == false)
// assert(sol.isAnagramGeneral("café", "éfac") == true)
// assert(sol.isAnagramBySorting("a", "ab") == false)
