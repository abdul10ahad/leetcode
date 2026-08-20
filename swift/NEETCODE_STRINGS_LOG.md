# NeetCode Strings — Daily Swift Study Log

Tracks a daily walk through NeetCode's core "string" pattern problems,
each solved in Swift using modern language APIs (native `String.Index`
traversal instead of falling back to `[Character]` + integer offsets
wherever that's the more idiomatic choice) with a step-by-step
explanation delivered alongside the commit.

Curriculum (grouped by the pattern each problem teaches):

| # | Problem | Pattern | Swift file | Status |
|---|---------|---------|------------|--------|
| 1 | [Longest Palindromic Substring](https://leetcode.com/problems/longest-palindromic-substring/) (5) | Two Pointers — expand around center | `0005-longest-palindromic-substring.swift` | ✅ Day 1 |
| 2 | [Palindromic Substrings](https://leetcode.com/problems/palindromic-substrings/) (647) | Two Pointers — expand around center | — | ⏳ |
| 3 | [Longest Common Prefix](https://leetcode.com/problems/longest-common-prefix/) (14) | Vertical/horizontal scan | — | ⏳ |
| 4 | [Find All Anagrams in a String](https://leetcode.com/problems/find-all-anagrams-in-a-string/) (438) | Sliding window + frequency count | — | ⏳ |
| 5 | [First Unique Character in a String](https://leetcode.com/problems/first-unique-character-in-a-string/) (387) | Frequency count | — | ⏳ |
| 6 | [String to Integer (atoi)](https://leetcode.com/problems/string-to-integer-atoi/) (8) | Manual parsing / state machine | — | ⏳ |
| 7 | [Reverse Words in a String](https://leetcode.com/problems/reverse-words-in-a-string/) (151) | In-place-style tokenizing | — | ⏳ |
| 8 | [Roman to Integer](https://leetcode.com/problems/roman-to-integer/) (13) | Lookup table scan | — | ⏳ |
| 9 | [Group Anagrams](https://leetcode.com/problems/group-anagrams/) (49) | Hashing (already solved in repo) | `0049-group-anagrams.swift` | ✔️ pre-existing |
| 10 | [Longest Substring Without Repeating Characters](https://leetcode.com/problems/longest-substring-without-repeating-characters/) (3) | Sliding window | `0003-longest-substring-without-repeating-characters.swift` | ✔️ pre-existing |

Already present in `swift/` before this log started (skipped as
repeats): Valid Anagram (242), Valid Palindrome (125), Longest Repeating
Character Replacement (424), Minimum Window Substring (76), Encode and
Decode Strings (271), Valid Parentheses (20), Reverse String (344),
Multiply Strings (43).

**How this log is used:** each scheduled run reads the table above,
picks the next `⏳` row, implements it, marks it `✅ Day N`, and appends
its explanation to the entry below before committing.

---

## Day 1 — Longest Palindromic Substring (5)

**Pattern:** Two Pointers — Expand Around Center
**File:** `swift/0005-longest-palindromic-substring.swift`

A palindrome is symmetric around a middle point, which is either a single
character (odd length) or the gap between two characters (even length).
A string of length `n` has `n` odd-style centers and `n - 1` even-style
centers — `2n - 1` total. For each center, grow outward one character at
a time while the two sides match; the widest successful growth for any
center is a candidate answer, and the largest candidate across all
centers is the result.

- Time: `O(n^2)` — up to `n` centers, each expandable up to `O(n)` times.
- Space: `O(1)` extra — only a few `String.Index` values are tracked.

Modern-API note: the solution walks `String.Index` directly (`s.indices`,
`s.index(before:)`, `s.index(after:)`, `s.distance(from:to:)`) rather than
converting to `[Character]` and using integer offsets. That keeps every
step correct per extended grapheme cluster (Swift's actual notion of a
"Character"), and lets the final answer be sliced straight out of the
original string with `s[range]` instead of rebuilt from an array slice.
