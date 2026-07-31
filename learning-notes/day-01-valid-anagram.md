# Day 1 — Valid Anagram (LeetCode 242, Easy)

Pattern: **Arrays & Hashing** (frequency counting)
Existing repo solution: `swift/0242-valid-anagram.swift`

## 1. Problem

Given two strings `s` and `t`, return `true` if `t` is an anagram of `s`
(same letters, same multiplicity, any order), else `false`.

```
Input:  s = "anagram", t = "nagaram"
Output: true

Input:  s = "rat", t = "car"
Output: false
```

## 2. Reasoning — how to get from "problem" to "algorithm"

Two strings are anagrams exactly when they contain the same characters the
same number of times. That single sentence is the whole algorithm design:

1. **Quick reject**: if the lengths differ, they can't be anagrams — bail
   out in O(1) before doing any real work.
2. **Count characters in each string** into a frequency table
   (character -> how many times it appears).
3. **Compare the two frequency tables.** If they're identical, every
   character occurs the same number of times in both strings, which is the
   definition of an anagram.

The only design decision is *what to count with*: a general
`[Character: Int]` dictionary (works for any Unicode input), or a
fixed-size 26-slot array (faster, but only valid if the problem guarantees
lowercase English letters — which LeetCode 242 does).

## 3. Modern Swift solution

```swift
func isAnagram(_ s: String, _ t: String) -> Bool {
    guard s.count == t.count else { return false }

    let sCounts = s.reduce(into: [Character: Int]()) { counts, char in
        counts[char, default: 0] += 1
    }
    let tCounts = t.reduce(into: [Character: Int]()) { counts, char in
        counts[char, default: 0] += 1
    }

    return sCounts == tCounts
}
```

What makes this "modern Swift" rather than a manual C-style port:

- `reduce(into:)` builds the dictionary in one expression instead of a
  `for` loop with a mutable `var` declared above it — the accumulator's
  scope is contained to the closure.
- `counts[char, default: 0] += 1` is the idiomatic "increment-or-insert"
  pattern; no `if let`/`else` branch needed.
- `sCounts == tCounts` relies on `Dictionary` being `Equatable` when its
  `Value` is `Equatable` — Swift compares both dictionaries' key/value
  pairs for you. The repo's existing solution loops over `countS`'s keys
  by hand and checks each against `countT`; that's correct but it's
  exactly what `==` already does, and doing it manually is a common
  no-op abstraction to avoid.

### A faster variant, using the problem's actual constraints

LeetCode 242 guarantees lowercase `a-z` only, so a 26-slot array beats a
dictionary (no hashing, no heap allocation for buckets, cache-friendly):

```swift
func isAnagramFast(_ s: String, _ t: String) -> Bool {
    guard s.utf8.count == t.utf8.count else { return false }

    var counts = [Int](repeating: 0, count: 26)
    let aByte = Character("a").asciiValue!

    for byte in s.utf8 { counts[Int(byte - aByte)] += 1 }
    for byte in t.utf8 { counts[Int(byte - aByte)] -= 1 }

    return counts.allSatisfy { $0 == 0 }
}
```

- `s.utf8` is a `String` view of raw bytes — for ASCII-only input this is
  cheaper than iterating `Character`s, which have to assemble Unicode
  grapheme clusters even when you only need a byte.
- Counting up for `s` and down for `t` into the *same* array means "equal
  frequencies" collapses to "every slot is back to zero" — one array
  instead of two, checked with `allSatisfy` instead of a manual loop.

## 4. Step-by-step trace

`s = "ana"`, `t = "naa"` using the fast variant:

| step | byte | index (`byte - 'a'`) | counts array |
|------|------|----|--------------|
| start | — | — | `[0,0,...,0]` (26 zeros) |
| s[0] = 'a' | +1 | 0 | `[1,0,...]` |
| s[1] = 'n' | +1 | 13 | `[1,0,...,1(at 13),...]` |
| s[2] = 'a' | +1 | 0 | `[2,0,...,1,...]` |
| t[0] = 'n' | -1 | 13 | `[2,0,...,0,...]` |
| t[1] = 'a' | -1 | 0 | `[1,0,...,0,...]` |
| t[2] = 'a' | -1 | 0 | `[0,0,...,0,...]` |

Final array is all zeros -> `allSatisfy { $0 == 0 }` is `true` -> anagram
confirmed. If `t` had been `"nab"`, the `'b'` slot would end at `-1` and the
`'a'` slot at `1`, so `allSatisfy` would fail on the first mismatch.

## 5. Complexity

Both versions: **O(n) time** (one pass to count, one pass to compare),
**O(1) extra space** — the dictionary version is bounded by the alphabet
size in practice, and the array version is exactly 26 ints regardless of
input size.

Compare against the repo's third option, `s.sorted() == t.sorted()`:
correct and shorter to write, but **O(n log n)** because of the sort — a
good one-liner for a quick check, worse for anything performance-sensitive.

## 6. Takeaway pattern

"Compare frequency tables" is the general tool for *any* problem that
asks "do these two collections have the same elements, ignoring order"
(anagrams, permutation checks, multiset equality). The two variants above
are the same idea at two different levels of specialization — dictionary
when you don't know the alphabet, fixed array when you do.
