/**
 * Day 01 — Valid Anagram
 * Question Link: https://leetcode.com/problems/valid-anagram/
 *
 * PATTERN: Hashing / Frequency Count
 * ----------------------------------
 * This is the foundational pattern for almost every "string" problem that asks
 * "do these two strings use the same letters the same number of times?"
 * (Group Anagrams, Isomorphic Strings, Ransom Note, Word Pattern all reuse it.)
 * The core idea: turn a string into a *signature* — either a sorted string or a
 * character -> count dictionary — then compare signatures instead of comparing
 * the strings character-by-character in every possible order.
 *
 * PROBLEM
 * -------
 * Given two strings `s` and `t`, return true if `t` is an anagram of `s`
 * (i.e. `t` is `s` rearranged, using every letter exactly once).
 *
 * Example: s = "anagram", t = "nagaram" -> true
 * Example: s = "rat",     t = "car"     -> false
 *
 * STEP-BY-STEP FLOW (frequency-count approach)
 * ---------------------------------------------
 * 1. Quick reject: if `s.count != t.count`, they can't be anagrams — different
 *    lengths mean different letter totals. Bail out in O(1).
 * 2. Walk `s` once, building a dictionary [Character: Int] that counts how many
 *    times each letter appears. Think of it as a tally sheet: every time we see
 *    a letter, we add a tally mark next to it.
 * 3. Walk `t` once the same way, building a second tally sheet.
 * 4. Compare the two tally sheets. If every letter has the same count in both,
 *    `t` is a rearrangement of `s` -> anagram. If any count differs (or a
 *    letter is missing from one side), it isn't.
 *
 * WORKED EXAMPLE: s = "anagram", t = "nagaram"
 * ---------------------------------------------
 *   lengths: 7 == 7                         -> pass the quick reject
 *   tally(s): a:3, n:1, g:1, r:1, m:1
 *   tally(t): n:1, a:3, g:1, r:1, m:1
 *   compare -> identical tallies            -> true
 *
 * COMPLEXITY
 * ----------
 *   Time:  O(n) — one pass to count each string, one pass to compare counts.
 *   Space: O(k) — k = number of distinct characters (at most 26 for lowercase
 *          English letters, so effectively O(1) for this problem's constraints).
 */

struct ValidAnagramDay01 {

    /// Frequency-count approach — O(n) time, the technique that generalizes to
    /// harder problems (Group Anagrams, Isomorphic Strings, etc).
    func isAnagram(_ s: String, _ t: String) -> Bool {
        guard s.count == t.count else { return false }

        // `reduce(into:)` builds the tally sheet in a single, allocation-friendly pass:
        // for every character, bump its count (defaulting missing keys to 0).
        let tally: (String) -> [Character: Int] = { string in
            string.reduce(into: [:]) { counts, char in
                counts[char, default: 0] += 1
            }
        }

        // Dictionary is Equatable when its Value is Equatable, so two tally
        // sheets can be compared directly with `==` — no manual key-by-key loop needed.
        return tally(s) == tally(t)
    }

    /// Sorting approach — simpler to read, O(n log n) time, O(n) space.
    /// Good as a mental fallback, but slower than the frequency-count version.
    func isAnagramBySorting(_ s: String, _ t: String) -> Bool {
        guard s.count == t.count else { return false }
        return s.sorted() == t.sorted()
    }
}

// MARK: - Trace-through demo (run with `swift day01-valid-anagram.swift`)

let solver = ValidAnagramDay01()

let cases: [(s: String, t: String)] = [
    ("anagram", "nagaram"),   // true
    ("rat", "car"),           // false
    ("a", "ab"),              // false (length mismatch, short-circuits early)
]

for (s, t) in cases {
    let result = solver.isAnagram(s, t)
    print("isAnagram(\"\(s)\", \"\(t)\") -> \(result)")
}
