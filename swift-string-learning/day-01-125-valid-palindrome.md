# Day 1 — 125. Valid Palindrome

**Pattern:** Two Pointers
**Difficulty:** Easy
**Link:** https://leetcode.com/problems/valid-palindrome/

## Problem

Given a string `s`, return `true` if it is a palindrome after:

1. converting all uppercase letters to lowercase, and
2. removing all non-alphanumeric characters.

```
Input:  s = "A man, a plan, a canal: Panama"
Output: true          ("amanaplanacanalpanama" reads the same both ways)

Input:  s = "race a car"
Output: false
```

## Why this is the right problem to start with

Every NeetCode string track leans on two habits you'll reuse constantly:

- **Two Pointers** — walk a sequence from both ends inward instead of
  making a cleaned-up copy first. O(1) extra space instead of O(n).
- **Character classification** — deciding what counts as "real" data
  (letters/digits) vs. noise (punctuation, spaces) before comparing.

Swift also teaches you something language-specific here: **`String` is
not indexable by `Int`.** Swift strings are collections of `Character`
(a full Unicode grapheme cluster, which can be several bytes), so you
navigate them with `String.Index`, not `0, 1, 2, ...`. That's the first
"gotcha" every new Swift dev hits on string problems, so it's worth
seeing it head-on.

## Modern Swift toolkit for this problem

- `Character.isLetter`, `Character.isNumber` — built-in classification,
  no manual ASCII range checks (`swift`, no `CharacterSet` import needed).
- `Character.lowercased()` — per-character case folding.
- `String.Index`, `s.index(after:)`, `s.index(before:)` — pointer
  movement that's safe across multi-byte/Unicode characters.
- `Sequence.elementsEqual(_:)` — lets you compare a sequence against its
  own reverse without writing a manual loop, for the quick functional
  version.

## Solution 1 — the one-liner (great for a sanity check / quick script)

```swift
func isPalindrome(_ s: String) -> Bool {
    let cleaned = s.lowercased().filter { $0.isLetter || $0.isNumber }
    return cleaned.elementsEqual(cleaned.reversed())
}
```

This is O(n) time, O(n) space — clean, but it allocates a filtered copy
plus a reversed view. Good for readability, not for the "no extra
memory" constraint an interviewer usually wants next.

## Solution 2 — two pointers, O(1) extra space (the pattern to learn)

```swift
func isPalindrome(_ s: String) -> Bool {
    guard !s.isEmpty else { return true }

    var left = s.startIndex
    var right = s.index(before: s.endIndex)

    while left < right {
        guard s[left].isLetter || s[left].isNumber else {
            left = s.index(after: left)
            continue
        }
        guard s[right].isLetter || s[right].isNumber else {
            right = s.index(before: right)
            continue
        }
        guard s[left].lowercased() == s[right].lowercased() else {
            return false
        }
        left = s.index(after: left)
        right = s.index(before: right)
    }
    return true
}
```

### Step-by-step flow

Walk through `s = "A man, a plan, a canal: Panama"`.

1. **Set up pointers.** `left = startIndex` (→ `'A'`), `right = index(before: endIndex)`
   (→ `'a'`, the last character). Guard the empty-string case up front so
   `s.index(before: s.endIndex)` never runs on an empty string (that
   would crash — `startIndex == endIndex` there).
2. **Loop while `left < right`.** This is the whole algorithm: close the
   gap from both sides until the pointers meet or cross.
3. **Skip noise on the left.** If `s[left]` isn't a letter/digit (e.g. a
   space or comma), advance `left` and `continue` — don't compare yet.
4. **Skip noise on the right.** Same idea for `right`, moving it
   backward.
5. **Compare the two real characters**, case-insensitively via
   `lowercased()`. `'A'.lowercased() == 'a'.lowercased()` → equal, keep
   going. Any mismatch means the string isn't a palindrome — return
   `false` immediately (short-circuit, don't scan the rest).
6. **Advance both pointers inward** (`left` forward, `right` backward)
   and repeat from step 2.
7. **Pointers meet or cross** (`left >= right`) with no mismatch found →
   every pair matched → `return true`.

Visually, the pointers race toward the middle, only pausing on
alphanumeric characters:

```
A  m a n ,   a  p l a n ,   a  c a n a l :   P a n a m a
^                                                     ^
left                                                right
  → skip nothing (A is a letter) → compare 'a' vs 'a' ✓
    → advance both inward, skip ',', ' ' etc. on either side as needed
```

### Complexity

- **Time:** O(n) — each pointer moves at most n/2 steps total, every
  character is visited at most once.
- **Space:** O(1) — no copy of the string is made; `String.Index` is a
  lightweight cursor into the original storage.

## Common mistakes this problem catches

- Comparing `Int` indices instead of `String.Index` (won't compile —
  Swift forces you to confront the Unicode-safety issue instead of
  silently doing the wrong thing on multi-byte characters).
- Forgetting the empty-string / all-punctuation edge case
  (`","` → cleaned string is empty → should be `true`).
- Case-folding only one side, or comparing before filtering, so
  `"Aa"` incorrectly fails.

## Try it yourself next

Before tomorrow's lesson, try adapting Solution 2 to solve
**680. Valid Palindrome II** (a palindrome check where you're allowed to
delete *at most one* character) — same two-pointer skeleton, plus one
branch: on a mismatch, try skipping either the left or the right
character and check if *that* substring is a palindrome.
