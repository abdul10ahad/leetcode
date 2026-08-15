# Day 1 — 242. Valid Anagram

**Pattern:** Frequency counting with a hash map — the pattern that Group Anagrams,
Longest Repeating Character Replacement, and Minimum Window Substring all build on.

**Problem:** Given two strings `s` and `t`, return `true` if `t` is an anagram of `s`
(same characters, same counts, any order).

## Step-by-step reasoning

1. **Cheap rejection first.** Two strings can only be anagrams if they have the
   same length — if they don't, stop immediately without touching the characters.
   This turns the worst case (two long, unrelated strings) into O(1).

2. **Turn "same characters, same counts" into "same map".** An anagram check is
   really an equality check on *multisets*. The natural Swift representation of a
   multiset is `[Character: Int]` — key is the character, value is how many times
   it appears. Build one for `s` and one for `t`.

3. **Build the frequency map functionally.** Instead of a hand-rolled `for` loop
   with a `var` dictionary, fold the string into the dictionary with
   `reduce(into:)`. It's the same O(n) work, but it reads as "accumulate counts"
   rather than "loop and mutate":

   ```swift
   let countS = s.reduce(into: [Character: Int]()) { counts, char in
       counts[char, default: 0] += 1
   }
   ```

   `subscript(_:default:)` avoids the `if let / else` dance for first-seen
   characters — it's Swift's built-in way to say "increment, or start at 0".

4. **Compare the maps directly.** `Dictionary` is `Equatable` whenever its
   `Value` is `Equatable` (`Int` is), so `countS == countT` checks — in one
   expression — that both maps have exactly the same keys *and* the same counts
   for each key. No manual iteration over keys needed.

5. **Why this beats sorting.** A `s.sorted() == t.sorted()` one-liner also works
   and is a fine fallback (kept below as an alternate implementation), but it's
   O(n log n). Counting characters is O(n) time and O(k) space, where k is the
   number of distinct characters (at most 26 for lowercase letters) — strictly
   better as strings get longer.

## Solution (modern Swift)

```swift
final class ValidAnagram {
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
}
```

- **Time:** O(n) — one pass to build each map, one O(k) map comparison.
- **Space:** O(k) — at most one entry per distinct character.

## Flow trace

`s = "anagram"`, `t = "nagaram"`

| step | countS so far | countT so far |
|---|---|---|
| after 'a'/'n' | `[a:1]` | `[n:1]` |
| after 'n'/'a' | `[a:1, n:1]` | `[n:1, a:1]` |
| ... | ... | ... |
| final | `[a:3, n:1, g:1, r:1, m:1]` | `[n:1, a:3, g:1, a:1... ]` → same totals |

Both maps end up `{a: 3, n: 1, g: 1, r: 1, m: 1}` → equal → `true`.

If instead `t = "nagara"` (one character short), the length guard in step 1
catches it before any counting happens.
