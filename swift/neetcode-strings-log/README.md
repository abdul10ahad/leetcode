# NeetCode Strings — Daily Swift Practice Log

This is the canonical progress log for the "learn algorithms through NeetCode
string problems" daily routine. Check this file **before** picking the next
problem so the routine doesn't re-teach something already covered.

## ⚠️ Continuity issue (still open as of 2026-09-09)

This routine's scheduled sessions each get a **brand-new git branch off
`main`**, and as far as this log can tell, **none of them have ever been
merged**. Any progress log written to one of those branches is invisible to
the next day's session unless that next session happens to go digging
through unmerged remote branches (which is how this file's numbers were
reconstructed on 2026-09-01 and updated again today).

Net effect so far (reconstructed from ~59 daily branches, 2026-07-12 through
2026-09-08):

| Problem | LeetCode # | Times taught |
|---|---|---|
| Longest Palindromic Substring | 5 | ~26 |
| Valid Anagram | 242 | ~16 |
| Valid Palindrome | 125 | 3 |
| Group Anagrams | 49 | 2 |
| Permutation in String | 567 | 2 |
| Longest Substring Without Repeating Characters | 3 | 2 |
| Reverse String | 344 | 1 |
| Palindromic Substrings | 647 | 1 |
| Longest Common Prefix | 14 | 1 |

**This file itself was already written once before, on 2026-09-01, on branch
`claude/ecstatic-goldberg-upr4sw` — and it made no difference.** At least one
run after that date (2026-09-08, branch `claude/ecstatic-goldberg-vll4hz`)
taught Longest Palindromic Substring yet again, because it never saw this
log. Writing this file is necessary but not sufficient — it only helps if a
future run's branch is a descendant of a branch that has it, or if it gets
merged to `main`.

### Recommendation (unchanged, repeating it because it hasn't been acted on)

Pick one:
1. Merge this log (or a PR containing it) into `main`, so every future daily
   branch starts from a branch that already knows what was taught, **or**
2. Point the scheduled task at one single persistent branch instead of a
   fresh throwaway branch per run, **or**
3. Store the tracker somewhere outside git entirely (e.g. a note the
   scheduling system itself persists across runs).

Until one of these happens, expect the repetition to continue. Claude cannot
open/merge a PR here on its own initiative (repo policy requires the user to
ask for one explicitly) — this needs a human decision.

## Day log

| Date | Problem | LeetCode # | Pattern | File |
|---|---|---|---|---|
| 2026-09-01 | Group Anagrams | 49 | Hashing / grouping | `0049-group-anagrams.swift` |
| 2026-09-09 | Longest Repeating Character Replacement | 424 | Sliding window (variable size) | `0424-longest-repeating-character-replacement.swift` |

## Suggested next problems (not yet covered by this routine)

- Minimum Window Substring (76) — sliding window, advanced
- Valid Parentheses (20) — stack
- Encode and Decode Strings (271) — design / string protocol
- String to Integer atoi (8) — careful parsing / edge cases
- Multiply Strings (43) — string math, no built-in bignum
- Reverse Words in a String (151) — in-place-style manipulation
- Decode String (394) — stack, nested structure
- Isomorphic Strings (205) — hashing / bijection
