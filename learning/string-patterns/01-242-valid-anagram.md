# Day 1 — 242. Valid Anagram

**Pattern: Hash map / frequency counting**

This is the foundational string pattern almost everything else builds on: when
a problem asks "do these two strings have the same *characters*, ignoring
order?", frequency counting is the tool.

## Problem

> Given two strings `s` and `t`, return `true` if `t` is an anagram of `s`,
> and `false` otherwise. An anagram uses exactly the same letters, the same
> number of times, just rearranged.
>
> Example: `s = "anagram"`, `t = "nagaram"` → `true`
> Example: `s = "rat"`, `t = "car"` → `false`

## Step-by-step reasoning flow

1. **Fast rejection first.** If `s` and `t` have different lengths, they
   *cannot* be anagrams — no need to look at characters at all. Check this
   before doing any real work.
2. **What does "same letters, same counts, any order" actually mean?**
   Order doesn't matter, so comparing the strings directly (or index by
   index) is the wrong tool. What *does* matter is: for every character,
   does it appear the same number of times in both strings?
3. **That reframes the problem as: build a frequency table for each string,
   then compare the two tables.** A `[Character: Int]` dictionary is the
   natural structure — one pass over `s` to build its table, one pass over
   `t` to build its table.
4. **Comparing the tables.** Rather than manually walking both dictionaries,
   lean on the language: Swift's `Dictionary` is `Equatable` whenever its
   `Value` is `Equatable` (here, `Int` is). So `countS == countT` does the
   full "same keys, same counts" comparison in one expression.
5. **Could you do it in one pass instead of two?** Yes — increment for `s`,
   decrement for `t` in a single dictionary, then check all values are
   zero. That's a nice follow-up optimization, but two clean passes is more
   readable and still O(n), so we start there.

## Swift solution (modern APIs)

```swift
func isAnagram(_ s: String, _ t: String) -> Bool {
    guard s.count == t.count else { return false }

    let countS = s.reduce(into: [Character: Int]()) { counts, char in
        counts[char, default: 0] += 1
    }
    let countT = t.reduce(into: [Character: Int]()) { counts, char in
        counts[char, default: 0] += 1
    }

    return countS == countT
}
```

Modern APIs at work here:

- **`reduce(into:_:)`** — builds up a dictionary in place across a
  `Sequence` (here, `String`'s `Character` elements) without manually
  declaring a `var` and looping. It's the idiomatic Swift way to "fold" a
  sequence into an accumulator.
- **`counts[char, default: 0] += 1`** — the subscript-with-default form
  reads `counts[char]`, falling back to `0` if the key is missing, then
  writes the incremented value back — no manual `if let` / `else` branch
  needed for the "first time I've seen this character" case.
- **`Dictionary: Equatable`** — comparing `countS == countT` directly relies
  on the standard library's conditional conformance
  (`Dictionary: Equatable where Value: Equatable`), so there's no manual
  key-by-key comparison loop to write.

## Dry run

`s = "anagram"`, `t = "nagaram"`

1. `s.count == t.count` → `7 == 7` ✅, continue.
2. Build `countS` by folding over `"anagram"`:
   `a→3, n→1, g→1, r→1, m→1`
3. Build `countT` by folding over `"nagaram"`:
   `n→1, a→3, g→1, r→1, m→1`
4. `countS == countT` compares as sets of key-value pairs, not insertion
   order — both dictionaries have exactly `{a:3, n:1, g:1, r:1, m:1}` → `true`.

Contrast with `s = "rat"`, `t = "car"`:

1. Lengths match (`3 == 3`), continue.
2. `countS = {r:1, a:1, t:1}`
3. `countT = {c:1, a:1, r:1}`
4. `countS == countT` → `false`, because `t` isn't a key in `countT` and `c`
   isn't a key in `countS`.

## Complexity

- **Time:** O(n) — one pass to build each frequency table (`n` = string
  length), plus O(k) to compare tables where `k` is the number of distinct
  characters (bounded by the alphabet, so effectively O(1) for that part).
- **Space:** O(k) for the two dictionaries — bounded by alphabet size
  (e.g. 26 for lowercase English letters), so effectively O(1) auxiliary
  space for fixed-alphabet inputs, O(k) in general (e.g. Unicode input).

## The pattern to carry forward

**"Compare multiset of characters, not order or position"** → build a
frequency map and compare/merge maps. You'll see this exact shape reused in:

- Group Anagrams (49) — group strings that share a frequency signature
- Ransom Note (383) — one frequency map "covers" another
- Find All Anagrams in a String (438) — this pattern *inside* a sliding
  window
