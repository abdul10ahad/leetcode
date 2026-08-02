# NeetCode Strings — Daily Swift Lessons

A running log of a daily walkthrough of NeetCode's "Strings" problem set, solved in
modern Swift and explained step by step. This file tracks which problems have
already been covered so each new session picks a fresh one.

Full step-by-step reasoning for each entry is posted in the chat session on the day
it's covered; this file keeps the solution code and a short recap for reference.

## Progress tracker

| # | Problem | LeetCode # | Difficulty | Date covered | Pattern |
|---|---------|-----------|------------|---------------|---------|
| 1 | Valid Anagram | 242 | Easy | 2026-08-02 | Hashing / frequency count |

## 1. Valid Anagram (LeetCode 242) — 2026-08-02

**Pattern:** Hashing / frequency counting — the base pattern for almost every other
string problem in this series (Group Anagrams, Minimum Window Substring, Longest
Repeating Character Replacement all reuse it).

```swift
/**
 * Question Link: https://leetcode.com/problems/valid-anagram/
 *
 * Two strings are anagrams if they contain exactly the same characters,
 * with exactly the same multiplicity, in any order.
 */
func isAnagram(_ s: String, _ t: String) -> Bool {
    // Different lengths can never be anagrams — cheap early exit.
    guard s.count == t.count else { return false }

    // Build a signed histogram: +1 for every character in `s`, -1 for every
    // character in `t`. If the strings are anagrams, every count lands back at 0.
    var counts: [Character: Int] = [:]

    for character in s {
        counts[character, default: 0] += 1
    }
    for character in t {
        counts[character, default: 0] -= 1
    }

    return counts.values.allSatisfy { $0 == 0 }
}
```

A one-line alternative (simpler, but O(n log n) instead of O(n)):

```swift
func isAnagramBySorting(_ s: String, _ t: String) -> Bool {
    s.count == t.count && s.sorted() == t.sorted()
}
```

**Complexity:** O(n) time / O(k) space for the histogram version, where k is the
number of distinct characters; O(n log n) time for the sorting version.

**Key Swift note:** iterating a `String` with `for character in s` walks
*extended grapheme clusters* (`Character`), not UTF-8 bytes — so this is
Unicode-correct out of the box (accented letters, emoji, etc. behave as single
units) without any extra handling.
