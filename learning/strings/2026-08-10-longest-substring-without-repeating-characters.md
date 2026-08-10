# Day 1 (restart) — Longest Substring Without Repeating Characters

**LeetCode 3** · Pattern: **Sliding Window** · Difficulty: Medium
https://leetcode.com/problems/longest-substring-without-repeating-characters/

## 1. The problem

Given a string `s`, find the length of the longest substring (contiguous!)
that has no repeated characters.

```
Input:  s = "abcabcbb"
Output: 3      // "abc"

Input:  s = "bbbbb"
Output: 1      // "b"

Input:  s = "pwwkew"
Output: 3      // "wke" — note "pwke" is a subsequence, not a substring
```

## 2. Why this is a sliding-window problem

Recognize the pattern from the phrasing, not just this problem:

> "longest / shortest **substring or subarray** that satisfies some
> constraint" → sliding window.

The constraint here is "no duplicate characters." Sliding window works
because of one key property: **the constraint only gets easier to satisfy
as the window shrinks from the left, never harder.** If `[l, r]` has no
duplicates, then any sub-window inside it also has no duplicates. That
monotonic property is what lets us slide instead of re-checking everything.

## 3. Brute force first (so the optimization actually means something)

Check every substring: two nested loops to pick `(start, end)`, then a third
pass to check for duplicates. That's O(n³), or O(n²) if you check duplicates
while extending. Both re-examine characters you've already looked at — that
waste is exactly what the sliding window eliminates.

## 4. Building the sliding window, step by step

Keep two pointers, `windowStart` and `windowEnd`, both starting at 0. Walk
`windowEnd` forward one character at a time — that's the window growing.

- **Case A: the new character is not already in the window.** Great, add it,
  the window grows, update the best length seen so far.
- **Case B: the new character IS already in the window.** The window can no
  longer contain both copies. Shrink from the left — move `windowStart`
  forward — until the duplicate is gone, *then* add the new character.

Trace it on `"abcabcbb"`:

| windowEnd | char | action | window | length |
|---|---|---|---|---|
| 0 | a | new | `a` | 1 |
| 1 | b | new | `ab` | 2 |
| 2 | c | new | `abc` | 3 |
| 3 | a | dup of index 0 → shrink start to 1 | `bca` | 3 |
| 4 | b | dup of index 1 → shrink start to 2 | `cab` | 3 |
| 5 | c | dup of index 2 → shrink start to 3 | `abc` | 3 |
| 6 | b | dup of index 4 → shrink start to 5 | `cb` | 2 |
| 7 | b | dup of index 6 → shrink start to 7 | `b` | 1 |

Best length: **3**.

## 5. Two Swift implementations, from naive-but-correct to optimal

### Approach A — a literal window with a `Set` (easy to reason about first)

This mirrors the trace above exactly: shrink one character at a time while
a duplicate exists.

```swift
final class Solution {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        let chars = Array(s)
        var seen = Set<Character>()
        var windowStart = 0
        var longest = 0

        for windowEnd in chars.indices {
            while seen.contains(chars[windowEnd]) {
                seen.remove(chars[windowStart])
                windowStart += 1
            }
            seen.insert(chars[windowEnd])
            longest = max(longest, windowEnd - windowStart + 1)
        }
        return longest
    }
}
```

`chars.indices` beats `0..<s.count` here — it reads as "every position in
this array," and it's what modern Swift style prefers over hand-rolled
ranges. This is still O(n) overall: `windowStart` only ever moves forward,
so across the whole run the inner `while` loop does at most n total steps,
not n per outer iteration.

### Approach B — remember *where* you saw it, jump directly (optimal)

Approach A shrinks one character at a time even when the duplicate is far
behind `windowStart`. If you track the **last index** each character was
seen at, you can jump `windowStart` there in one move instead of walking:

```swift
final class Solution {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        let chars = Array(s)
        var lastSeenIndex: [Character: Int] = [:]
        var windowStart = 0
        var longest = 0

        for (windowEnd, character) in chars.enumerated() {
            if let previous = lastSeenIndex[character], previous >= windowStart {
                windowStart = previous + 1
            }
            lastSeenIndex[character] = windowEnd
            longest = max(longest, windowEnd - windowStart + 1)
        }
        return longest
    }
}
```

Two modern-Swift things worth noticing:

- `chars.enumerated()` gives `(windowEnd, character)` pairs directly —
  no separate `chars[windowEnd]` lookup needed.
- `if let previous = lastSeenIndex[character], previous >= windowStart` —
  the `previous >= windowStart` guard matters: a character seen *before*
  the current window started is irrelevant and must not yank
  `windowStart` backwards.

Both approaches are O(n) time. Approach B is a single pass with no inner
loop at all, and O(1) extra space in practice since the alphabet is bounded
(ASCII/Unicode scalar range), vs Approach A's O(n) worst case in
`windowStart` movement (still amortized O(n) overall, just less direct).

## 6. Complexity

| | Time | Space |
|---|---|---|
| Brute force | O(n³) / O(n²) | O(min(n, Σ)) |
| Approach A (Set, shrink loop) | O(n) amortized | O(min(n, Σ)) |
| Approach B (Dictionary, direct jump) | O(n) | O(min(n, Σ)) |

(Σ = size of the character set — bounded, so this is effectively O(1) space
for fixed alphabets like ASCII.)

## 7. Pattern-recognition takeaway

Whenever a problem says "longest/shortest substring/subarray such that
[condition]," reach for sliding window and ask two questions:

1. What state do I need to know if the window is still valid? (here: which
   characters are currently inside the window)
2. When the window becomes invalid, how do I fix it — shrink one at a time,
   or can I jump directly using stored indices?

That second question is exactly the difference between Approach A and B
above, and it's the same lever you'll pull on **Longest Repeating Character
Replacement (424)** and **Minimum Window Substring (76)** — both future
lessons in this series.
