import Foundation

// MARK: - LeetCode 242. Valid Anagram
// https://leetcode.com/problems/valid-anagram/
//
// Given two strings `s` and `t`, return `true` if `t` is an anagram of `s`,
// and `false` otherwise. An anagram uses exactly the same letters, the same
// number of times, just rearranged.
//
// Example:
//   s = "anagram", t = "nagaram"  -> true
//   s = "rat",     t = "car"      -> false
//
// ── Step-by-step flow ──────────────────────────────────────────────
// 1. Length check: two strings can only be anagrams if they're the same
//    length. Checking `s.count != t.count` first is O(1)-ish and lets us
//    bail before doing any real work.
//
// 2. Build a frequency table for `s`: walk every character and count how
//    many times it appears. We use `reduce(into:)` so the dictionary is
//    built in place (one accumulator, no intermediate copies) instead of
//    creating a new dictionary on every step the way plain `reduce` would.
//
// 3. Walk `t` once, "spending" one count per character:
//      - If the character isn't in the table, or its count is already 0,
//        `t` has a letter `s` doesn't have enough of -> not an anagram,
//        return false immediately (fail fast, don't scan the rest of `t`).
//      - Otherwise decrement that character's count by one.
//
// 4. If we get through all of `t` without failing, and the lengths matched
//    up front, every letter in `s` was matched exactly once by a letter in
//    `t` -> they're anagrams.
//
// Complexity: Time O(n), Space O(k) where k is the alphabet size in play
// (at most 26 for lowercase English letters, effectively O(1)).
// ─────────────────────────────────────────────────────────────────────

struct Solution {
    func isAnagram(_ s: String, _ t: String) -> Bool {
        guard s.count == t.count else { return false }

        // Step 2: tally every character in `s`.
        var counts = s.reduce(into: [Character: Int]()) { counts, char in
            counts[char, default: 0] += 1
        }

        // Step 3: spend counts against `t`, bailing the moment something
        // doesn't line up.
        for char in t {
            guard let remaining = counts[char], remaining > 0 else {
                return false
            }
            counts[char] = remaining - 1
        }

        // Step 4: nothing broke the loop, and lengths matched -> anagram.
        return true
    }
}

// MARK: - Alternate one-liner (good to know, worse complexity)
//
// Sorting both strings and comparing is the "obvious" first idea:
//
//   func isAnagram(_ s: String, _ t: String) -> Bool {
//       s.sorted() == t.sorted()
//   }
//
// `sorted()` on a `String` returns `[Character]`, and `[Character]`
// conforms to `Equatable`, so `==` just works — no manual loop needed.
// It's O(n log n) instead of O(n) though, so the counting approach above
// is the one worth internalizing for interviews.

// MARK: - Modern Swift APIs used
// - `reduce(into:)` — folds a `Sequence` into a mutable accumulator
//   without copying it on every iteration (unlike plain `reduce(_:_:)`,
//   which is immutable-functional and reallocates the accumulator each step).
// - `Dictionary` subscript with a `default:` value — `counts[char, default: 0]`
//   reads-or-inserts in one expression, no manual `if let` bump needed.
// - `String` as a `Collection` of `Character` — `for char in t` and
//   `s.count` both fall out of `String: BidirectionalCollection`, no index
//   arithmetic required (and it's grapheme-cluster aware, so it handles
//   multi-scalar characters like emoji or combining accents correctly,
//   unlike counting raw UTF-8/UTF-16 code units).

// MARK: - Quick sanity checks
assert(Solution().isAnagram("anagram", "nagaram") == true)
assert(Solution().isAnagram("rat", "car") == false)
assert(Solution().isAnagram("a", "ab") == false)
assert(Solution().isAnagram("", "") == true)
