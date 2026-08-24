# Day 1 — 344. Reverse String

**Pattern:** Two Pointers
**Difficulty:** Easy
**Link:** https://leetcode.com/problems/reverse-string/

## Problem

Given a character array `s`, reverse it **in place** using **O(1)** extra
space (no new array, no `.reversed()` shortcut allowed for the exercise).

```
Input:  s = ["h","e","l","l","o"]
Output: ["o","l","l","e","h"]
```

## Why this is the right first problem

Almost every harder string problem (palindrome checks, sliding window,
expand-around-center) is built on top of the **two pointers** idea: walk two
indices toward each other (or apart) instead of nesting loops. Reverse String
is the purest version of that pattern, so it's the cleanest place to learn it.

## Step-by-step reasoning

1. **Spot the constraint that decides the technique.** "In place" + "O(1)
   space" rules out building a new array and copying backwards — we must
   mutate `s` directly.
2. **Model it physically.** Picture two hands, one on the first letter, one
   on the last. Swap what they're holding, then both hands step one position
   toward the middle.
3. **Define the loop condition.** Keep swapping while `left < right`. When
   they meet (odd length) or cross (even length), every pair has been
   swapped exactly once — stop.
4. **Swap, then advance.** Each iteration does exactly one swap and moves
   both pointers — this is what keeps it O(n) instead of O(n²).
5. **Check the edge cases.** Empty array and single-character array: `left <
   right` is false immediately, loop body never runs, array is already
   "reversed" — correct for free.

## Dry run

`s = ["h","e","l","l","o"]`, indices `0..4`

| step | left | right | action | array |
|------|------|-------|--------|-------|
| 0 | 0 | 4 | swap s[0], s[4] | h **↔** o → `o,e,l,l,h` |
| 1 | 1 | 3 | swap s[1], s[3] | e **↔** l → `o,l,l,e,h` |
| 2 | 2 | 2 | left == right, stop | `o,l,l,e,h` |

## Swift solution (modern APIs)

```swift
/**
 * 344. Reverse String
 * https://leetcode.com/problems/reverse-string/
 * Pattern: Two Pointers
 */
final class Solution {
    func reverseString(_ s: inout [Character]) {
        var left = s.startIndex
        var right = s.index(before: s.endIndex)

        while left < right {
            s.swapAt(left, right)
            left = s.index(after: left)
            right = s.index(before: right)
        }
    }
}
```

**What's "modern" here, and why it matters:**

- `s.startIndex` / `s.index(before: s.endIndex)` instead of `0` / `s.count -
  1`. For `Array` these happen to be the same `Int`s, but writing it this way
  means the exact same function body works unchanged on *any* `Collection`
  (e.g. if the input were a `Substring` or a custom buffer) — you're
  expressing "first index" / "last index", not "zero" / "count minus one".
- `s.swapAt(left, right)` instead of a manual `let temp = ...; s[left] =
  ...; s[right] = temp`. `swapAt` is the standard library's built-in
  no-temporary-variable swap — same O(1) swap, less room for a copy/paste
  bug, and it reads as "swap these two positions" instead of three lines of
  bookkeeping.
- `s.index(after:) / index(before:)` instead of `+= 1` / `-= 1`, for the
  same generality reason as `startIndex`.

One-liner worth knowing exists too — `s.reverse()` calls the exact same
two-pointer algorithm inside the standard library — but writing it by hand
once is how the *pattern* (not just this problem) sticks for when you hit
palindrome/window problems later in this series, where there's no built-in
to reach for.

## Complexity

- **Time:** O(n) — each element is visited once, `n/2` swaps total.
- **Space:** O(1) — only two index variables, no auxiliary storage.

## Pattern to remember

> **Two Pointers, converging:** start at both ends of a sequence, move
> inward, stop when they meet/cross. Reach for this whenever a problem
> mentions "in place," "palindrome," or "reverse," and the array/string
> itself is the only storage you're allowed.

Next lesson: **242. Valid Anagram** — moving from *positions* to *counting
characters*, using a frequency map instead of pointers.
