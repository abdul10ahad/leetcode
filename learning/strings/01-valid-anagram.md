# Day 1 — 242. Valid Anagram

**Pattern:** Hashing / frequency counting
**Link:** https://leetcode.com/problems/valid-anagram/

## Problem

Given two strings `s` and `t`, return `true` if `t` is an anagram of `s`
(i.e. same letters, same counts, any order).

```
Input:  s = "anagram", t = "nagaram"
Output: true

Input:  s = "rat", t = "car"
Output: false
```

## Idea

Two strings are anagrams exactly when every character appears the same
number of times in both. So:

1. If the lengths differ, they can't be anagrams — bail out immediately.
2. Count how many times each character appears in `s`.
3. Walk `t`, subtracting one from the same counts.
4. If every count lands back on zero, the multisets of characters matched.

That's a single pass to build the histogram and a single pass to drain it —
no sorting required.

## Modern Swift solution

```swift
class Solution {
    func isAnagram(_ s: String, _ t: String) -> Bool {
        guard s.count == t.count else { return false }

        let counts = s.reduce(into: [Character: Int]()) { tally, char in
            tally[char, default: 0] += 1
        }

        return t.reduce(into: counts) { tally, char in
            tally[char, default: 0] -= 1
        }
        .allSatisfy { $0.value == 0 }
    }
}
```

### What's "modern" about it

- `reduce(into:)` builds the histogram without a `var counts = [:]` +
  manual `for` loop — the accumulator is mutated in place, so it stays
  O(n) instead of copying a dictionary on every iteration (which plain
  `reduce(_:_:)` would do).
- `tally[char, default: 0] += 1` is the `Dictionary` default-value
  subscript — no `if let` / `??` dance to handle a missing key.
- The second `reduce(into: counts)` reuses the first histogram as the
  *starting* accumulator, so decrementing for `t` is just "run the same
  reducer again with a different sign."
- `allSatisfy` replaces a manual loop-and-early-return over the final
  dictionary's values.

## Step-by-step flow (dry run)

`s = "anagram"`, `t = "nagaram"`

**1. Length check:** both are 7 characters — continue.

**2. Build histogram from `s`:**

| char | a | n | g | r | m |
|------|---|---|---|---|---|
| count | 3 | 1 | 1 | 1 | 1 |

**3. Drain using `t = "nagaram"`:**

| step | char consumed | counts after |
|------|----------------|--------------|
| 1 | n | a:3, n:0, g:1, r:1, m:1 |
| 2 | a | a:2, n:0, g:1, r:1, m:1 |
| 3 | g | a:2, n:0, g:0, r:1, m:1 |
| 4 | a | a:1, n:0, g:0, r:1, m:1 |
| 5 | r | a:1, n:0, g:0, r:0, m:1 |
| 6 | a | a:0, n:0, g:0, r:0, m:1 |
| 7 | m | a:0, n:0, g:0, r:0, m:0 |

**4. `allSatisfy { $0.value == 0 }`** — every count is 0 → `true`.

If instead `t = "rat"` had come from `s = "car"`, lengths already differ
in the general case, but even for equal-length mismatches like
`s = "rat"`, `t = "car"`, you'd end up with leftover counts like `t: -1`
and `c: 1` after draining — `allSatisfy` catches that immediately and
returns `false`.

## Complexity

- **Time:** O(n) — one pass to build the histogram, one pass to drain it,
  one pass over the (bounded) map to check `allSatisfy`.
- **Space:** O(k) where k is the number of distinct characters — O(1) in
  practice for fixed alphabets like lowercase ASCII.

## Alternative (Unicode-safe, sorting-based)

If you don't want to reason about hashing at all, `Swift`'s `Character`
already handles full Unicode grapheme clusters, so a one-liner sort also
works and is arguably more obviously correct, at the cost of O(n log n):

```swift
func isAnagram(_ s: String, _ t: String) -> Bool {
    s.count == t.count && s.sorted() == t.sorted()
}
```

Good to know as a fallback, but the histogram approach above is the
pattern you'll reuse for harder problems later in this series (Group
Anagrams, Minimum Window Substring, Longest Repeating Character
Replacement all build on "frequency map you mutate in place").

---
Next: **02 - Valid Palindrome** (two-pointer pattern).
